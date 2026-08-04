# Paperpile Brief 2026-08-05 - ExtractBench: A benchmark for schema-guided enterprise document extraction

## 基本情報

- **タイトル**: ExtractBench: A benchmark for schema-guided enterprise document extraction
- **著者**: Boyang Zhang, Adrian Lyjak, Eli Stewart, Zhaoqi Li, Simon Suo
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.29677v1 / arXiv:2607.29677v1

## 落合陽一フォーマット

- **ひとことでいうと**: 企業文書から、ユーザー定義のJSON Schemaに従って値と根拠位置を抽出するシステムを、精度・完全性・grounding・コストまで同時に測るベンチマークを作った論文。
- **先行研究と比べてどこがすごい？**: 固定テンプレート型KIEではなく、schema-guided extractionを対象に、370文書・4,869ページ・8業務ドメイン・67文書タイプを収録している。長大リスト、scan、handwriting、複雑table、word/page-level grounding、ページ単価をまとめて評価する点が新規性。
- **技術や手法の肝はどこ？**: 入力を「文書 + JSON Schema」、出力を「schema-valid JSON + evidence」と定義し、値の正しさをorder-insensitive value F1で評価する。さらに正しい値が正しいページ・word-level boxに紐づいているかをgrounding F1で測る。データ作成は、実文書では複数システムのagreement/adjudication、synthetic long listでは生成時の既知値、scan formでは人手検証を組み合わせる。
- **どうやって有効だと検証した？**: commercial VLM、open-source extraction、coding agent、specialized APIを含む14システムを同一document-schema pairで評価。VLMは短文書では強いが長文書でrecord listをtruncateしやすく、coding agentは高精度だが高コスト。LlamaExtract Agentic Plusがvalue F1、word/page groundingで上位となり、短文書96.6%、長文書94.4%、全体95.6%、8.1セント/pageと報告されている。
- **議論はある？**: groundingが最大の未解決点。VLMやcoding agentは標準ではsource evidenceを返さず、specialized systemでもword-level grounding F1は50%未満に留まる。PDF抽出テキスト由来のため細かい表の全数値は断定しすぎないが、長文書・dense schema・scan・handwriting・巨大tableでシステムごとの劣化傾向が違う点は明確。
- **次に読む/試すなら**: HuggingFace datasetとGitHub evaluation codeを確認する。自分の文書抽出タスクをExtractBench形式の「schema + ground truth + evidence」に落とす。LlamaExtract、Reducto、汎用VLM、coding agentを同一schemaで小規模比較する。
- **キーワード**: `schema-guided extraction`, `document extraction`, `grounding`, `JSON Schema`, `enterprise documents`, `benchmark`, `value F1`, `VLM`

## 気になったこと

- word-level grounding F1が低い原因が、box予測自体なのか、value extraction失敗との積算なのかを分解して見たい。
- 実運用ではschemaの曖昧さが大きいので、schema品質に対する感度評価がどこまで入っているか確認したい。
- LlamaExtract Agentic Plusが強い理由が、探索戦略、chunking、OCR/vision前処理、grounding設計のどこにあるのかを追加で読みたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhang2026-ov-extractbench-a-benchmark-for-schema-guided-enterprise-docum-0551688d.md](../../chat/2026-08-05/zhang2026-ov-extractbench-a-benchmark-for-schema-guided-enterprise-docum-0551688d.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
