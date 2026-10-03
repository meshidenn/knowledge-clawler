# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pypdf>=4.0.0",
# ]
# ///
"""Extract text from local paper PDFs and attach it to the daily raw JSON."""

from __future__ import annotations

import argparse
import json
import os
import re
import urllib.error
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Any


DEFAULT_MAX_CHARS = 60000
DEFAULT_MAX_PAGES = 30
ARXIV_API_URL = "https://export.arxiv.org/api/query"
ARXIV_PDF_URL = "https://arxiv.org/pdf/{arxiv_id}.pdf"
OPENALEX_API_URL = "https://api.openalex.org/works"
USER_AGENT = "paperpile-briefer/1.0"


def sanitize_json_value(value: Any) -> Any:
    """JSONを書き込めない不正なサロゲート文字を置換する。"""
    if isinstance(value, str):
        # 正しいサロゲートペアは1文字へ戻し、孤立したものは置換文字にする。
        return value.encode("utf-16", "surrogatepass").decode("utf-16", "replace")
    if isinstance(value, dict):
        return {
            sanitize_json_value(key): sanitize_json_value(item)
            for key, item in value.items()
        }
    if isinstance(value, list):
        return [sanitize_json_value(item) for item in value]
    if isinstance(value, tuple):
        return tuple(sanitize_json_value(item) for item in value)
    return value


def resolve_pdf_path(raw_path: str, base_dir: Path | None) -> Path:
    expanded = Path(raw_path).expanduser()
    if expanded.is_absolute() or base_dir is None:
        return expanded
    return base_dir / expanded


def extract_text(path: Path, max_chars: int, max_pages: int) -> tuple[str, int]:
    from pypdf import PdfReader

    reader = PdfReader(str(path))
    chunks: list[str] = []
    pages_read = 0
    total = 0
    for page in reader.pages[:max_pages]:
        text = page.extract_text() or ""
        pages_read += 1
        if not text.strip():
            continue
        remaining = max_chars - total
        if remaining <= 0:
            break
        chunks.append(text[:remaining])
        total += min(len(text), remaining)
        if total >= max_chars:
            break
    return "\n\n".join(chunks).strip(), pages_read


def normalize_title(value: str) -> str:
    value = re.sub(r"[{}\\]", "", value).lower()
    value = re.sub(r"[^a-z0-9]+", " ", value)
    return re.sub(r"\s+", " ", value).strip()


def canonical_arxiv_id(value: str) -> str:
    value = value.strip()
    value = re.sub(r"^arxiv:", "", value, flags=re.I)
    value = value.removeprefix("https://arxiv.org/abs/")
    value = value.removeprefix("http://arxiv.org/abs/")
    value = value.removeprefix("https://arxiv.org/pdf/")
    value = value.removeprefix("http://arxiv.org/pdf/")
    value = value.removesuffix(".pdf")
    return value.strip()


def read_url(url: str, timeout: float = 20) -> bytes:
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=timeout) as response:
        return response.read()


def arxiv_pdf_url(arxiv_id: str) -> str:
    return ARXIV_PDF_URL.format(arxiv_id=urllib.parse.quote(canonical_arxiv_id(arxiv_id), safe="/."))


def arxiv_id_from_url(value: str) -> str:
    if not value:
        return ""
    match = re.search(r"arxiv[./](?:abs|pdf)/([^?#\s]+)", value, flags=re.I)
    if match:
        return canonical_arxiv_id(match.group(1))
    match = re.search(r"10\.48550/arxiv\.([^?#\s]+)", value, flags=re.I)
    if match:
        return canonical_arxiv_id(match.group(1))
    return ""


