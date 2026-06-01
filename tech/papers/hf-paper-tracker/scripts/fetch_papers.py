# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "requests>=2.32.5",
# ]
# ///
"""
HF Daily Papers データ取得（LLM呼び出しなし）
HF API → JSON に保存するだけ
"""

import json
import os
import sys
from datetime import datetime, timezone, timedelta

import requests

JST = timezone(timedelta(hours=9))
TODAY = datetime.now(JST).strftime("%Y-%m-%d")
RAW_DIR = os.environ.get("DAILY_RAW_DIR", "papers/daily/raw")
OUTPUT_PATH = f"{RAW_DIR}/{TODAY}.json"


def fetch_daily_papers() -> list[dict]:
    """Hugging Face Daily Papers API から論文を取得"""
    url = "https://huggingface.co/api/daily_papers"

    for attempt_url in [url, f"{url}?date={TODAY}"]:
        try:
            resp = requests.get(attempt_url, timeout=30)
            resp.raise_for_status()
            papers = resp.json()
            if papers:
                break
        except Exception as e:
            print(f"[WARN] {attempt_url} failed: {e}")
            papers = []

    results = []
    for p in papers:
        paper = p.get("paper", p)
        results.append({
            "title": paper.get("title", "Unknown"),
            "arxiv_id": paper.get("id", ""),
            "summary": paper.get("summary", ""),
            "authors": [a.get("name", "") for a in paper.get("authors", [])[:5]],
            "upvotes": p.get("paper", {}).get("upvotes", p.get("upvotes", 0)),
        })

    return results


def main():
    if os.path.exists(OUTPUT_PATH):
        print(f"[SKIP] {OUTPUT_PATH} already exists")
        sys.exit(0)

    papers = fetch_daily_papers()
    print(f"[INFO] Fetched {len(papers)} papers")

    if not papers:
        print("[ERROR] No papers fetched")
        sys.exit(1)

    os.makedirs(RAW_DIR, exist_ok=True)
    with open(OUTPUT_PATH, "w") as f:
        json.dump({"date": TODAY, "count": len(papers), "papers": papers}, f, ensure_ascii=False, indent=2)

    print(f"[OK] Saved to {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
