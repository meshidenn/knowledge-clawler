# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Are we measuring strategy or phrasing? The gap between surface- and approach-level diversity in {LLM} math reasoning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - Are we measuring strategy or phrasing? The gap between surface- and approach-level diversity in LLM math reasoning

## 基本情報

- **タイトル**: Are we measuring strategy or phrasing? The gap between surface- and approach-level diversity in LLM math reasoning
- **著者**: Sangmook Lee, Minbeom Kim, Jeonghye Kim, Dohyung Kim, Sojeong Rhee, Kyomin Jung
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの数学推論における「多様性」が、言い回しや表層的な違いではなく、解法戦略そのものの違いを測れているのかを検証した論文。
- **先行研究と比べてどこがすごい？**: 従来のdiversity指標が主にsurface-level variationを捉えており、approach-level diversity、つまり同じ問題に対する正答解法の戦略差を十分に測れていない点を明確に分けている。さらに、そのズレがdiversity-aware RLVRでも残り、表面的な多様性指標は保たれても実際の解法多様性は低下しうることを示している。
- **技術や手法の肝はどこ？**: 「approach-level diversity」を定義し、人間の判断に較正したLLM judge frameworkで、複数の正解解答がどれだけ異なる解法アプローチを使っているかを評価する点。単なる文面・語彙・形式の違いではなく、問題解決の戦略単位で多様性を見る設計が中心。
- **どうやって有効だと検証した？**: メタデータ上のabstractによれば、既存の多様性指標とapproach-level diversityの対応を比較し、従来指標が信頼できるproxyではないことを示している。また、diversity-aware RLVRで目的指標が維持されてもapproach-level diversityが低下すること、approach-diverseな候補集合がtest-time scalingを改善すること、LLM judge diversity rewardを訓練で最適化するとjudge固有の選好を利用してしまうことを調べている。PDF本文は未取得のため、具体的なデータセット、モデル、数値、比較条件はメタデータからは不明。
- **議論はある？**: LLM judgeに依存する評価なので、judgeの較正方法・人間評価との一致度・ドメイン外汎化が重要な弱点になりうる。さらに、approach-level diversityを報酬として直接最適化すると、真の解法多様化ではなくjudge preferenceの攻略に向かうという限界が示唆されている。再現性に必要なプロンプト、評価rubric、RLVR設定、モデルサイズなどはメタデータからは不明。
- **次に読む/試すなら**: 1. PDF本文を取得して、approach-level diversityの定義とannotator/LLM judgeのrubricを確認する。 2. 既存の数学推論ベンチで、自分のモデル出力をsurface diversityとapproach diversityに分けて評価してみる。 3. test-time candidate selectionで「正答率」だけでなく「解法クラスタの広がり」を使う小さな再現実験を組む。
- **キーワード**: `LLM reasoning`, `mathematical reasoning`, `diversity metrics`, `approach-level diversity`, `LLM judge`, `RLVR`, `test-time scaling`

## 気になったこと

- approach-level diversityを人間がどの粒度で判定しているのか。例えば代数的変形、図形的直観、探索、場合分けはどこまで別アプローチ扱いなのか。
- LLM judgeが「もっともらしい別解っぽさ」を好むだけになっていないか。
- diversity-aware RLVRでapproach-level diversityが下がる原因は、報酬設計なのか、policy collapseなのか、訓練データの偏りなのか。
- approach-diverse candidate setがtest-time scalingを改善するなら、生成時のsampling戦略やrerankingだけで十分なのか、訓練まで必要なのか。
- 関連研究として、self-consistency、solution clustering、process reward model、verifier-guided searchとの接続を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
