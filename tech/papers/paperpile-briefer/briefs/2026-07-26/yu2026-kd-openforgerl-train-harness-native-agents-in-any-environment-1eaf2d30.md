# Paperpile Brief 2026-07-26 - OpenForgeRL: Train harness-native agents in any environment

## 基本情報

- **タイトル**: OpenForgeRL: Train harness-native agents in any environment
- **著者**: Xiao Yu, Baolin Peng, Ruize Xu, Hao Zou, Qianhui Wu, Hao Cheng, Wenlin Yao, Nikhil Singh, Zhou Yu, Jianfeng Gao
- **年 / venue**: 2026 / arXiv [cs.AI]（ICLR 2026 under review）
- **リンク**: https://arxiv.org/abs/2607.21557 / https://arxiv.org/pdf/2607.21557.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: Claude Code、Codex、OpenClaw のような複雑な推論ハーネスをそのまま使い、任意の環境で agent を end-to-end RL 訓練するための open-source framework を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の open RL stack は単純な single-turn や軽量 tool-use を前提にしがちで、stateful / multi-process な harness 推論を直接扱えない。OpenForgeRL は training と harness inference を proxy と remote container orchestration で分離し、train-deploy mismatch を減らす点が新しい。Claw 系と GUI 系の複数 benchmark で、同規模 open baseline を概ね上回り、GUI ではより大きなモデルに匹敵または上回ると報告している。
- **技術や手法の肝はどこ？**: 軽量 proxy が harness からの model call を inference server に中継しつつ prompt-response pair を記録し、rollout 完了後に標準 RL framework で使える trajectory に再構成する。さらに Kubernetes orchestrator が各 rollout を独立した remote container pod として起動し、CPU / memory を要する環境実行を training GPU node から切り離す。RL backend には veRL などを使える設計で、GRPO 系の group-based 最適化も想定している。
- **どうやって有効だと検証した？**: PDF本文によると、tool/claw agent と multimodal GUI browser/computer-use agent の両方で評価している。OpenForge-Claw は ClawEval で 31.7 pass^3 / 55.9 pass@3、QwenClawBench で 33.7、MCPAtlas で 28.1 と報告。OpenForge-GUI は OSWorld-Verified で 37.7、Online-Mind2Web で 63.0、WebVoyager で 72.3 と報告されている。訓練には数百から数千タスクを使い、ZeroClaw、OpenClaw、Codex、ReACT、Kimi-Agent、Molmo-Web など複数 harness を扱っている。
- **議論はある？**: harness によって学習の難しさが大きく異なり、単純で訓練時の仮定と合いやすい harness ほど学びやすいと分析している。RL は self-verification、tool coverage、multi-step plan completion などの agentic reliability を改善する一方、error recovery は依然弱い。数値はPDF抽出テキスト由来で、表や図の細部はレイアウト崩れの可能性があるため、厳密な比較には元PDF確認が必要。
- **次に読む/試すなら**: OpenForgeRL の code / data / model release 状況を確認する。小さい tool-use harness で proxy による trajectory reconstruction を再現する。Codex / OpenClaw / ReACT 間で同一タスクの rollout trace を比較し、harness 差が学習信号にどう出るか見る。
- **キーワード**: `agent RL`, `inference harness`, `Codex`, `OpenClaw`, `Kubernetes rollout`, `veRL`, `GUI agent`, `train-deploy mismatch`

## 気になったこと

- proxy が記録する prompt-response pair だけで、subagent や内部状態をどこまで忠実に学習信号化できるのか。
- terminal reward を各 step に割り当てる設計で、長期タスクの credit assignment がどこまで効くのか。
- Codex のように turn limit が露出しない harness で、wall-clock timeout が training data の bias を生まないか。
- 「any harness x any environment」と言いつつ、実際に新しい harness を足すときの sandbox 実装コストがどれくらいか。
- error recovery が弱い理由が、データ不足、報酬設計、harness 側の状態表現、あるいは評価環境の難しさのどれに起因するのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yu2026-kd-openforgerl-train-harness-native-agents-in-any-environment-1eaf2d30.md](../../chat/2026-07-26/yu2026-kd-openforgerl-train-harness-native-agents-in-any-environment-1eaf2d30.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
