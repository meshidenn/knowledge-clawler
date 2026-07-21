# Chat Prompt 2026-07-22

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {DeepLoop}: Depth scaling for looped Transformers

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-22 - DeepLoop: Depth scaling for looped Transformers

## 基本情報

- **タイトル**: DeepLoop: Depth scaling for looped Transformers
- **著者**: Shuzhen Li, Yifan Zhang, Jiacheng Guo, Quanquan Gu, Mengdi Wang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.13491 / Project Page: https://github.com/lszshu/DeepLoop

## 落合陽一フォーマット

- **ひとことでいうと**: Looped Transformerで同じ物理ブロックを何度も再利用するとき、従来のDeepNormでは残差スケーリングが甘くなることを解析し、ループ回数を考慮した新しい初期化・残差スケール則DeepLoopを提案した論文。
- **先行研究と比べてどこがすごい？**: DeepNormは深いPost-LN Transformerを安定化するが、各層のパラメータが独立である前提だった。本論文は、Universal Transformer、ALBERT、recurrent-depth型モデルのようなweight sharingされた深さでは、同じパラメータが複数visitの勾配を書き込み、次のforwardでも複数visitから読まれるという「tied-depth effect」があると定式化した点が新しい。
- **技術や手法の肝はどこ？**: visit間の勾配・感度の揃い具合を表す係数 `κ_R` を導入し、安定条件を従来の `M(β/α)^2 = O(1)` から `M κ_R(β/α)^2 = O(1)` に拡張する。visitがdecorrelateするならDeepNormの指数 `p=1/4` が戻るが、alignedな保守的ケースでは `p=1/2` が必要になる。DeepLoopはPost-LN DeepNorm構造を保ちつつ、unrolled depth `N` に対して `α=(2N)^(1/2)`, `β=(8N)^(-1/2)` を使う。
- **どうやって有効だと検証した？**: GPT-style looped language modelをGPT-2 small / medium規模で評価。`R=1`、つまり物理ブロック再訪がない場合はほぼ中立で、`R>1` のrecurrent depthが有効になるとvalidation lossと下流タスク平均精度が改善した。下流評価は8タスクのlm-evaluation-harnessで実施。さらにGPT-2 small、`R=3` で指数 `p` を掃引し、`p<0.45` では不安定、`p>=0.50` で安定という傾向を示し、解析上の `p=1/2` 境界と整合するとしている。
- **議論はある？**: `κ_R` は理論上の整理には有用だが、本文では直接測定していない。実験はGPT-2 small / medium、FineWeb-Edu 50BT、限られたloop countと計算予算に集中しており、より大規模モデル、異なるnormalization、長期学習、別タスクで同じ境界が成り立つかは未検証。PDF本文の表や数値は抽出崩れがあり得るため、細かな性能差は原PDFで確認したい。
- **次に読む/試すなら**: 1. DeepLoop実装で `α, β` の適用箇所が既存Transformerコードにどう入るか確認する。 2. 自分のlooped / recurrent-depthモデルで `p=1/4, 1/2, 0.45` を小規模比較する。 3. visit間のgradient alignmentを測って `κ_R` の実効値を見る。
- **キーワード**: `looped transformer`, `DeepNorm`, `residual scaling`, `weight sharing`, `recurrent depth`, `Post-LN`, `κ_R`

## 気になったこと

- `κ_R` を実測するには、visitごとのgradientやsensitivityをどの粒度で保存すればよいか。
- DeepLoopの保守的な `p=1/2` は安定性を上げる一方、学習信号を弱める可能性があるため、decorrelationを促す正則化やroutingと組み合わせる余地がありそう。
- Pre-LN、RMSNorm以外、MoE、test-time compute型のlatent reasoningモデルでも同じスケーリング則が効くか。
- `R` を訓練時と推論時で変える場合、`N=KR` に基づく `α, β` をどちらに合わせるべきか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
