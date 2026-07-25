# Paperpile Brief 2026-07-26 - Agentic Context Management: Solving agent memory and cost by treating them as lifecycle and architecture problems

## 基本情報

- **タイトル**: Agentic Context Management: Solving agent memory and cost by treating them as lifecycle and architecture problems
- **著者**: Gaurav Dadhich
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: AI agentの記憶・コンテキスト肥大・token cost問題を、単なるstorage/retrievalではなく、ライフサイクルとアーキテクチャの問題として再定義する論文。
- **先行研究と比べてどこがすごい？**: 従来の「必要な情報を保存して検索する」memory framingを狭すぎると批判し、何を覚えるか、どう構造化するか、どのstoreに置くか、いつ忘れるか、今何が必要か、次に何が必要か、budget内にどう圧縮するかまで含む統合的な枠組みとしてAgentic Context Managementを提案している点。
- **技術や手法の肝はどこ？**: ACMを5つのprimitive、すなわち`architecting`, `ingesting`, `scoping`, `anticipating`, `compacting & consolidation`に分解すること。特に、naiveな会話履歴蓄積は会話長に対してtoken costが二次的に増え、雑な要約はコストを線形化しても精度崩壊を招くため、検証付きcompactionでfidelityを保ちながら線形コストにする、という設計思想が中心。
- **どうやって有効だと検証した？**: メタデータ上のabstractでは、参照実装としてMaximem Synapを挙げ、Section 6の設定でLongMemEval 92%、LoCoMo 93.2%を報告している。ただしPDF本文がないため、評価条件、比較対象、ablation、統計的有意性、実装詳細はメタデータからは不明。
- **議論はある？**: PDF未取得のため詳細な限界は不明。ただしabstractから読む限り、既存benchmarkがlatency、token efficiency、context-rot resistanceを十分に捉えていないという問題意識がある。また、組織スコープ階層やdecision-level contextまで扱う場合、privacy、provenance、権限管理、忘却ポリシー、評価設計が弱点になりそう。
- **次に読む/試すなら**: Section 6のMaximem Synap設定と評価手順を確認する。LongMemEval/LoCoMoでの比較対象と入力budget条件を確認する。既存agent memory実装に5 primitiveの観点で差分分析をかける。
- **キーワード**: `agent memory`, `context management`, `compaction`, `LongMemEval`, `LoCoMo`, `token efficiency`

## 気になったこと

- 「validated compaction」が具体的に何を検証しているのか。情報保持、回答精度、provenance、再検索可能性のどれを保証しているのか。
- Maximem Synapが汎用architectureなのか、特定benchmarkに最適化されたserviceなのか。
- 組織スコープ階層でのmemory共有において、アクセス制御や情報漏洩をどう扱うのか。
- context-rot resistanceをどう定義し、どう測るのか。
- 既存のRAG、episodic memory、semantic memory、tool output summarizationとの実質的な差分。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [dadhich2026-tl-agentic-context-management-solving-agent-memory-and-cost-be1b9a06.md](../../chat/2026-07-26/dadhich2026-tl-agentic-context-management-solving-agent-memory-and-cost-be1b9a06.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
