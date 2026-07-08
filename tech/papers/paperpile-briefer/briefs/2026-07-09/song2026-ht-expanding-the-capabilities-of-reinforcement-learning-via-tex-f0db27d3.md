# Paperpile Brief 2026-07-09 - Expanding the capabilities of reinforcement learning via Text Feedback

## 基本情報

- **タイトル**: Expanding the capabilities of reinforcement learning via Text Feedback
- **著者**: Yuda Song, Lili Chen, Fahim Tajwar, Remi Munos, Deepak Pathak, J. Andrew Bagnell, Aarti Singh, Andrea Zanette
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのRL post-trainingにおいて、単なるスカラー報酬や選好ラベルではなく、訓練時だけ利用できる自然言語フィードバックを使って性能を上げるRLTFという枠組みを提案した論文。
- **先行研究と比べてどこがすごい？**: 通常のRLHF/RLでは1 rolloutあたり報酬や選好のような粗い信号しか使わない一方、蒸留は密な教師信号を得られるが完全なデモが必要になる。本研究はその中間として、より安価で豊富な「テキストによる批評」を訓練信号にする点が新しい。
- **技術や手法の肝はどこ？**: 訓練時にはモデル出力に対するテキストフィードバックを与え、推論時にはフィードバックなしのsingle-turn性能を改善するように学習する。方法として、自身のフィードバック条件付き2ターン目生成をsingle-turn policyに合わせる **RLTF-SD** と、フィードバック予測を補助目的にする **RLTF-FM** を提案している。
- **どうやって有効だと検証した？**: reasoning puzzles、competition math、creative writing tasksで評価し、強いbaseline群に対して両手法が一貫して上回ったとされる。ただしPDF本文がなく、具体的なベンチマーク名、数値、比較設定、統計的有意性はメタデータからは不明。
- **議論はある？**: テキストフィードバックの品質・一貫性・コスト、訓練時フィードバックを推論時性能へどれだけ内在化できるかが重要な仮定になる。PDF本文がないため、理論解析の条件、失敗例、スケーリング時の限界、feedback generatorの詳細は不明。
- **次に読む/試すなら**: RLTF-SDとRLTF-FMの損失関数を確認する。既存のRLHF/DPO/蒸留との比較設定を読む。小さな数学・推論タスクで「批評テキストあり訓練、なし推論」の最小実験を組む。
- **キーワード**: `RLTF`, `text feedback`, `reinforcement learning`, `LLM post-training`, `self distillation`, `feedback modeling`, `RLHF`

## 気になったこと

- テキストフィードバックは人間が書くのか、自動judgeが生成するのか、あるいは両方なのか。
- RLTF-SDは誤ったフィードバックや低品質な2ターン目生成を蒸留してしまうリスクをどう扱うのか。
- RLTF-FMの補助目的は、実際に推論能力を上げているのか、それともfeedback distributionへの適応に留まるのか。
- creative writingのような主観的評価で、テキストフィードバックの有効性をどう測っているのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [song2026-ht-expanding-the-capabilities-of-reinforcement-learning-via-tex-f0db27d3.md](../../chat/2026-07-09/song2026-ht-expanding-the-capabilities-of-reinforcement-learning-via-tex-f0db27d3.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
