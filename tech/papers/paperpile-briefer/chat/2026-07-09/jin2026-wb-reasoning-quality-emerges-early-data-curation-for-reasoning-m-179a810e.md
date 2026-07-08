# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Reasoning quality emerges early: Data curation for reasoning models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - Reasoning quality emerges early: Data curation for reasoning models

## 基本情報

- **タイトル**: Reasoning quality emerges early: Data curation for reasoning models
- **著者**: Hongyi Henry Jin, Wenhan Yang, Meysam Ghaffari, Carlos Morato, Baharan Mirzasoleiman
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのreasoning SFT用データを、長い推論全体ではなく初期reasoning tokenのlossパターンから安く選別する手法を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の高品質SFTデータ選別は強いreasoning modelで多様性や難易度を評価するため高コストになりがちだが、この論文は最初の100 tokenや1k token程度のlossを見るだけで難問性や勾配類似性を推定できると主張する。abstract上では、既存baselineを最大1.7%上回り、token効率を91%改善したとしている。
- **技術や手法の肝はどこ？**: 事前学習済みモデルのcheckpointをランダム摂動し、その状態で最初の100 reasoning tokensのlossを測ることで難しい問題を検出する点。さらに、fine-tuning trajectoryに沿う少数の摂動checkpointで、最初の1k reasoning tokensのlossパターンが似ている例は類似したgradientを誘導する、という理論的主張を置いている。
- **どうやって有効だと検証した？**: Qwen2.5-7BとLlama3.1-8Bを、M23K medical reasoning datasetとOpenThoughts-Math datasetでfine-tuningして評価したとされる。比較対象の詳細、評価指標、統計的有意性はPDF本文がないためメタデータからは不明。
- **議論はある？**: PDF本文がないため限界の詳細は不明。abstractから見る限り、初期tokenのlossがreasoning品質や難易度をどこまで一般化して表すか、モデルサイズ・ドメイン・データ生成元が変わったときに成り立つか、最大1.7%改善が実用上どの程度大きいかが確認点になる。
- **次に読む/試すなら**: 実装で必要な摂動checkpointの作り方を確認する。OpenThoughts-Mathでfirst-100-token lossによる選別を小規模再現する。既存のdiversity/difficulty filtering baselineとの計算コスト比較を読む。
- **キーワード**: `reasoning SFT`, `data curation`, `loss-based filtering`, `gradient similarity`, `LLM reasoning`

## 気になったこと

- 摂動checkpointはどの程度の数・大きさ・方向で作るのか。
- first 100 reasoning tokensのlossが、回答の正しさではなく「難しさ」を捉えるという根拠はどこまで強いのか。
- 91% token efficientの定義が、選別時の評価token数なのか、学習token数なのか、総計算量なのかを確認したい。
- 医療reasoningと数学reasoning以外、コード・計画・長文推論でも同じ傾向が出るか。
- PDF未取得のため、要約はabstractベース。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
