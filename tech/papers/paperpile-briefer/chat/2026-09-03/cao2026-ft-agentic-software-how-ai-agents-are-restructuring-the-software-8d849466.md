# Chat Prompt 2026-09-03

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Agentic software: How {AI} agents are restructuring the software paradigm

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-03 - Agentic software: How AI Agents Are Restructuring the Software Paradigm

## 基本情報

- **タイトル**: Agentic software: How AI Agents Are Restructuring the Software Paradigm
- **著者**: Zhenfeng Cao
- **年 / venue**: 2026 / arXiv [cs.SE]
- **リンク**: https://arxiv.org/abs/2606.05608v2

## 落合陽一フォーマット

- **ひとことでいうと**: AIエージェントではコードが静的な成果物ではなく実行時に生成・破棄される推論の道具となり、「ソフトウェアそのもの」の定義が変わると論じる概念・展望論文。
- **先行研究と比べてどこがすごい？**: コーディング支援としてのAIではなく、`AI → Software → Result` から `Agent → Result` への構造転換として整理し、Agent-as-a-Service（AaaS）と「Agentic Engineering」を一つのパラダイムとして位置付けた点。
- **技術や手法の肝はどこ？**: LLMを推論エンジン、ツール群・記憶・計画機構を周辺要素とするエージェントを定義し、目的に応じて計画、コード生成、ツール実行、検証を反復するモデルを提示する。人間はコード作者から、意図・制約を設計し結果を監査する「intent architect」へ移るとする。
- **どうやって有効だと検証した？**: 新規実験ではなく、SWE-bench Verified、EvoClaw、LangChainのマルチエージェント事例など既存のベンチマーク・報告を統合して議論する。単発タスクでは高い性能が報告される一方、継続的なソフトウェア進化では成功率が大きく落ちるというEvoClawの結果を重視する。
- **議論はある？**: 中心的な主張は将来予測・概念整理であり、因果的な新規実証は限定的。LLM能力が計算資源とともに伸び続けるという仮定、引用する事例の一般化可能性、自己進化エージェントの安全性・検証可能性は慎重な検討が必要。継続保守ではコンテキストドリフト、誤りの累積、技術的負債、テストの不完全性が未解決である。
- **次に読む/試すなら**:
  1. EvoClawを読み、単発のissue修正と連続的保守で何が壊れるか確認する。
  2. 小規模リポジトリで、共有メモリ・評価基準・人間承認を備えた複数エージェント開発フローを試す。
  3. 成果物の正しさだけでなく、可観測性・回帰・保守性を測る評価基盤を設計する。
- **キーワード**: `Agentic Engineering`, `LLM agents`, `AaaS`, `multi-agent orchestration`, `continuous software evolution`, `SWE-bench`, `EvoClaw`

## 気になったこと

- 「エージェント自体がソフトウェアである」という定義は有用だが、再現性・監査・責任分界のために、生成されたコードや実行履歴をどこまで永続化すべきか。
- 論文中のマルチエージェントによる工数削減事例は、対象業務・比較条件・失敗率の詳細を一次資料で確認したい。
- Agentic Engineeringを導入する際、モデル性能よりも評価器、権限設計、状態管理がボトルネックになる可能性が高い。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
