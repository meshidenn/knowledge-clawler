# Chat Prompt 2026-08-26

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Every coin has two sides: On the dual nature of generalization in on-policy distillation of large language models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-26 - Every coin has two sides: On the dual nature of generalization in on-policy distillation of large language models

## 基本情報

- **タイトル**: Every coin has two sides: On the dual nature of generalization in on-policy distillation of large language models
- **著者**: Zhaoyi Li, Deyang Kong, Yuan Wei, Evan Yang, Ranran Shen, Mahardika Krisna Ihsani, Ming Yang, Wei Zhang, Chuan Hao, Jian Yang, Ran Tao, Bryan Dai, Shikun Zhang, Wei Ye, Ying Wei, Defu Lian
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.16647](https://arxiv.org/abs/2608.16647) / [PDF](https://arxiv.org/pdf/2608.16647.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: On-policy distillation（OPD）は個別問題の正答ではなく教師の「推論方策」を移しうるが、その広い汎化は複数教師OPDでは教師間の能力綱引きを生む、という実証研究。
- **先行研究と比べてどこがすごい？**: 単一ドメイン・近接ベンチマーク中心だったOPD評価を、問題難度、言語、推論長、ドメイン、教師・生徒の出自、複数教師へと段階的に分解した。同一出自の教師・生徒では、訓練に含まれない言語・長期推論・別ドメインまで教師性能に近づく一方、異出自では主に訓練分布へ適合することを示した。
- **技術や手法の肝はどこ？**: 生徒自身が生成した軌跡上で教師のトークン分布を用いて学習するPG-style OPDを使う。教師・生徒の基盤モデルが共通かを「same-origin」として分け、Top-16トークン分布の重なりも測定して、広い転移が方策全体の整列に対応するという説明を与える。
- **どうやって有効だと検証した？**: 数学で教師・生徒の解答率別に訓練問題を分け、英語→中国語、短い推論→合成長期推論を評価した。さらに数学・コード・科学・指示追従の間で相互転移を調べ、LiveCodeBench、GPQA-Diamond、IF-Eval、複数の数学ベンチマークで単一教師OPDと複数教師OPDを比較した。既に生徒が解ける問題だけを動的に除外すると、小さいが一貫した改善も観察している。
- **議論はある？**: 実験は推論指向モデルと4ドメインに限られ、マルチモーダル、ツール利用、対話エージェントへの一般化は未検証。複数教師実験も主に2教師・固定のドメインルーティングであり、大規模で異質な教師プールや適応的ルータでの挙動は不明。same-origin効果は有力な観察だが、因果的な機構の確定には追加検証が必要。
- **次に読む/試すなら**:
  1. 自分のOPD設定で、教師と生徒の基盤モデル系統を揃えた条件・揃えない条件を分けて比較する。
  2. MOPDではルーティング先だけでなく、各教師が他ドメインにも与える影響を全ベンチマークで測る。
  3. 生徒が安定して解けるサンプルを除外する動的データ選択を最小実験として試す。
- **キーワード**: `on-policy distillation`, `multi-teacher distillation`, `generalization`, `reasoning models`, `policy alignment`, `model origin`

## 気になったこと

- same-originの優位性は、事前学習データ・トークナイザ・モデル規模・RL後学習レシピのどれに最も依存するのか。
- 複数教師の能力綱引きは、教師分布の混合方法、勾配干渉、ルータ学習のどれで緩和できるのか。
- ドメインルーティングを安全境界とみなせないなら、望ましくない振る舞い・バイアスのクロスドメイン転移をどう監査すべきか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
