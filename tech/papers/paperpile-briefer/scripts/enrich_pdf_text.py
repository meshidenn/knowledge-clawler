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
from pathlib import Path
from typing import Any

from pypdf import PdfReader


DEFAULT_MAX_CHARS = 60000


def resolve_pdf_path(raw_path: str, base_dir: Path | None) -> Path:
    expanded = Path(raw_path).expanduser()
    if expanded.is_absolute() or base_dir is None:
        return expanded
    return base_dir / expanded


def extract_text(path: Path, max_chars: int) -> tuple[str, int]:
    reader = PdfReader(str(path))
    chunks: list[str] = []
    pages_read = 0
    total = 0
    for page in reader.pages:
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


def enrich_paper(paper: dict[str, Any], base_dir: Path | None, max_chars: int) -> dict[str, Any]:
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
            text, pages_read = extract_text(pdf_path, max_chars)
        except Exception as exc:  # pragma: no cover - depends on external PDF parser behavior
            paper["pdf_status"] = f"extract_error: {type(exc).__name__}: {exc}"
            continue
        paper["pdf_path_used"] = str(pdf_path)
        paper["pdf_text"] = text
        paper["pdf_text_chars"] = len(text)
        paper["pdf_pages_read"] = pages_read
        paper["pdf_status"] = "ok" if text else "empty_text"
        return paper

    return paper


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--raw", required=True, help="Daily raw JSON to enrich in place")
    parser.add_argument("--paperpile-base-dir", default="", help="Base dir for relative PDF paths in the Paperpile export")
    parser.add_argument("--max-chars", type=int, default=int(os.environ.get("PDF_TEXT_MAX_CHARS", DEFAULT_MAX_CHARS)))
    args = parser.parse_args()

    raw_path = Path(args.raw)
    data = json.loads(raw_path.read_text())
    base_dir = Path(args.paperpile_base_dir).expanduser() if args.paperpile_base_dir else None

    ok = 0
    for paper in data.get("papers") or []:
        enrich_paper(paper, base_dir, args.max_chars)
        if paper.get("pdf_status") == "ok":
            ok += 1

    data["pdf_enrichment"] = {
        "enabled": True,
        "ok": ok,
        "count": len(data.get("papers") or []),
        "max_chars_per_paper": args.max_chars,
    }
    raw_path.write_text(json.dumps(data, ensure_ascii=False, indent=2))
    print(f"[OK] PDF text extracted for {ok}/{data['pdf_enrichment']['count']} papers")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
