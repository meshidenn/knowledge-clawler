# Paperpile Brief 2026-09-30 - Towards Optimal Transport with Global Invariances

## 基本情報

- **タイトル**: Towards Optimal Transport with Global Invariances
- **著者**: David Alvarez-Melis, Stefanie Jegelka, Tommi S. Jaakkola
- **年 / venue**: 2018 / arXiv [stat.ML]（AISTATS 2019掲載）
- **リンク**: https://arxiv.org/abs/1806.09277

## 落合陽一フォーマット

- **ひとことでいうと**: 回転・反射などの未知のグローバル変換を、対応付けと同時に推定できるOptimal Transportを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のOTが前提としていた「2つの特徴空間が同じ座標系にある」という条件を緩和し、変換のクラス自体を柔軟に指定できる。従来法で必要だった敵対的初期化や手作業の初期値に依存せず、教師なし単語翻訳で競争力のある精度をより短時間で達成した。
- **技術や手法の肝はどこ？**: 輸送結合Γとグローバル変換Pを共同最適化する。変換をSchattenノルム球に制約し、固定したΓに対してはSVDによる一般化Procrustes解、固定したPに対してはSinkhorn法によるエントロピー正則化OTを解く。正則化係数を大きい値から徐々に下げるannealingで、非凸最適化の初期値依存性を抑える。
- **どうやって有効だと検証した？**: 既知の変換を施した3次元点群で対応精度と変換推定誤差を評価し、回転・反射にはℓ∞不変OT、より一般的な変換にはℓ2不変OTが有効であることを確認した。さらに英語とスペイン語・フランス語・ドイツ語・イタリア語・ロシア語の教師なし単語翻訳で比較し、ℓ∞-InvarOTは競合手法と同等水準の精度を、概ね短い実行時間で達成した。
- **議論はある？**: 目的関数はΓとPに関して同時には非凸であり、局所解や収束への依存が残る。変換クラスの選択、角度保存またはwhiteningの仮定が実データで妥当とは限らない。また、単語埋め込みの入力順序が対応情報を漏らしている可能性を著者自身が指摘している。PDF本文の抽出では表や数式のレイアウトが崩れているため、細かな数値は原論文での再確認が必要。
- **次に読む/試すなら**:
  1. 小規模な単語埋め込みまたは点群でSinkhorn＋Procrustesの交互最適化を再実装する。
  2. Gromov-Wassersteinとの違いを、同一データ上で対応精度と計算量から比較する。
  3. 入力順序をランダム化し、単語翻訳性能がどの程度変わるか検証する。
- **キーワード**: `optimal transport`, `global invariance`, `word embedding alignment`, `Gromov-Wasserstein`

## 気になったこと

- Schattenノルムの次数と半径を、未知の実データでどのように選ぶべきか。
- エントロピーannealingのスケジュールが、データ規模やノイズにどの程度依存するか。
- 単語埋め込みの頻度順による情報漏洩を除いた場合でも、同じ性能が再現するか。
- 現代の大規模埋め込みや非線形変換に対して、この線形変換モデルがどこまで有効か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [alvarez-melis2018-yx-towards-optimal-transport-with-global-invariances-22fa582c.md](../../chat/2026-09-30/alvarez-melis2018-yx-towards-optimal-transport-with-global-invariances-22fa582c.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
