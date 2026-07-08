# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {MOPD}: Multi-teacher on-Policy Distillation for capability integration in {LLM} post-training

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - MOPD: Multi-teacher on-Policy Distillation for capability integration in LLM post-training

## 基本情報

- **タイトル**: MOPD: Multi-teacher on-Policy Distillation for capability integration in LLM post-training
- **著者**: Wenhan Ma, Jianyu Wei, Liang Zhao, Hailin Zhang, Bangjun Xiao, Lei Li, Qibin Yang, Bofei Gao, Yudong Wang, Rang Li, Jinhao Dong, Zhifang Sui, Fuli Luo
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2606.30406 / PDF: https://arxiv.org/pdf/2606.30406.pdf / arXiv:2606.30406

## 落合陽一フォーマット

- **ひとことでいうと**: 複数ドメインで別々にRL訓練した教師モデルを、学生モデル自身のrollout上でon-policy distillationし、1つのLLMに能力統合するMOPDを提案した論文。
- **先行研究と比べてどこがすごい？**: Mix-RLはドメイン間干渉、Cascade RLは後段訓練による忘却、Off-Policy Finetuneはexposure bias、Param-Mergeは重み空間統合の不安定性が問題だった。MOPDは「dense optimization」「on-policy」「parallelisable」を同時に満たす設計として位置づけられ、Qwen3-30B-A3Bで正規化スコア0.937を達成し、次点のMix-RL 0.882を上回った。
- **技術や手法の肝はどこ？**: まず共通SFT checkpointから各ドメイン教師を独立にRL訓練し、その後、学生モデルを同じSFT checkpointから初期化する。学生が自分で生成したtrajectoryをドメインに応じて教師へroutingし、教師のtoken-level log-probabilityを使ってper-token reverse KLで更新する。policy-gradient実装ではteacher-studentのlog差をtoken-level advantageとして使い、Top-k distillation実装では教師の上位k tokenだけを使って通信量を抑える。
- **どうやって有効だと検証した？**: Qwen3-30B-A3BでMath、Instruction Following、Software Engineeringを対象に、Mix-RL、Cascade RL、Off-Policy Finetune、Param-Mergeと比較した。評価はAIME25/26、IFBench、IFEval、SWE-bench Verified。MOPDは各ドメインでteacherとのheadroomの91〜95%を閉じ、最も均一な性能プロファイルを示した。さらに309B規模のMiMo-V2-Flashにも適用し、AIME25、HMMT25、LCB、τ2-Bench、τ2-Telecomなど多くのbenchmarkで教師同等以上を示した。
- **議論はある？**: 同一起源の教師が重要で、外部の強いQwen3-235B-A22BをMath教師に置き換えると分布差により不安定化し、性能が落ちた。つまり「強い教師ならよい」ではなく、学生と教師のpolicy distribution alignmentが前提になる。また、IFBenchとSWE-Bench VerifiedではMiMo-V2-Flash上で小さな退行があり、全ドメインで無損失統合できるわけではない。データ、reward設計、インフラ詳細も大規模実装依存が大きい。
- **次に読む/試すなら**: 1. MiniLLMやon-policy distillation系の先行研究を読み、reverse KL実装の安定化条件を確認する。2. 小規模モデルで同一起源教師と外部教師のKL差を測り、collapse条件を再現する。3. MOPDのteacher prefill serviceを既存RL trainerにどう組み込むか設計する。
- **キーワード**: `LLM post-training`, `on-policy distillation`, `multi-teacher distillation`, `reinforcement learning`, `capability integration`, `reverse KL`, `model merging`

## 気になったこと

- same-origin teacherが必須に近いなら、異なるbase model由来の専門能力を安全に取り込む方法は別途必要そう。
- teacher prefillのwall-clock overheadが「ほぼ隠れる」とあるが、これはsequence length、teacher数、serving構成に強く依存しそう。
- Top-k distillationは同一起源教師ではpolicy-gradientより明確に良いわけではなく、むしろ外部教師では崩壊しているため、使いどころを慎重に見る必要がある。
- MiMo-V2-Flashの結果は実用性を示すが、産業規模モデルなので再現可能な公開実験としてどこまで追えるかは要確認。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
