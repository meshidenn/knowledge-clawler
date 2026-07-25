# Paperpile Brief 2026-07-26 - {SEED}: Self-Evolving On-Policy Distillation for agentic reinforcement learning

## 基本情報

- **タイトル**: {SEED}: Self-Evolving On-Policy Distillation for agentic reinforcement learning
- **著者**: Jinyang Wu, Shuo Yang, Zhengxi Lu, Fan Zhang, Yuhao Shen, Lang Feng, Haoran Luo, Zheng Lian, Shuai Zhang, Zhengqi Wen, Jianhua Tao
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.14777v1 / arXiv:2607.14777v1

## 落合陽一フォーマット

- **ひとことでいうと**: 長期タスクを解くLLM agentのRLで、完了済みtrajectoryから「後知恵スキル」を生成し、その効果をtoken-levelのdense supervisionとしてpolicyに蒸留するSEEDを提案した論文。
- **先行研究と比べてどこがすごい？**: 通常のoutcome-based RLは最終報酬が疎で、途中の行動にcredit assignmentしにくい。SEEDは現在のpolicy自身がtrajectoryを集め、同じpolicyがそれを分析してskillを作るため、静的なskill bankや推論時prompt追加ではなく、policyの変化に同期したon-policyな自己進化型distillationになっている。
- **技術や手法の肝はどこ？**: 2段構成。まずHindsight Skill SFTで、完了trajectoryから再利用可能なworkflow・重要観察・失敗回避ルールを自然言語skillとして出す能力を学習する。次にRL中、同じcheckpointをactor兼analyzerとして使い、通常contextとskill付与contextで同じsampled actionを再スコアし、skillによるlog-probability shiftをconfidence gate付きOPD lossに変換する。最終lossはGRPO系のoutcome RL lossとOPD lossの和。
- **どうやって有効だと検証した？**: ALFWorld、WebShop、Search-based QAで評価。backboneはQwen2.5-3B-Instruct、Qwen2.5-7B-Instruct、Qwen3-1.7B-Instruct。Vanilla、Skill-Prompt、GRPO、Skill-GRPO、OPSD、GRPO+OPSD、Skill-SD、RLSD、SDARと比較し、多くのaggregate metricでSEEDが最良または同等。ALFWorldではGRPO比でmacro-averageが大きく改善し、WebShopやSearch-based QAでも改善。sample efficiency、unseen splitへのgeneralization、ablationも報告している。
- **議論はある？**: 初期SFTでは外部analyzerとしてGLM-5.2を使っており、完全な自己完結ではない。skill生成品質に依存する可能性がある。評価はagentic benchmark中心で、実世界のtool環境や安全性、誤ったhindsight skillが蓄積する場合の挙動は本文からは十分に分からない。PDF抽出上、細かい数値表は一部レイアウト崩れがあるため断定しすぎない方がよい。
- **次に読む/試すなら**: SEEDのGitHub実装を確認する。小さなALFWorld相当環境でGRPO + hindsight skill OPDの最小再現を作る。SDAR、Skill-SD、RLSDとのloss設計差分を読む。
- **キーワード**: `agentic RL`, `on-policy distillation`, `hindsight skill`, `LLM agents`, `GRPO`, `credit assignment`

## 気になったこと

- skillを自然言語で生成することが本当に最適か、structured skillやprogrammatic memoryにした場合との差。
- 誤ったtrajectory分析がteacher signalになる場合、confidence gateだけで十分に抑制できるのか。
- 外部analyzerで作った初期SFTデータの品質・コスト・モデル依存性。
- 推論時にskill promptを使わない利点は明確だが、訓練時computeはどれくらい増えるのか。
- Search-based QAでの改善幅はALFWorldほど大きくないため、どの種類のagent taskで最も効くのかを切り分けたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [wu2026-he-seed-self-evolving-on-policy-distillation-for-agentic-reinforc-3989450c.md](../../chat/2026-07-26/wu2026-he-seed-self-evolving-on-policy-distillation-for-agentic-reinforc-3989450c.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
