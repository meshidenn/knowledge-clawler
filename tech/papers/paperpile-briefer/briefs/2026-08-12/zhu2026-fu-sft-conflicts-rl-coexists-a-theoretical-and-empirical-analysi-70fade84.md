# Paperpile Brief 2026-08-12 - SFT conflicts, RL coexists: A theoretical and empirical analysis of multi-task learning for LLMs

## 基本情報

- **タイトル**: SFT conflicts, RL coexists: A theoretical and empirical analysis of multi-task learning for LLMs
- **著者**: Kejian Zhu, Zhuoran Jin, Shangqing Tu, Hongbang Yuan, Yushi Bai, Kang Liu, Juanzi Li, Jun Zhao
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2608.03573 / PDF: https://arxiv.org/pdf/2608.03573.pdf / arXiv: `2608.03573`

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのマルチタスク後段学習で、SFTはタスク間干渉を起こしやすい一方、RLは疎でほぼ直交する更新になり複数タスクが共存しやすい、という現象を実験と理論で説明した論文。
- **先行研究と比べてどこがすごい？**: 単一タスクでのSFT/RL比較ではなく、multi-stage / mixed-dataのマルチタスク設定に焦点を当てている。DeepSeek-R1-Distill-Qwen系を使い、Math・Science・Logic・Codeで比較し、multi-stage SFTは性能崩壊するがmulti-stage RLは累積的に改善することを示す。さらに、パラメータ更新のノルム・疎性・cosine similarityまで掘り下げ、SFT干渉はnorm-limited、RL干渉はadvantage正規化とon-policy性に由来するvariance-limitedだと理論化している。
- **技術や手法の肝はどこ？**: SFTの勾配はexpert分布へのoff-policyな模倣で、更新量が大きく密になりやすい。一方RLの勾配は現在policyからのrolloutにadvantageを掛ける形なので、更新が小さく疎になり、タスクごとの更新方向が高次元空間でほぼ直交する、という見立てが中心。これを使って、各タスクを独立にRLし、得られた更新 `ΔW_i` を後でmergeするParallel-RLを提案している。
- **どうやって有効だと検証した？**: PDF本文を主根拠とすると、DeepSeek-R1-Distill-Qwen-1.5Bと7Bをベースに、MATH500、AIME2025、MMLU、GPQA、Knights & Knaves、LiveCodeBenchなどで評価。予備実験ではmulti-stage SFTがbase比で平均低下し、multi-stage RLは改善。単一タスク学習でも、SFTは対象タスクを上げる代わりに未学習タスクを下げ、RLは対象タスク改善と他タスク維持を両立しやすい。さらに更新ベクトル解析で、RLの更新ノルムがSFTより2桁以上小さく、タスク間cosine similarityもSFTより大幅に小さいことを示している。Parallel-RLでは、naive merge、TIES、SVD、少量データでのpost-merge adaptationを比較し、Adapted Parallel-RLが強い結果を出している。
- **議論はある？**: 実験は主にreasoning系4領域とDeepSeek-R1-Distill-Qwen系に寄っており、一般のinstruction following、安全性、対話品質、長期エージェント行動でも同じ直交性が成立するかは未確認。PDF抽出上、細かい数値は断定しすぎない方がよい。また、Parallel-RLは「mergeすればよい」だけではなく、並列化に向くタスク選択、各タスクのRL設計、merge後の軽いadaptationが必要で、実運用コストやreward設計の難しさは残る。
- **次に読む/試すなら**: 1. 自分のRLVR実験で、タスク別LoRA更新のノルムとcosine similarityを測る。 2. SFTとGRPOで同じ4タスクのcontinual trainingを小規模再現する。 3. Parallel-RLの`sum` mergeと少量adaptationをLoRAで試し、タスクを外したablationを行う。
- **キーワード**: `multi-task learning`, `SFT`, `reinforcement learning`, `GRPO`, `gradient interference`, `Parallel-RL`, `model merging`, `catastrophic forgetting`

## 気になったこと

- RLの「ほぼ直交する更新」は、rewardが明確なreasoning/RLVRだから成立しているのか、曖昧な嗜好最適化や安全性学習でも成立するのか。
- SFTの崩壊はmulti-stage順序、学習率、データ量、LoRA rank、regularizationでどこまで緩和できるのか。
- Parallel-RLのmerge関数は、単純和・平均・TIES・SVD以外に、Fisher重み付けやtask arithmetic系で改善する余地がありそう。
- 「RL coexists」は能力の共存を見ているが、出力スタイルや推論長、verbosity、format followingの干渉も別途測る必要がある。
- 関連研究として、continual post-training、RLVR forgetting、LoRA task vector merging、gradient surgeryとの接続を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhu2026-fu-sft-conflicts-rl-coexists-a-theoretical-and-empirical-analysi-70fade84.md](../../chat/2026-08-12/zhu2026-fu-sft-conflicts-rl-coexists-a-theoretical-and-empirical-analysi-70fade84.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
