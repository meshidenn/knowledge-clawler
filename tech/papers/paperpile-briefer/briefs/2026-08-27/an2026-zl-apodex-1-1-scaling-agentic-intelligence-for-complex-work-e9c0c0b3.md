# Paperpile Brief 2026-08-27 - Apodex 1.1: Scaling agentic intelligence for complex work

## 基本情報

- **タイトル**: Apodex 1.1: Scaling agentic intelligence for complex work
- **著者**: Apodex Team（メタデータには個人著者一覧も収録）
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.23283v2](https://arxiv.org/abs/2608.23283v2)（DOIはメタデータからは不明）

## 落合陽一フォーマット

- **ひとことでいうと**: 長時間・複数ツール・複数エージェントにまたがる「仕事を完了する能力」を、実行環境と協調行動の両面からスケールさせるエージェント基盤・モデルの技術報告。
- **先行研究と比べてどこがすごい？**: 単発の推論やツール呼び出しではなく、状態保持、失敗復旧、成果物の検証・納品までを一つの能力として扱う。固定ロールのマルチエージェントではなく、タスクに応じて分解・委譲・再計画する協調を学習対象にしている点が差分。
- **技術や手法の肝はどこ？**: (1) ファイル・検索・コードの実行可能かつ検証可能な環境を増やす *Environment Scaling*、(2) タスクボードを外部状態として保持し、非同期委譲・限定的な検証・再計画を行う *Agentic Coordination Scaling*、(3) provenance・ワークスペース・成果物を永続管理する AgentOS を統合する。検証は生成を丸ごと再実行させず、特定の主張・証拠・納品条件に絞る「非対称検証」を採る。
- **どうやって有効だと検証した？**: PDF本文の比較図では、専門業務、金融、科学研究、一般推論・検索に加え、数学・コーディングを含むベンチマークで評価している。ReAct構成と Agent Team 構成を分け、協調による上積みも測る設計で、FrontierFinance・FrontierScience-Researchなどで強い結果を報告する。35Bパラメータの Mini 版も評価対象としている。
- **議論はある？**: 報告は技術チーム自身によるもので、学習データの規模・モデル詳細・計算資源・外部第三者による再現結果は、取得できたPDF抽出範囲からは不明。評価の一部には内部評価も含まれるため、ベンチマーク汚染、ツール環境への過適合、マルチエージェント化に伴うコスト対性能の検証が重要。
- **次に読む/試すなら**:
  1. AgentOSと FrontierAgent の公開実装を読み、Task Board・provenance・成果物検証の境界を確認する。
  2. 単一エージェントと、限定検証付きの並列サブエージェントで、同一のファイル／検索タスクを比較する。
  3. 実行時間・トークン・ツール呼び出しを含めた費用対完了率を独自タスクで測る。
- **キーワード**: `agentic intelligence`, `long-horizon agents`, `multi-agent coordination`, `tool use`, `verifiable environments`, `AgentOS`

## 気になったこと

- 「有用な協調作業量」をどう定量化し、単純な並列サンプリングとの差をどこまで切り分けられているか。
- タスクボードと provenance が長期タスクの実際の失敗率・再開可能性をどの程度改善するか。
- 検証役が狭い主張だけを見ることで、主張間の整合性崩れを見逃さないか。
- 公開ベンチマーク外の実務タスクで、環境構築・検証器作成のコストが便益を上回らないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [an2026-zl-apodex-1-1-scaling-agentic-intelligence-for-complex-work-e9c0c0b3.md](../../chat/2026-08-27/an2026-zl-apodex-1-1-scaling-agentic-intelligence-for-complex-work-e9c0c0b3.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
