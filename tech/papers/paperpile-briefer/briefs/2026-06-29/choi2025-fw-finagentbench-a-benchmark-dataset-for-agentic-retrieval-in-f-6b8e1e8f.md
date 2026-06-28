# Paperpile Brief 2026-06-29 - FinAgentBench: A benchmark dataset for agentic retrieval in financial question answering

## 基本情報

- **タイトル**: FinAgentBench: A benchmark dataset for agentic retrieval in financial question answering
- **著者**: Chanyeol Choi, Jihoon Kwon, Alejandro Lopez-Lira, Chaewoon Kim, Minjae Kim, Juneha Hwang, Jaeseon Ha, Hojun Choi, Suyeol Yun, Yongjin Kim, Yongjae Lee
- **年 / venue**: 2025 / arXiv [cs.IR]
- **リンク**: https://arxiv.org/abs/2508.14052 / arXiv:2508.14052

## 落合陽一フォーマット

- **ひとことでいうと**: 金融QAにおける「どの開示文書を見るべきか」と「その文書内のどの箇所を見るべきか」を、LLMエージェントの多段推論型検索として評価するベンチマーク FinAgentBench を作った論文。
- **先行研究と比べてどこがすごい？**: FinanceBench や FinDER など既存の金融QA/RAG系ベンチマークが検索を固定的なサブルーチンとして扱うのに対し、本論文は検索そのものをLLMの推論対象にしている。文書タイプ選択とチャンク選択を分けて評価し、S&P 500企業、SEC開示、専門家作成クエリ、約26K件の注釈付き例で構成している点が新しい。
- **技術や手法の肝はどこ？**: agentic retrieval を2段階に分解する設計。まず 10-K、10-Q、8-K、earnings transcript、DEF 14A の5種類からクエリに最も関連する文書タイプをランキングし、次に選ばれた文書を段落レベルのチャンクに分けて関連箇所をランキングする。評価は MRR、MAP、nDCG を使い、チャンクは 0/1/2 の段階的関連度で専門家が注釈する。
- **どうやって有効だと検証した？**: GPT-o3、Claude Opus 4、Claude Sonnet 4 をゼロショットで評価し、文書タイプランキングでは全モデルが比較的高性能、特に Claude Sonnet 4 が nDCG@5 0.783、MAP@5 0.849、MRR@5 0.892 と報告されている。一方、チャンクランキングは難しく、最高でも nDCG@5 約0.419程度。さらに GPT-o4-mini に強化学習型ファインチューニングを行い、文書ランキング・チャンクランキング双方で改善を示している。
- **議論はある？**: 文書タイプ選択は強いが、文書内の細粒度チャンク検索はまだ弱い。評価対象は主にS&P 500企業とSEC開示に限定され、他市場、非定型資料、リアルタイムニュース、表や数値推論を含む複雑QAへの一般化は未検証。PDF抽出本文からは、データセット公開範囲やライセンス、注釈者間一致率の詳細は十分には確認できない。
- **次に読む/試すなら**: FinAgentBench のデータと評価コードが公開されているか確認する。既存RAGパイプラインで「文書タイプ分類→チャンクランキング」の2段階検索を再現する。FinDER、FinanceBench、DocFinQA と評価設定を比較する。
- **キーワード**: `agentic retrieval`, `financial QA`, `LLM benchmark`, `SEC filings`, `generative retrieval`, `ranking evaluation`

## 気になったこと

- chunk-level ranking の難しさが、長文コンテキスト制限、金融知識不足、プロンプト形式、チャンク分割品質のどれに最も起因するのか。
- 文書タイプを5種に固定した設計は実務的だが、ニュース、IR資料、プレゼン資料、決算補足資料を入れた場合に同じ枠組みで拡張できるか。
- 「検索のみ」の評価と、最終的な回答生成品質との相関がどれくらいあるのか。
- 強化学習型ファインチューニングのデータ量、報酬設計、再現可能性の詳細を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [choi2025-fw-finagentbench-a-benchmark-dataset-for-agentic-retrieval-in-f-6b8e1e8f.md](../../chat/2026-06-29/choi2025-fw-finagentbench-a-benchmark-dataset-for-agentic-retrieval-in-f-6b8e1e8f.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
