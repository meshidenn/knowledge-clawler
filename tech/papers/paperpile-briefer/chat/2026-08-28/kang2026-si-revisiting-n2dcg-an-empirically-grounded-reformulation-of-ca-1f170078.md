# Chat Prompt 2026-08-28

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Revisiting {N2DCG}: An empirically grounded reformulation of carousel recommendation evaluation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-28 - Revisiting N2DCG: An Empirically Grounded Reformulation of Carousel Recommendation Evaluation

## 基本情報

- **タイトル**: Revisiting N2DCG: An Empirically Grounded Reformulation of Carousel Recommendation Evaluation
- **著者**: Jingwei Kang, Santiago de Leon-Martinez, Maarten de Rijke, Harrie Oosterhuis
- **年 / venue**: 2026 / CIKM ’26（arXiv:2608.21877）
- **リンク**: [arXiv](https://arxiv.org/abs/2608.21877) / [PDF](https://arxiv.org/pdf/2608.21877) / DOI: [10.1145/3799682.3839894](https://doi.org/10.1145/3799682.3839894)

## 落合陽一フォーマット

- **ひとことでいうと**: カルーセル型推薦UI向け評価指標N2DCGを、カテゴリ制約と実際の視線行動に合わせて再定式化した論文。
- **先行研究と比べてどこがすごい？**: 既存N2DCGは「行ごとにカテゴリを揃える」というカルーセル固有の制約を無視し、実現不可能な理想配置で正規化していた。また、スワイプ後に注視が右側へ戻るミラーFパターンも扱えない。本論文は両方を修正し、実データへの適合とレイアウト比較精度を改善した。
- **技術や手法の肝はどこ？**: 理想2DCGをカテゴリ制約下で最大化する `I2DCGcat` を導入し、カテゴリ別カルーセルと表示行の割当をHungarian algorithmで解く。さらに、ページ2以降の列順を反転させるミラーFパターン割引と、初回横スワイプ・行位置を減衰させるrow-page discountを設計した。
- **どうやって有効だと検証した？**: RecGazeの視線追跡データを用い、Bratislavaの61人・1,665画面でパラメータを学習し、Amsterdamの26人・710画面で検証した。row-page discountはテストで Spearman相関 0.9859、Pearson相関 0.9771、MSE 0.0096と最良だった。さらに2万件のシミュレーションで、再定式化した2DCGは元指標より一貫して正確にレイアウトの優劣を判定した。
- **議論はある？**: 視線データは公開RecGazeの特定UI・映画カルーセル・自由閲覧条件に依存するため、他ドメインや画面設計への一般化は未検証である。シミュレーションは実ユーザーの選択・長期満足まで直接評価しておらず、著者も行動モデルを含むsimulator-based evaluationを今後の課題としている。
- **次に読む/試すなら**:
  - 自社UIのログや視線・クリックデータで、ページ遷移後の注視分布を推定する。
  - 既存のオフライン評価をカテゴリ制約付き `N2DCGcat` に置換し、ランキング差を比較する。
  - RecGazeと既存N2DCG、carousel click modelの関連研究を読む。
- **キーワード**: `carousel recommendation`, `N2DCG`, `offline evaluation`, `eye tracking`, `position bias`, `interface-aware RecSys`

## 気になったこと

- カテゴリが複数行に分割される、または1行に複数テーマが混在する実サービスでは、カテゴリ制約をどう一般化するか。
- row-page discountのパラメータはUIの表示件数、端末サイズ、操作方式ごとに再推定が必要ではないか。
- 視線上の「閲覧」とクリック・視聴・満足度がどの程度一致するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
