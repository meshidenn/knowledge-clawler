# Chat Prompt 2026-08-21

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {RAG}-{R1}: Incentivizing the search and reasoning capabilities of {LLMs} through multi-query parallelism

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-21 - RAG-R1: Incentivizing the Search and Reasoning Capabilities of LLMs Through Multi-query Parallelism

## 基本情報

- **タイトル**: RAG-R1: Incentivizing the Search and Reasoning Capabilities of LLMs Through Multi-query Parallelism
- **著者**: Zhiwen Tan, Jiaming Huang, Qintong Wu, Hongxuan Zhang, Chenyi Zhuang, Jinjie Gu
- **年 / venue**: 2025 / AAAI-26（メタデータ上は arXiv [cs.CL]）
- **リンク**: [PDF](https://ojs.aaai.org/index.php/AAAI/article/download/40603/44564)

## 落合陽一フォーマット

- **ひとことでいうと**: RAGの検索を逐次1本ずつ行う代わりに、複数クエリを並列発行できるようLLMをSFT＋RLで訓練し、多段QAの精度・頑健性・速度を同時に改善した。
- **先行研究と比べてどこがすごい？**: Search-R1やR1-SearcherなどのRL型検索RAGは単一クエリの逐次探索に依存する。本研究は並列探索へ拡張し、最強ベースライン比で平均最大13.7%改善、推論時間を最大11.1%削減したと報告する。
- **技術や手法の肝はどこ？**: 第1段階で`<think>`→`<search>`→`<information>`→`<answer>`という検索・推論フォーマットをSFTで習得させる。第2段階で検索環境を伴うoutcome-based RLを適用し、難しいが解答可能な問題を選別して訓練する。推論時には複数の検索クエリを並列化し、初手の誤検索への依存を減らす。
- **どうやって有効だと検証した？**: Qwen2.5-7B-Instructを基盤に、NQ、PopQA、TriviaQA、HotpotQA、2WikiMultiHopQA、MuSiQue、Bamboogleの7ベンチマークでExact Matchを比較した。SFT・RL・RL用データ選別のアブレーションも実施し、HotpotQA／2WikiMultiHopQAで検索回数・推論時間を計測した。
- **議論はある？**: 学習はWikipediaを使うローカル検索環境で行われ、オンライン検索での評価規模は限定的である。並列クエリ数、検索APIコスト、コンテキスト長増加時の挙動、検索結果が悪質・矛盾する場合の安全性は本文から十分には不明。
- **次に読む/試すなら**:
  1. 実装コードを確認し、並列クエリの生成・統合・停止条件を追う。
  2. 自分のRAGで単一クエリと並列クエリを比較し、精度だけでなくAPIコストとp95レイテンシを測る。
  3. Search-R1、R1-Searcher、Self-RAGと、誤検索からの回復能力を比較する。
- **キーワード**: `RAG`, `reinforcement learning`, `multi-query parallelism`, `multi-hop QA`, `agentic search`

## 気になったこと

- 並列化で増える検索コスト・取得文書量に対し、精度改善がどの条件で正当化されるか。
- クエリ間の重複を抑制する仕組みと、複数検索結果を統合する際の順位付け・圧縮方法を確認したい。
- 7Bモデルでの結果が、より小さいモデルやドメイン固有コーパスでも再現するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
