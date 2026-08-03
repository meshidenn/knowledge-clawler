# Paperpile Brief 2026-08-04 - $\beta$-{OPSD}: Deriving with policy optimization, training with self-distillation

## 基本情報

- **タイトル**: $\beta$-{OPSD}: Deriving with policy optimization, training with self-distillation
- **著者**: Jiawei Xu, Minghui Liu, Juzheng Zhang, Tom Goldstein, Furong Huang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: On-policy self-distillation（OPSD）を、KL正則化の重み $\beta$ を持つ policy optimization として再定式化し、強化学習を直接回さずに distillation で近似する手法を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来の OPSD を暗黙に $\beta=1$ の特殊ケースとして位置づけ、参照ポリシーへの近さと privileged teacher の指導を調整できる一般化パラメータにした点。これにより、実装上 brittle だった OPSD に対して、より安定した最適化と推論性能改善を狙っている。
- **技術や手法の肝はどこ？**: $\beta$-OPSD の最適ポリシーを、reference policy と privileged teacher の幾何的補間として導出し、その閉形式解を distillation target に変換する。実装上は token-level logits を混合し、さらに return-to-go credit assignment によって sequence-level objective と token update を揃える。
- **どうやって有効だと検証した？**: 数学推論ベンチマークで実験し、vanilla OPSD よりも一貫して良い性能と最適化安定性を示したと abstract にはある。ただし PDF 本文がないため、具体的なベンチマーク名、モデルサイズ、比較手法、数値差分はメタデータからは不明。
- **議論はある？**: PDF 本文がないため著者自身の限界議論は不明。abstract から見る限り、logit mixing が閉形式解のどの程度忠実な近似か、$\beta$ の選び方、teacher の質への依存、数学推論以外への一般化が重要な論点になりそう。
- **次に読む/試すなら**: $\beta$ の sweep 実験と安定性指標を確認する。vanilla OPSD との実装差分が logit mixing と return-to-go のどちらに効いているか ablation を見る。小さな数学推論タスクで reference/teacher logits の混合 distillation を再現する。
- **キーワード**: `on-policy self-distillation`, `policy optimization`, `KL regularization`, `reasoning language models`, `self-distillation`, `logit mixing`

## 気になったこと

- $\beta$ の最適値はモデルサイズ・データ・teacher の強さに対してどの程度安定なのか。
- token-level logits の混合が、sequence-level の policy optimization 目的をどこまで近似できるのか。
- return-to-go credit assignment の有無で、性能改善と安定化の寄与がどれくらい変わるのか。
- 数学推論以外、たとえば coding・multi-hop QA・agentic task にも同じ設計が効くのか。
- DOI、arXiv ID、URL はメタデータからは不明。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [xu2026-xu-beta-opsd-deriving-with-policy-optimization-training-with-self-2f6e3ffc.md](../../chat/2026-08-04/xu2026-xu-beta-opsd-deriving-with-policy-optimization-training-with-self-2f6e3ffc.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
