# Paperpile Brief 2026-07-09 - GRPO, Dr. GRPO, and DAPO are three operations on one number: The group-standard-deviation identity

## 基本情報

- **タイトル**: GRPO, Dr. GRPO, and DAPO are three operations on one number: The group-standard-deviation identity
- **著者**: Yong Yi Bay, Kathleen A. Yearick
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.00152

## 落合陽一フォーマット

- **ひとことでいうと**: RLVRで使われるGRPO、Dr. GRPO、DAPOの差分を、グループ内報酬の標準偏差 `σ` への操作として統一的に説明した論文。
- **先行研究と比べてどこがすごい？**: GRPOの標準化、Dr. GRPOの標準化除去、DAPOのsilent group除去を別々のheuristicではなく、同じ数 `σ = sqrt(k(G-k))/G` に対する3つの操作として整理している。有限group sizeでの厳密な更新式を出し、Big-Mathと制御実験で実際の影響も確認している。
- **技術や手法の肝はどこ？**: binary rewardで、`G` 個の回答中 `k` 個が正解のとき、GRPOのprompt単位更新が `g = σ(平均score_正解 - 平均score_不正解)` と厳密に分解できる点。つまり標準偏差は単なる正規化係数ではなく、学習信号そのものの大きさになる。
- **どうやって有効だと検証した？**: Big-Mathの215,608問のempirical solve rateを使い、GRPOが極端に難しい/易しいpromptへgradient massをより多く割くこと、`G=8`でsilent groupが約44%出ることを示した。さらに6,000個のBernoulli-logit promptを使った制御training runで、silent group率、difficulty別gradient mass、hardest quartileのsolve rate推移が閉形式の予測と合うことを確認している。
- **議論はある？**: 主結果はbinary reward、on-policy first step、advantage constructionに関するもの。clipping、KL penalty、off-policy staleness、non-binary reward、実LLM全体での長期training dynamicsは未検証または範囲外。Big-Mathのsolve rateも特定policyの固定difficulty分布として使っており、一般化性能への影響は別途検証が必要。
- **次に読む/試すなら**: 1. `scripts/grpo_diagnostics.py` を見て、自分のRLVRログにsilent group率とdifficulty weightを当てる。 2. GRPOとDr. GRPOでdifficulty別のgradient massを比較する小実験を再現する。 3. DAPOのdynamic samplingがどのdifficulty帯を過剰sampleしているかログで確認する。
- **キーワード**: `GRPO`, `Dr. GRPO`, `DAPO`, `RLVR`, `reward normalization`, `silent groups`, `difficulty bias`, `group standard deviation`

## 気になったこと

- 実LLMのtoken-level更新で、score差分の方向成分がどれだけこの単純なBernoulli-logit実験と同じ挙動をするのか。
- non-binary rewardやpartial credit rewardでは、同じ「標準偏差が学習信号」という解釈がどこまで残るのか。
- GRPOのdifficulty biasがhard prompt救済として効く場合と、raw success-rate objectiveからのズレとして悪化する場合の境界条件。
- DAPOのoversamplingによるcompute効率改善と、training distributionの歪みのトレードオフ。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [bay2026-rg-grpo-dr-grpo-and-dapo-are-three-operations-on-one-number-the-794861bd.md](../../chat/2026-07-09/bay2026-rg-grpo-dr-grpo-and-dapo-are-three-operations-on-one-number-the-794861bd.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
