# Paperpile Brief 2026-08-21 - Agent Lightning v1.0: Towards Harnessed Agentic RL

## 基本情報

- **タイトル**: Agent Lightning v1.0: Towards Harnessed Agentic RL
- **著者**: Zhiyuan He, Siwei Zhang, Zhiwen Zhou, Yuqing Yang, Yu Kang, Yuge Zhang, Luna K. Qiu, Tin Yan Tsui, Jiahang Xu, Chong Luo
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: メタデータからは不明（DOI、arXiv ID、URLはいずれも未登録）

## 落合陽一フォーマット

- **ひとことでいうと**: 任意のエージェント実行基盤（harness）をLLMのRL後学習に接続する、軽量な「harnessed agentic RL」フレームワークを提案した論文。
- **先行研究と比べてどこがすごい？**: 学習器側ではなくデプロイ時のharnessが環境との対話ループを担う前提を明確化し、任意のエージェントをLLM endpoint proxy経由でRL学習へつなぐ。約3,500行の軽量実装で、指示追従・検索・コーディングエージェントを扱える点が差分。
- **技術や手法の肝はどこ？**: harnessが生成するLLMリクエスト・応答列だけを学習器が観測する分離アーキテクチャ。そのために必要となる再トークン化、サンプル結合、advantage計算、loss正規化、バックエンドのスケジューリングを主要課題として扱う。
- **どうやって有効だと検証した？**: メタデータ上では、instruction-following・search・coding agentで評価し、コーディングエージェントRLの再現可能なパイプラインも提供したとされる。Qwen3.5-9Bは、6K件の学習例と控えめな計算資源でSWE-bench Verifiedが41.8%から56.4%へ改善したと報告している。
- **議論はある？**: PDF本文がないため、各設計選択のアブレーション、評価設定、統計的頑健性、他モデルへの一般化はメタデータからは不明。特にharnessごとの実装差が報酬設計・軌跡結合・学習安定性へ与える影響を確認したい。
- **次に読む/試すなら**:
  - 公開予定の学習スクリプトでSWE-bench用コーディングエージェントRLを最小再現する。
  - 既存エージェントにendpoint proxyを挟み、軌跡の再トークン化とサンプル結合を検証する。
  - verl Uni-Agent、AReaL 2.0、slime、Polarとの設計差を比較する。
- **キーワード**: `agentic RL`, `harnessed agentic RL`, `LLM post-training`, `coding agents`, `SWE-bench`

## 気になったこと

- 本要約はPDF本文ではなくabstractを主根拠としている。
- 6K件の学習データの構成、報酬関数、RLアルゴリズム、計算量の詳細を確認したい。
- 14.6ポイント改善の再現性と、harness固有の工夫がどの程度寄与したかをアブレーションで確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [he2026-aq-agent-lightning-v1-0-towards-harnessed-agentic-rl-ced629bb.md](../../chat/2026-08-21/he2026-aq-agent-lightning-v1-0-towards-harnessed-agentic-rl-ced629bb.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
