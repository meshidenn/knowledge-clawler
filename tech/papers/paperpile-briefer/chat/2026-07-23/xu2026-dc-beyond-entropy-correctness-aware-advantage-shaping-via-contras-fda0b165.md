# Chat Prompt 2026-07-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Beyond entropy: Correctness-aware advantage shaping via Contrastive Policy Optimization

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-23 - Beyond entropy: Correctness-aware advantage shaping via Contrastive Policy Optimization

## 基本情報

- **タイトル**: Beyond entropy: Correctness-aware advantage shaping via Contrastive Policy Optimization
- **著者**: Weiwen Xu, Jia Liu, Hou Pong Chan, Long Li, Deng Cai, Min Chen, Hao Zhang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.14614

## 落合陽一フォーマット

- **ひとことでいうと**: RLVRにおけるentropyベースのadvantage shapingを置き換え、参照解あり生成分布と通常生成分布のtoken-levelな差分を使って、正しさを意識したContrastive Policy Optimization（CPO）を提案した論文。
- **先行研究と比べてどこがすごい？**: entropyは「有用な探索」と「誤った混乱」を区別できない、という弱点を突いている。CPOはreference-guided posteriorとvanilla policyのlog probability比を使い、tokenごとの正誤寄与をより直接的に推定する。Qwen2.5-Math-7BとQwen3-Base-4Bで、GRPOに対して平均でそれぞれ7.7%、8.5%改善したと本文では報告されている。
- **技術や手法の肝はどこ？**: 同じ出力token列を、通常promptと参照解付きpromptの2条件で再スコアし、`δ_t = log π_post(y_t | x, y*, y_<t) - log π(y_t | x, y_<t)` をcontrastive disagreementとして使う点。正解に近いtokenは参照解条件で確率が上がり、誤りに寄るtokenは下がる、というBayes的な解釈をadvantage shapingに落としている。さらに元のtrajectory-level advantageの符号を壊さないようclipして安定化している。
- **どうやって有効だと検証した？**: Qwen2.5-Math-7BとQwen3-Base-4BをMATHで学習し、数学推論のin-domain / out-of-domain benchmarkでGRPOやentropy系RLVR手法と比較している。加えて、Math-500上でdisagreementが大きく負になるtokenから16回継続生成し、Accuracy@16が下がることを示して、負のdisagreementが誤り寄りtokenを指すことを実証している。
- **議論はある？**: CPOはposterior likelihood計算のために追加forward passが必要で、標準GRPOより訓練時間が約20%増えるとされる。また、現状はreference answerが必要なので、verifiable rewardや正解があるタスクに適用範囲が寄る。open-ended生成や主観評価タスクでは、critic feedbackやprocess-level annotationなど別のcorrectness-informed distributionが必要になる。
- **次に読む/試すなら**: 1. GRPO実装に追加forward passだけでCPOを差し込めるか確認する。 2. entropy shaping系手法とのablation条件を追って、CPOの改善がどのbenchmarkで強いか見る。 3. reference answerなしでcritic-guided posteriorに置き換える最小実験を設計する。
- **キーワード**: `RLVR`, `GRPO`, `advantage shaping`, `contrastive disagreement`, `token-level credit assignment`, `on-policy distillation`, `LLM reasoning`

## 気になったこと

- reference-guided promptの設計にどれくらい敏感か。本文ではprompt variantのablationがあるが、実運用ではprompt依存がボトルネックになりそう。
- 追加forward passによる20%程度の計算増が、大規模RL訓練で性能改善に見合うか。
- negative disagreementは誤り検出に強い一方、positive disagreementの効果はbaseline近辺で安定とされており、「正しいtokenを積極的に伸ばす」より「誤りtokenを抑える」手法として効いている可能性がある。
- OPDをCPOの特殊ケースとして整理している点は面白いので、外部teacher・self-teacher・critic-guidedのどれが実装コストと性能のバランスがよいか比較したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