def find_pdf_via_openalex(title: str) -> tuple[str, str]:
    normalized_target = normalize_title(title)
    if not normalized_target:
        return "", ""

    query = urllib.parse.urlencode(
        {
            "search": title,
            "per-page": "5",
            "select": "title,doi,primary_location,locations,ids",
        }
    )
    try:
        payload = read_url(f"{OPENALEX_API_URL}?{query}")
        data = json.loads(payload)
    except (OSError, urllib.error.URLError, json.JSONDecodeError):
        return "", ""

    for work in data.get("results") or []:
        if normalize_title(str(work.get("title") or "")) != normalized_target:
            continue
        locations = []
        if isinstance(work.get("primary_location"), dict):
            locations.append(work["primary_location"])
        locations.extend(loc for loc in work.get("locations") or [] if isinstance(loc, dict))

        arxiv_id = arxiv_id_from_url(str(work.get("doi") or ""))
        ids = work.get("ids") if isinstance(work.get("ids"), dict) else {}
        for value in ids.values():
            arxiv_id = arxiv_id or arxiv_id_from_url(str(value))

        for location in locations:
            pdf_url = str(location.get("pdf_url") or "")
            landing_url = str(location.get("landing_page_url") or "")
            arxiv_id = arxiv_id or arxiv_id_from_url(pdf_url) or arxiv_id_from_url(landing_url)
            if pdf_url:
                return pdf_url, arxiv_id
        if arxiv_id:
            return arxiv_pdf_url(arxiv_id), arxiv_id

    return "", ""


def find_arxiv_id_by_title(title: str) -> str:
    normalized_target = normalize_title(title)
    if not normalized_target:
        return ""

    query = urllib.parse.urlencode(
        {
            "search_query": f'ti:"{title}"',
            "start": "0",
            "max_results": "5",
        }
    )
    try:
        payload = read_url(f"{ARXIV_API_URL}?{query}")
    except (OSError, urllib.error.URLError):
        return ""

    root = ET.fromstring(payload)
    namespace = {"atom": "http://www.w3.org/2005/Atom"}
    for entry in root.findall("atom:entry", namespace):
        entry_title = "".join(entry.findtext("atom:title", default="", namespaces=namespace).split())
        target_compact = "".join(title.split())
        if entry_title.lower() == target_compact.lower():
            entry_id = entry.findtext("atom:id", default="", namespaces=namespace)
            return canonical_arxiv_id(entry_id)

    for entry in root.findall("atom:entry", namespace):
        entry_title = entry.findtext("atom:title", default="", namespaces=namespace)
        if normalize_title(entry_title) == normalized_target:
            entry_id = entry.findtext("atom:id", default="", namespaces=namespace)
            return canonical_arxiv_id(entry_id)

    return ""


def download_pdf(pdf_url: str, cache_dir: Path, name_hint: str) -> Path | None:
    if not pdf_url:
        return None
    cache_dir.mkdir(parents=True, exist_ok=True)
    safe_name = re.sub(r"[^A-Za-z0-9._-]+", "_", name_hint).strip("_") or "paper"
    target = cache_dir / f"{safe_name}.pdf"
    if target.exists() and target.stat().st_size > 0:
        return target
    try:
        payload = read_url(pdf_url, timeout=60)
    except (OSError, urllib.error.URLError):
        return None
    if not payload.startswith(b"%PDF"):
        return None
    target.write_bytes(payload)
    return target


def download_arxiv_pdf(arxiv_id: str, cache_dir: Path) -> Path | None:
    arxiv_id = canonical_arxiv_id(arxiv_id)
    if not arxiv_id:
        return None
    return download_pdf(arxiv_pdf_url(arxiv_id), cache_dir, arxiv_id)


def resolve_fallback_pdf(paper: dict[str, Any], cache_dir: Path | None) -> tuple[Path | None, str]:
    if cache_dir is None:
        return None, ""

    arxiv_id = canonical_arxiv_id(str(paper.get("arxiv_id") or ""))
    pdf_url = ""
    if not arxiv_id:
        pdf_url, arxiv_id = find_pdf_via_openalex(str(paper.get("title") or ""))
        if pdf_url:
            name_hint = arxiv_id or normalize_title(str(paper.get("title") or ""))[:80]
            pdf = download_pdf(pdf_url, cache_dir, name_hint)
            if pdf is not None:
                paper["pdf_url"] = pdf_url
                if arxiv_id:
                    paper["arxiv_id"] = arxiv_id
                    if not paper.get("url"):
                        paper["url"] = f"https://arxiv.org/abs/{arxiv_id}"
                return pdf, arxiv_id

    if not arxiv_id and "arxiv" in str(paper.get("venue") or "").lower():
        arxiv_id = find_arxiv_id_by_title(str(paper.get("title") or ""))
        if arxiv_id:
            paper["arxiv_id"] = arxiv_id
            if not paper.get("url"):
                paper["url"] = f"https://arxiv.org/abs/{arxiv_id}"

    if not arxiv_id:
        return None, ""

    pdf = download_arxiv_pdf(arxiv_id, cache_dir)
    return pdf, arxiv_id


