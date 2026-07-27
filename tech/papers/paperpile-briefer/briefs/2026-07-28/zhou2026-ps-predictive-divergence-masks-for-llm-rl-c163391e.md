# Paperpile Brief 2026-07-28 - Predictive Divergence Masks for LLM RL

## 基本情報

- **タイトル**: Predictive Divergence Masks for LLM RL
- **著者**: Xiangxin Zhou, Jiarui Yao, Penghui Qi, Bowen Ping, Jiaqi Tang, Haonan Wang, Tianyu Pang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.10848 （arXiv:2607.10848v1、DOIはメタデータから不明）

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのRLで、PPO/DPPO系のtrust-region maskにおける「この更新は外向きか？」の判定を、sampled tokenのimportance ratioではなく、KL divergenceが次のgradient stepで増えるかどうかから決める手法。
- **先行研究と比べてどこがすごい？**: DPPOはproximity criterionをratioからtop-K KL divergenceに置き換えたが、direction criterionはPPO由来の`sign(A(r-1))`のままだった。この論文は、trust regionをdivergenceで定義するならdirectionもdivergenceの変化で見るべきだ、という不整合を突いている。Qwen3-4B/8B/30B-A3B、BF16/FP8設定でDPPO-TopK-KLより安定性と精度を改善したと報告。
- **技術や手法の肝はどこ？**: forward KL `DKL(mu || pi)`がpolicy-gradient stepで一次的にどう変わるかをsoftmax policyに対して閉形式で導出する点。導関数は、sampled tokenの局所項 `(pi_k - mu_k)` と、softmax正規化による全語彙のglobal項 `sum_i pi_i(mu_i - pi_i)` に分かれる。PPOのratio-based directionは局所項だけを見ており、predictive divergence maskはglobal項も入れてmaskする。
- **どうやって有効だと検証した？**: VeRL + Megatron-LM + vLLMで実装し、DAPO-Math-17k由来の約13kサンプルでRL training。評価はAIME24/AIME25のavg@16。モデルはQwen3-4B-Base、Qwen3-8B-Base、Qwen3-30B-A3B-Baseで、30BはFP8 rollout / FP8 end-to-endも試す。baselineはGRPO Clip-HigherとDPPO-TopK-KL。さらに61 seedsのtoken-level分析で、divergence-based directionのunsafe-keep率がratio-basedより低い（34.2% vs 36.9%）ことを示す。
- **議論はある？**: 方法は局所的な一次近似なので、実際のparameter updateで複数tokenのgradientが合成されたときの相互作用までは完全に表せない。top-Kしか見えないproduction rollout環境ではtail推定が必要で、aggregated-tailとuniform-tailは軽量だが近似である。効果はtoken-levelでは有意に見えるが、disagreement setが小さいため改善幅は大きくない。
- **次に読む/試すなら**: DPPO-TopK-KL実装にdirection coefficientだけ差し替える最小実験を作る。`K=20, delta=0.15`で既存GRPO/DPPO training logとclip fractionを比較する。Qi et al. 2026のDPPO論文と、training-inference mismatch系のQi/Yao/Zhengの関連研究を読む。
- **キーワード**: `LLM RL`, `PPO`, `DPPO`, `trust region`, `KL divergence`, `top-K logits`, `off-policy RL`, `predictive mask`

## 気になったこと

- top-K tail推定は実装負荷が低そうだが、rollout engineが返すlogprob形式とtraining側logprobの対応をどこまで厳密に合わせる必要があるか。
- disagreement tokenが平均82個/seed程度と小さいので、タスクやthresholdを変えたときに改善がどれだけ残るか。
- forward KL以外、特にTV divergence版やreverse KL版で同じdirection設計がどの程度安定するか。
- FP8によるtraining-inference mismatchをstress testにしているが、通常のserving最適化差分でも同じ傾向が出るか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhou2026-ps-predictive-divergence-masks-for-llm-rl-c163391e.md](../../chat/2026-07-28/zhou2026-ps-predictive-divergence-masks-for-llm-rl-c163391e.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
