# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Little brains, big feats: Exploring compact language models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - Little brains, big feats: Exploring compact language models

## 基本情報

- **タイトル**: Little brains, big feats: Exploring compact language models
- **著者**: Dari Baturova, Elena Bruches, Ivan Chernov, Roman Derunets, Arsenii Fomin, Andrey Kostin
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2606.30062 / PDF: https://arxiv.org/pdf/2606.30062.pdf / GitHub: https://github.com/SibNN/SLM-RAG-EVAL

## 落合陽一フォーマット

- **ひとことでいうと**: ロシア語RAGにおける生成器として、小規模言語モデル（SLM）がCPUオンリー・オンデバイス環境でどこまで実用になるかを、複数データセットとLLM-as-a-Judgeで評価した論文。
- **先行研究と比べてどこがすごい？**: RAGのretrievalではなくgeneration段に焦点を当て、1B〜8B級の17モデルをCPU実行前提で比較している点が実用寄り。特にロシア語RAG向けのベンチマーク不足を埋める意図があり、DaNetQA、SberQuAD、RuRAG Test、Grounded-RAG-QA-RU、独自講演QAデータを組み合わせている。
- **技術や手法の肝はどこ？**: 各モデルに同じ取得済みcontextを渡す「Context mode」で生成品質を比較し、Correctness、Answer Relevance、Faithfulnessを複数のjudgeで評価する。judge自体も事前に評価し、GPT-5-mini、Qwen3-8B、GLM-4.7のmulti-judge構成を採用している。
- **どうやって有効だと検証した？**: 17個のSLMとGPT-5-mini baselineを、ロシア語QA/RAGデータセット上で比較。CPUのみ、16GB RAM制約、GGUF対応など実行可能性も条件に入れている。結果として、Qwen3-4B-Instruct-2507-Q5KMは品質と遅延のバランスがよく、Qwen3-8B-Q4KMやGPT-5-miniに近い品質を示した。一方で遅延はモデルごとに大きく異なる。
- **議論はある？**: 評価対象はRAGの生成段に限定され、embeddingやrerankingは検証外。全モデルに同一promptを使っており、モデル別prompt最適化で結果が変わる可能性がある。データはロシア語中心なので他言語への一般化は未検証。独自データセットは非公開で、完全な再現性には制約がある。
- **次に読む/試すなら**: 1. GitHubの評価コードとデータリンクを確認する。 2. Qwen3-4B-Instruct-2507-Q5KMを手元のRAGでCPU推論し、latency/faithfulnessを測る。 3. 同一retrieval条件だけでなく、embedding・rerankerを変えた場合の劣化/改善を見る。
- **キーワード**: `Small Language Models`, `RAG`, `Russian QA`, `LLM-as-a-Judge`, `CPU inference`, `on-device AI`, `Qwen3`, `GGUF`

## 気になったこと

- GPT-5-miniやGPT-5など、論文内で使われているモデル名・時点の再現可能性を追加確認したい。
- proprietary datasetが非公開なので、公開データだけで同じ順位傾向が再現するかを見たい。
- 「選択されたSLMがLLMを品質で上回る」という結論は、judge構成・prompt・ロシア語特化性に依存していないか確認が必要。
- latency比較は50サンプルの縮小セットなので、長文contextや実運用負荷での分散も測りたい。
- No-context baselineでGPT-5-miniのCorrectnessが下がる点は、データセットが外部context依存であることの確認として重要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
