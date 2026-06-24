# Chat Prompt 2026-06-25

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Evaluation of similarity-based explanations

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-25 - Evaluation of similarity-based explanations

## 基本情報

- **タイトル**: Evaluation of similarity-based explanations
- **著者**: Kazuaki Hanawa, Sho Yokoi, Satoshi Hara, Kentaro Inui
- **年 / venue**: 2020 / arXiv [cs.LG]（PDF本文では ICLR 2021 conference paper）
- **リンク**: https://arxiv.org/abs/2006.04528 / arXiv:2006.04528

## 落合陽一フォーマット

- **ひとことでいうと**: 機械学習モデルの「似た訓練例を根拠として提示する説明」に対して、どの関連度指標が説明として妥当かを3つの最小要件テストで評価した論文。
- **先行研究と比べてどこがすごい？**: 類似事例ベース説明そのものではなく、「類似している」と判断する relevance metric の妥当性を体系的に比較している点が差分。入力空間の距離、隠れ層表現、Influence Function、Fisher Kernel、Grad-Dot、Grad-Cos などを横断的に評価し、Grad-Cos が最も安定して良いという実務的な指針を出している。
- **技術や手法の肝はどこ？**: 説明指標に対して、モデル依存性を見る **model randomization test**、同じ予測クラスの訓練例を返せるかを見る **identical class test**、クラス内の潜在サブクラスまで一致するかを見る **identical subclass test** を課す。特に Grad-Cos は、テスト点と訓練点それぞれの損失勾配ベクトルの cosine similarity を使い、モデルの判断過程と入力の近さを同時に反映しやすい。
- **どうやって有効だと検証した？**: MNIST、CIFAR10、TREC、AGNews、Vehicle、Segment などの分類タスクで、ロジスティック回帰、CNN、MobileNetV2、Bi-LSTM、MLP を使って比較。Grad-Cos は model randomization test を通過し、identical class test では平均成功率 0.996、identical subclass test では 0.753 と、表中で最も強い結果を示した。一方、入力そのものの距離や dot product 系、IF/FK/GD の一部は、モデル非依存だったりノルムの大きい事例に引っ張られたりして失敗する。
- **議論はある？**: 3つのテストは「最小要件」であり、人間にとって本当に納得できる説明か、実利用で信頼形成に効くかまでは直接測っていない。サブクラス評価も、モデルが内部表現でサブクラス構造をある程度捉えているという仮定に依存する。PDF本文の表や式は抽出テキスト由来なので、細かな数値は原PDF確認が必要。
- **次に読む/試すなら**: 1. 自分のモデルで Grad-Cos を実装して、最近傍訓練例のクラス一致率を見る。 2. Influence Function や Fisher Kernel を使っている既存説明と比較する。 3. model randomization test を説明手法の回帰テストとして組み込む。
- **キーワード**: `similarity-based explanation`, `instance-based explanation`, `Grad-Cos`, `influence function`, `explainable AI`, `model randomization test`

## 気になったこと

- Grad-Cos が高性能なのは分類タスク中心の結果なので、回帰、生成モデル、LLMの埋め込み検索型説明でも同じ傾向になるか確認したい。
- 「似た訓練例」を出す説明では、データセット内の重複・リーク・アノテーション品質が結果に強く効きそう。
- ユーザ評価なしで plausibility を identical class/subclass で代替しているため、人間の納得感との相関を追加で調べたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
