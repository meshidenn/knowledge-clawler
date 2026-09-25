# Chat Prompt 2026-09-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {DeltaMomentum}: A key-value based anisotropic momentum update via delta rule

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-02 - DeltaMomentum: A key-value based anisotropic momentum update via delta rule

## 基本情報

- **タイトル**: DeltaMomentum: A key-value based anisotropic momentum update via delta rule
- **著者**: Euijin Hong, Guannan Qu
- **年 / venue**: 2026 / arXiv [cs.LG]（arXiv:2608.19491）
- **リンク**: https://arxiv.org/abs/2608.19491 （PDF: https://arxiv.org/pdf/2608.19491）

## 落合陽一フォーマット

- **ひとことでいうと**: EMAで一律に忘却していたmomentumを、層への入力をkey・逆伝播誤差をvalueとみなし、方向ごとに忘却速度を変えるdelta ruleベースの更新則へ置き換える手法。
- **先行研究と比べてどこがすごい？**: Shampoo、SOAP、Muonなどが既存EMA momentumの前後に前処理・後処理を加えるのに対し、本論文はmomentum buffer自体の更新規則を変える。明示的な行列反転や永続的な追加状態なしに入力側曲率補正に似た効果を狙い、既存optimizerの一次momentumを置換するdrop-in設計である。
- **技術や手法の肝はどこ？**: 線形層のサンプル勾配を \(g_t=\delta_t x_t^\top\) と分解し、\(x_t\) をkey、\(\delta_t\) をvalueとして扱う。bufferを \(M_t=\beta M_{t-1}+\eta(\delta_t-M_{t-1}\hat{x}_t)\hat{x}_t^\top\) のように更新し、現在の入力方向にある古い記憶を消してから新しい誤差を記録する。正規化keyを使うことで、追加係数の幅方向転移を可能にすることも主張している。
- **どうやって有効だと検証した？**: FineWeb-Eduで67M・370M・1Bの言語モデル事前学習を行い、DeltaAdamWとAdamWを比較した。著者報告では、同一validation lossまでのstep数を67Mで最大46.39±4.32%、370Mで22.12±0.80%削減した。さらにCIFAR-10のMLP、ResNet-18、ViT-TinyとDeltaSGDでも比較し、gradient tracking、function-spaceでの誤差予測、入力特徴共分散のcondition number・effective rankなどの診断も示している。
- **議論はある？**: 評価は最大1B parameterの言語モデルとCIFAR-10分類に限られ、画像生成・強化学習・より大規模な学習での有効性は未検証である。実装時の計算コストは増え、著者報告では実測step時間のoverheadが67Mで11.2%、370Mで17.4%、1Bで20.3%となる。Muon、Shampoo、SOAPとのbufferレベルでの組合せも将来課題であり、結果はpreprintの著者実験に基づく。
- **次に読む/試すなら**:
  1. AdamWのfirst-moment更新だけをDeltaMomentumに差し替え、既存の小規模Transformerでstep-to-targetとwall-clockを比較する。
  2. key正規化、\(\beta\)、\(\eta\) の感度と、モデル幅を変えたときのhyperparameter転移を再現する。
  3. MuonまたはSOAPと組み合わせ、改善が相補的かを統制実験で確認する。
- **キーワード**: `optimizer`, `momentum`, `delta rule`, `associative memory`, `anisotropic optimization`, `AdamW`, `μP`

## 気になったこと

- 追加計算コストを含めたwall-clockあたりの改善は、特に1B超の規模でもstep削減を上回るのか。
- batch化した実装で、個々のsampleのkey-value構造をどこまで保てるか。
- 活性化の正規化やarchitecture固有のfeature geometryによって、効果の大きさはどの程度変わるか。
- 正規化keyを前提にした更新が、入力ノルム自体に含まれる最適化上有用な情報を失わないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
