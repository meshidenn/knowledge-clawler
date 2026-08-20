# Paperpile Brief 2026-08-21 - LEGO-RL: Harness-native reinforcement learning for coding agents

## 基本情報

- **タイトル**: LEGO-RL: Harness-native reinforcement learning for coding agents
- **著者**: Yiming Du, Yuxin Jiang, Tao Yuan, Jianbo Dai, Shaowei Wang, Jierun Chen, Chaofan Tao, Xianzhi Yu, Lifeng Shang, Kam-Fai Wong, Xiaohui Li, Haoli Bai
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.17393v1](https://arxiv.org/abs/2608.17393v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 既存のコーディングエージェントの制御フローを改変せず、Claude Code・OpenHands・OpenCodeをそのまま強化学習（RL）で訓練可能にする基盤を提案した。
- **先行研究と比べてどこがすごい？**: 従来はRLフレームワーク側のインターフェースにエージェントを合わせる必要があったのに対し、モデルAPI境界で介入して既存harnessを保持する。トークン列・MoEのexpert routingをrollout時と訓練時で整合させつつ、sandbox、報酬ハック対策、監視UIまで統合した。SWE-bench VerifiedでQwen3.5-35B-A3BをOpenHands SDKで64.0%→70.4%、Claude Codeで62.4%→68.2%、OpenCodeで57.2%→66.6%へ改善した。
- **技術や手法の肝はどこ？**: in-process LLM proxyが生成時点のtoken ID・log probability・応答mask・MoE routingを捕捉する。harnessの履歴圧縮・再直列化後にログを復元するのではなく、正確に取得した生成トークンだけでGSPOの方策更新を行う。さらに、非同期rollout、失敗軌跡の除外、隔離sandbox、ネットワーク制限・Git履歴隠蔽によって報酬の汚染を抑える。
- **どうやって有効だと検証した？**: OpenSWE由来の2,699タスクで、同一の初期モデル・200k context budgetを用い、3種類のharnessごとに訓練した。SWE-bench Verifiedは訓練集合とrepository・instanceの両方で分離して実行検証した。rollout時とtrainer側で再計算した確率のPearson相関は各harnessで中央値0.998以上で、MoE routing replayにより整合性がさらに改善することも示した。
- **議論はある？**: 実験はQwen3.5-35B-A3Bのみで、各主設定は1回のrunに限られ、分散は未評価。報酬は実行検証による粗い二値であり、中間的な行動へのcredit assignmentはできない。報酬ハック対策も観測済みの失敗モードに対するもので、未知の攻撃への堅牢性は保証しない。sandbox高速化の数値は特定の運用環境に依存する。
- **次に読む/試すなら**:
  1. GitHub公開実装で、proxyがClaude Codeのtool-call再直列化やcontext compactionをどう扱うか確認する。
  2. 小規模なSWE-bench系環境で、生成時token captureあり／なしのRL更新を比較する。
  3. 異なるモデル・複数harness混合訓練で、改善がharness固有かを検証する。
- **キーワード**: `coding agents`, `reinforcement learning`, `SWE-bench Verified`, `agent harness`, `GSPO`, `Mixture-of-Experts`, `trajectory alignment`, `reward hacking`

## 気になったこと

- 本文ではharnessごとに別々に訓練しており、単一の方策を複数harnessで学習させたときの転移性は未検証。
- 確率整合性は高いが、長い軌跡のうちcontext compactionで除外される割合と、それによる学習バイアスを確認したい。
- 2,699件へのタスク選別はQwen3.6-27B＋OpenHandsで行われており、選別時のモデル・harness依存性が他の設定へどこまで影響するかが重要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [du2026-eq-lego-rl-harness-native-reinforcement-learning-for-coding-agent-8710aeef.md](../../chat/2026-08-21/du2026-eq-lego-rl-harness-native-reinforcement-learning-for-coding-agent-8710aeef.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
