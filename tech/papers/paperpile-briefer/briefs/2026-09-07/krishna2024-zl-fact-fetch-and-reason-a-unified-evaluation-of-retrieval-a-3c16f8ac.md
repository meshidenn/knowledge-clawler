# Paperpile Brief 2026-09-07 - Fact, fetch, and reason: A unified evaluation of retrieval-augmented generation

## 基本情報

- **タイトル**: Fact, fetch, and reason: A unified evaluation of retrieval-augmented generation
- **著者**: Satyapriya Krishna, Kalpesh Krishna, Anhad Mohananey, Steven Schwarcz, Adam Stambler, Shyam Upadhyay, Manaal Faruqui
- **年 / venue**: 2025 / NAACL 2025 Long Papers（Paperpileメタデータ上は2024・arXiv [cs.CL]）
- **リンク**: [PDF（ACL Anthology）](https://aclanthology.org/2025.naacl-long.243.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: RAGを「正しい事実の取得・複数文書をまたぐ推論・最終回答の正確性」まで一気通貫で測るための824問のベンチマーク、FRAMESを提案した論文。
- **先行研究と比べてどこがすごい？**: TruthfulQA、HotpotQA、GSM8Kなどが個別能力を主に測るのに対し、FRAMESはWikipediaの2〜15記事を横断し、数値・表・時間・複数制約・後処理を組み合わせた実運用寄りのRAG評価にした。Gemini 1.5 Proは検索なしで0.408、検索計画つき反復検索で0.66まで改善した。
- **技術や手法の肝はどこ？**: 人手で作成・検証した多段質問に対し、LLMが各反復で複数の検索クエリを生成し、BM25でWikipedia記事を追加取得する。検索クエリの重複回避と段階的な計画例を与えることで、誤った探索軌道への固定を抑える設計である。
- **どうやって有効だと検証した？**: Gemini 1.5 Pro／Flash、Gemma 2 27B、Llama 3.2 3B、Qwen 2.5 3Bを評価した。Gemini 1.5 Proでは、検索なし0.408、BM25上位2文書で0.452、上位4文書で0.474、正解記事を全投入するOracle設定で0.729。5反復・各5クエリ・各クエリ上位10文書の検索計画つき設定で0.66を達成した。
- **議論はある？**: データ源がWikipediaのため事前学習データ汚染の可能性が残る。また、Oracle設定でも0.729に留まり、取得を完全にしても数値・表・後処理推論が難所である。反復検索は最大6回の逐次推論を要し計算コストが高く、誤った初期仮説から探索を回復できないケースもある。
- **次に読む/試すなら**:
  1. FRAMESで既存RAGの「検索再現率」と「最終正答率」を分けて測る。
  2. BM25とdense retriever／rerankerを差し替え、同じ検索計画で比較する。
  3. 数値・表・時間推論にツール実行や検証器を加え、Oracle設定で残る誤答を分析する。
- **キーワード**: `RAG`, `FRAMES`, `multi-hop QA`, `retrieval planning`, `BM25`, `LLM evaluation`

## 気になったこと

- 正解記事をすべて与えたOracle設定でも誤る問題を、取得失敗ではなく推論・文脈統合・回答形式のどれに帰属できるか。
- 自動採点は人手評価と高い一致を報告するが、自由形式回答・部分正解・推論過程の正しさをどこまで評価できるか。
- Wikipedia以外の専門文書、更新頻度の高い情報、ノイズや矛盾を含む企業内ナレッジでも同じ改善が再現するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [krishna2024-zl-fact-fetch-and-reason-a-unified-evaluation-of-retrieval-a-3c16f8ac.md](../../chat/2026-09-07/krishna2024-zl-fact-fetch-and-reason-a-unified-evaluation-of-retrieval-a-3c16f8ac.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
