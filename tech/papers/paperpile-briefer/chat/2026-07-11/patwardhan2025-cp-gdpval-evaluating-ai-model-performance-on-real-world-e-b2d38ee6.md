# Chat Prompt 2026-07-11

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {GDPval}: Evaluating {AI} model performance on real-world economically valuable tasks

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-11 - GDPval: Evaluating AI model performance on real-world economically valuable tasks

## 基本情報

- **タイトル**: GDPval: Evaluating AI model performance on real-world economically valuable tasks
- **著者**: Tejal Patwardhan, Rachel Dias, Elizabeth Proehl, Grace Kim, Michele Wang, Olivia Watkins, Simón Posada Fishman, Marwan Aljubeh, Phoebe Thacker, Laurance Fauconnet, Natalie S. Kim, Patrick Chao, Samuel Miserendino, Gildas Chabot, David Li, Michael Sharman, Alexandra Barr, Amelia Glaese, Jerry Tworek
- **年 / venue**: 2025 / arXiv [cs.LG]
- **リンク**: https://s-rsa.com/index.php/agi/article/download/17197/11923

## 落合陽一フォーマット

- **ひとことでいうと**: 実世界の経済的価値がある知識労働タスクで、AIモデルが専門家にどこまで近づいているかを測るベンチマーク GDPval を提案した論文。
- **先行研究と比べてどこがすごい？**: 学術試験型ベンチマークではなく、44職種・9産業セクター・フルセット1,320タスクを、実務経験者の実際の成果物に基づいて作っている点が強い。CAD、動画、音声、スライド、表計算、顧客対応などマルチモーダルで、主観的品質やフォーマットも含めて専門家がペア比較する。
- **技術や手法の肝はどこ？**: O*NET/BLSの職業・作業分類からGDP寄与の大きい産業とデジタル知識労働職種を選び、平均14年経験の専門家にタスクと成果物を作らせる。評価は「人間専門家の成果物 vs モデル成果物」のblind pairwise comparisonを中心にし、gold subset 220タスクには自動graderも用意する。
- **どうやって有効だと検証した？**: GPT-4o、o4-mini、o3、GPT-5、Claude Opus 4.1、Gemini 2.5 Pro、Grok 4などをGDPval gold subsetで評価。Claude Opus 4.1はwins+tiesで47.6%に達し、専門家成果物に近づいたと報告している。自動graderは人間graderとの一致率66%で、人間同士の一致率71%に5ポイント差。reasoning effort、prompt tuning、scaffoldingを増やすと性能が改善することも示した。
- **議論はある？**: データセットは44職種・各30タスク程度で、全職業タスクを代表するにはまだ狭い。対象はPC上で完結するデジタル知識労働で、身体作業、対人コミュニケーション、暗黙知、専用ソフト、個人情報を含む業務は外れている。またタスクは一発回答で十分な文脈が与えられがちで、現実の「曖昧な依頼を解きほぐす」過程は弱い。自動graderも専門家評価の完全代替ではない。
- **次に読む/試すなら**: 1. 公開gold subsetを使って、自分のagent/scaffoldを同じ形式で評価する。2. 失敗要因をinstruction following、formatting、accuracyに分けてログ化する。3. under-contextualized設定で、曖昧な業務依頼への耐性を追加検証する。
- **キーワード**: `GDPval`, `AI benchmark`, `economic tasks`, `expert evaluation`, `pairwise comparison`, `frontier models`, `agent scaffolding`

## 気になったこと

- wins+tiesが高くても、実務導入では catastrophic error の期待損失が支配的になる領域がありそう。
- 「専門家の成果物」を基準にしているが、専門家側にも品質ばらつきがあるため、職種ごとの評価分散をもっと見たい。
- 自動graderが66%一致なら便利だが、モデル改善の最適化対象にするとgrader overfittingが起きないか確認したい。
- タスクがwell-specified寄りなので、実務で重要な要件定義・追加質問・曖昧性解消をどう評価するかが次の論点。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
