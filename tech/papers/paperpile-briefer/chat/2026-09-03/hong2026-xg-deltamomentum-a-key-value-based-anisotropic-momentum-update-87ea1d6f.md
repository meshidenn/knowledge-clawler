# Chat Prompt 2026-09-03

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {DeltaMomentum}: A key-value based anisotropic momentum update via delta rule

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-03 - DeltaMomentum: A key-value based anisotropic momentum update via delta rule

## 基本情報

- **タイトル**: DeltaMomentum: A key-value based anisotropic momentum update via delta rule
- **著者**: Euijin Hong, Guannan Qu
- **年 / venue**: 2026 / arXiv [cs.LG]（Preprint）
- **リンク**: [arXiv:2608.19491](https://arxiv.org/abs/2608.19491) / [PDF](https://arxiv.org/pdf/2608.19491)

## 落合陽一フォーマット

- **ひとことでいうと**: 通常のEMA momentumを、勾配を「入力key・誤差value」の連想記憶として更新するdelta ruleへ置き換え、方向ごとに異なる忘却速度を実現したOptimizer改良。
- **先行研究と比べてどこがすごい？**: Shampoo・SOAP・Muonなどが既存momentumの前後に前処理／後処理を加えるのに対し、本研究はmomentum更新則そのものを変える。明示的な行列逆行列や追加の永続状態なしに入力側の曲率補正に似た効果を得る設計で、AdamW比で同一validation lossへの到達ステップを67Mモデルで最大46.39%、370Mで22.12%削減したと報告する。
- **技術や手法の肝はどこ？**: 線形層の1サンプル勾配を $\delta x^\top$ と分解し、$x$ をkey、出力側誤差 $\delta$ をvalueとみなす。momentum行列 $M$ を、現在のkey方向の古い記憶を消して新しいvalueを書き込むdelta ruleで更新する。実装ではkeyを正規化し、幅に依存しない係数設定とµP下でのhyperparameter transferを狙う。
- **どうやって有効だと検証した？**: FineWeb-Eduで67M・370M・1Bの言語モデル事前学習を行い、AdamWとDeltaAdamWを比較した。Muonも同一プロトコルで比較し、両言語モデル規模でDeltaAdamWを上回らなかったとする。さらにCIFAR-10上でDeltaSGD、ResNet-18、ViT-Tinyにも適用し、勾配追従誤差、momentumと勾配のcosine、入力特徴のcondition number・effective rankも測定した。
- **議論はある？**: 実験は最大1Bパラメータの言語モデルとCIFAR-10に限られ、画像生成・強化学習・より大規模な学習での有効性は未検証。1Bでは実測の追加計算コストが20.3%であり、速度向上がwall-clockでも常に勝つかは実装・ハードウェア依存である。Muon、Shampoo、SOAPとの合成効果も将来課題。
- **次に読む/試すなら**:
  - AdamWのfirst-moment更新だけをDeltaMomentumに差し替え、小規模Transformerでsteps-to-targetとwall-clockを比較する。
  - activation covarianceのスペクトルと、改善幅の相関を層ごとに確認する。
  - MuonまたはShampooと組み合わせ、補完的という主張を実証する。
- **キーワード**: `momentum`, `delta rule`, `AdamW`, `associative memory`, `anisotropic optimization`, `µP`

## 気になったこと

- delta-rule係数とEMA係数の推奨値・探索範囲、および学習率scheduleへの感度を確認したい。
- 正規化keyがLayerNormやRMSNormとどう相互作用するか、特にAttention投影層とMLP層で効果が異なるかが気になる。
- 追加FLOPsよりメモリ帯域・kernel fusionが支配的になり得るため、fused実装での実wall-clock改善を検証したい。
- 「暗黙の入力側preconditioning」が、既存の明示的preconditionerとの併用で安定して加算的な利益を生むかを確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
