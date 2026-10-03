import importlib.util
import unittest
from pathlib import Path
from unittest import mock


ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("enrich_pdf_text", ROOT / "scripts" / "enrich_pdf_text.py")
enrich_pdf_text = importlib.util.module_from_spec(SPEC)
assert SPEC.loader is not None
SPEC.loader.exec_module(enrich_pdf_text)


class EnrichPdfTextTest(unittest.TestCase):
    def test_sanitize_json_value_replaces_lone_surrogates_and_preserves_pairs(self):
        value = {"text": "before\ud800after", "emoji": "\ud83d\ude00"}

        sanitized = enrich_pdf_text.sanitize_json_value(value)

        self.assertEqual(sanitized["text"], "before�after")
        self.assertEqual(sanitized["emoji"], "😀")

    def test_canonical_arxiv_id_from_urls(self):
        self.assertEqual(enrich_pdf_text.canonical_arxiv_id("arXiv:2401.01234v2"), "2401.01234v2")
        self.assertEqual(enrich_pdf_text.canonical_arxiv_id("https://arxiv.org/abs/2401.01234"), "2401.01234")
        self.assertEqual(enrich_pdf_text.canonical_arxiv_id("https://arxiv.org/pdf/2401.01234.pdf"), "2401.01234")

    def test_find_arxiv_id_by_title_uses_exact_normalized_match(self):
        payload = b"""<?xml version="1.0" encoding="UTF-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <entry>
    <id>http://arxiv.org/abs/2601.12345v1</id>
    <title>{SkillOpt}: Executive strategy for self-evolving agent skills</title>
  </entry>
</feed>
"""
        with mock.patch.object(enrich_pdf_text, "read_url", return_value=payload):
            arxiv_id = enrich_pdf_text.find_arxiv_id_by_title(
                "{SkillOpt}: Executive strategy for self-evolving agent skills"
            )

        self.assertEqual(arxiv_id, "2601.12345v1")

    def test_find_pdf_via_openalex_returns_pdf_and_arxiv_id(self):
        payload = b"""{
  "results": [
    {
      "title": "SkillOpt: Executive Strategy for Self-Evolving Agent Skills",
      "doi": "https://doi.org/10.48550/arxiv.2605.23904",
      "primary_location": {
        "landing_page_url": "https://arxiv.org/abs/2605.23904",
        "pdf_url": "https://arxiv.org/pdf/2605.23904"
      },
      "locations": [],
      "ids": {}
    }
  ]
}"""
        with mock.patch.object(enrich_pdf_text, "read_url", return_value=payload):
            pdf_url, arxiv_id = enrich_pdf_text.find_pdf_via_openalex(
                "{SkillOpt}: Executive strategy for self-evolving agent skills"
            )

        self.assertEqual(pdf_url, "https://arxiv.org/pdf/2605.23904")
        self.assertEqual(arxiv_id, "2605.23904")

    def test_resolve_fallback_pdf_sets_arxiv_metadata(self):
        paper = {
            "title": "A Paper",
            "venue": "arXiv [cs.AI]",
            "arxiv_id": "",
            "url": "",
        }
        with mock.patch.object(enrich_pdf_text, "find_pdf_via_openalex", return_value=("", "")):
            with mock.patch.object(enrich_pdf_text, "find_arxiv_id_by_title", return_value="2601.00001"):
                with mock.patch.object(enrich_pdf_text, "download_arxiv_pdf", return_value=Path("/tmp/a.pdf")):
                    pdf, arxiv_id = enrich_pdf_text.resolve_fallback_pdf(paper, Path("/tmp/cache"))

        self.assertEqual(pdf, Path("/tmp/a.pdf"))
        self.assertEqual(arxiv_id, "2601.00001")
        self.assertEqual(paper["arxiv_id"], "2601.00001")
        self.assertEqual(paper["url"], "https://arxiv.org/abs/2601.00001")

    def test_resolve_fallback_pdf_prefers_openalex_pdf(self):
        paper = {
            "title": "A Paper",
            "venue": "arXiv [cs.AI]",
            "arxiv_id": "",
            "url": "",
        }
        with mock.patch.object(enrich_pdf_text, "find_pdf_via_openalex", return_value=("https://arxiv.org/pdf/2601.00001", "2601.00001")):
            with mock.patch.object(enrich_pdf_text, "download_pdf", return_value=Path("/tmp/a.pdf")):
                pdf, arxiv_id = enrich_pdf_text.resolve_fallback_pdf(paper, Path("/tmp/cache"))

        self.assertEqual(pdf, Path("/tmp/a.pdf"))
        self.assertEqual(arxiv_id, "2601.00001")
        self.assertEqual(paper["arxiv_id"], "2601.00001")
        self.assertEqual(paper["url"], "https://arxiv.org/abs/2601.00001")


if __name__ == "__main__":
    unittest.main()