def enrich_paper(
    paper: dict[str, Any],
    base_dir: Path | None,
    cache_dir: Path | None,
    max_chars: int,
    max_pages: int,
) -> dict[str, Any]:
    pdf_paths = [str(path) for path in paper.get("pdf_paths") or [] if str(path).strip()]
    paper["pdf_text"] = ""
    paper["pdf_text_chars"] = 0
    paper["pdf_status"] = "not_found" if pdf_paths else "missing_path"

    for raw_pdf_path in pdf_paths:
        pdf_path = resolve_pdf_path(raw_pdf_path, base_dir)
        if not pdf_path.exists():
            continue
        if not pdf_path.is_file():
            continue
        try:
            text, pages_read = extract_text(pdf_path, max_chars, max_pages)
        except Exception as exc:  # pragma: no cover - depends on external PDF parser behavior
            paper["pdf_status"] = f"extract_error: {type(exc).__name__}: {exc}"
            continue
        paper["pdf_path_used"] = str(pdf_path)
        paper["pdf_text"] = text
        paper["pdf_text_chars"] = len(text)
        paper["pdf_pages_read"] = pages_read
        paper["pdf_status"] = "ok" if text else "empty_text"
        return paper

    fallback_pdf, arxiv_id = resolve_fallback_pdf(paper, cache_dir)
    if fallback_pdf is not None:
        try:
            text, pages_read = extract_text(fallback_pdf, max_chars, max_pages)
        except Exception as exc:  # pragma: no cover - depends on external PDF parser behavior
            paper["pdf_status"] = f"fallback_extract_error: {type(exc).__name__}: {exc}"
            return paper
        paper["pdf_path_used"] = str(fallback_pdf)
        paper["pdf_source"] = "arxiv"
        paper["pdf_text"] = text
        paper["pdf_text_chars"] = len(text)
        paper["pdf_pages_read"] = pages_read
        paper["pdf_status"] = "ok" if text else "empty_text"
        if arxiv_id:
            paper["arxiv_id"] = arxiv_id
        return paper

    return paper


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--raw", required=True, help="Daily raw JSON to enrich in place")
    parser.add_argument("--paperpile-base-dir", default="", help="Base dir for relative PDF paths in the Paperpile export")
    parser.add_argument("--pdf-cache-dir", default="", help="Cache dir for downloaded fallback PDFs")
    parser.add_argument("--disable-arxiv-fallback", action="store_true", help="Do not fetch missing PDFs from arXiv")
    parser.add_argument("--max-chars", type=int, default=int(os.environ.get("PDF_TEXT_MAX_CHARS", DEFAULT_MAX_CHARS)))
    parser.add_argument("--max-pages", type=int, default=int(os.environ.get("PDF_TEXT_MAX_PAGES", DEFAULT_MAX_PAGES)))
    args = parser.parse_args()

    raw_path = Path(args.raw)
    data = json.loads(raw_path.read_text())
    base_dir = Path(args.paperpile_base_dir).expanduser() if args.paperpile_base_dir else None
    cache_dir = None
    if not args.disable_arxiv_fallback and os.environ.get("ARXIV_PDF_FALLBACK", "true").lower() == "true":
        cache_dir = Path(args.pdf_cache_dir).expanduser() if args.pdf_cache_dir else raw_path.parent / "pdf-cache" / data.get("date", "unknown")

    ok = 0
    for paper in data.get("papers") or []:
        print(f"[INFO] PDF enrichment: {paper.get('title')}", flush=True)
        enrich_paper(paper, base_dir, cache_dir, args.max_chars, args.max_pages)
        print(
            f"[INFO] PDF status: {paper.get('pdf_status')} chars={paper.get('pdf_text_chars', 0)}",
            flush=True,
        )
        if paper.get("pdf_status") == "ok":
            ok += 1

    data["pdf_enrichment"] = {
        "enabled": True,
        "ok": ok,
        "count": len(data.get("papers") or []),
        "max_chars_per_paper": args.max_chars,
        "max_pages_per_paper": args.max_pages,
        "arxiv_fallback": cache_dir is not None,
    }
    data = sanitize_json_value(data)
    raw_path.write_text(json.dumps(data, ensure_ascii=False, indent=2))
    print(f"[OK] PDF text extracted for {ok}/{data['pdf_enrichment']['count']} papers")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
