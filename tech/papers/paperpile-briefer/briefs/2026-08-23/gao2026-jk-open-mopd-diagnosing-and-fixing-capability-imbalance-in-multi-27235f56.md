# Paperpile Brief 2026-08-23 - Open-MOPD: Diagnosing and Fixing Capability Imbalance in Multi-Teacher On-Policy Distillation

## 基本情報

- **タイトル**: Open-MOPD: Diagnosing and Fixing Capability Imbalance in Multi-Teacher On-Policy Distillation
- **著者**: Huan-Ang Gao, Haohan Chi, Yong Yan, Shiyuan Feng, Hanlin Wu, Zheng Jiang, Bingxiang He, Wei-Ying Ma, Ya-Qin Zhang, Hao Zhou
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2608.19098](https://arxiv.org/abs/2608.19098) / [PDF](https://arxiv.org/pdf/2608.19098.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: 複数のRL専門教師を単一LLMへ蒸留する際の失敗は勾配競合よりも「各ドメインに割り当てられるトークン単位の最適化予算の偏り」にあり、それを補正するOpen-MOPDを提案した論文。
- **先行研究と比べてどこがすごい？**: 正解ドメインラベルによるoracle routingでルーティング誤差を除外し、能力統合そのものの失敗を切り分けた。通常のM-OPDはRouteRLに対する改善余地の35.6%しか回復しないのに対し、提案法は83.4%まで改善した。
- **技術や手法の肝はどこ？**: (1) 応答長に左右されないよう損失重みを調整するtoken-share balancing、(2) 教師との残余ギャップが大きいドメインへ更新予算を動的配分するgap-aware allocation、(3) 複数PPO更新中に古くなる学生側報酬を再計算するstudent reward refresh、の3点を組み合わせる。
- **どうやって有効だと検証した？**: SmolLM3-3B-Baseを起点に、数学・コード・instruction followingの3専門教師を構築し、AIME24/25、LiveCodeBench v5/v6、IFEval、IFBenchで評価した。アブレーションでは、token-share balancing、動的配分、報酬更新を順に加え、総合スコアと各ドメインの回復度を測定している。
- **議論はある？**: 実験は3Bモデル・3ドメイン・oracle routingという統制環境が中心であり、実運用の曖昧なルーティング、多数教師、より大きいモデルにも同じ効果が出るかは未検証。また、報酬の大きさを教師―学生ギャップの代理指標にする設計が、他の報酬形式でも妥当かは要確認。
- **次に読む/試すなら**:
  1. 自分の多教師RL蒸留ログで、ドメイン別のprompt比率ではなくgradient token比率を可視化する。
  2. 長短の応答長が混在するタスクでtoken-share balancingのみを最小実装して比較する。
  3. 参照研究のMOPD、AsyncOPD、および単一教師OPDの失敗モードを確認する。
- **キーワード**: `multi-teacher distillation`, `on-policy distillation`, `LLM reinforcement learning`, `optimization budget allocation`, `PPO`, `capability integration`

## 気になったこと

- instruction followingはpromptの20.3%を占めてもgradient tokenは0.99%だったという。データ混合の設計では、サンプル数均等化だけでなく更新トークン量の監視が必須になりそう。
- gap-aware allocationは、短いIFではなくコードへ大きく予算を寄せる局面がある。最終性能の公平性と「未学習ギャップ最大化」の目的が常に一致するか確認したい。
- reward refreshは追加forwardなしとされるが、実装上はPPOのactor forwardから必要な学生確率を正確に取り出せることが前提になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [gao2026-jk-open-mopd-diagnosing-and-fixing-capability-imbalance-in-multi-27235f56.md](../../chat/2026-08-23/gao2026-jk-open-mopd-diagnosing-and-fixing-capability-imbalance-in-multi-27235f56.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
