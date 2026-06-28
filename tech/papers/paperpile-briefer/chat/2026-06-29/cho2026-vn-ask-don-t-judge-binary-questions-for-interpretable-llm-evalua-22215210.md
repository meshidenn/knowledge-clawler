# Chat Prompt 2026-06-29

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Ask, don't judge: Binary questions for interpretable {LLM} evaluation and self-improvement

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-29 - Ask, don't judge: Binary questions for interpretable {LLM} evaluation and self-improvement

## 基本情報

- **タイトル**: Ask, don't judge: Binary questions for interpretable {LLM} evaluation and self-improvement
- **著者**: Sangwoo Cho, Kushal Chawla, Pengshan Cai, Zefang Liu, Chenyang Zhu, Shi-Xiong Zhang, Sambit Sahu
- **年 / venue**: 2026 / arXiv [cs.AI], accepted to the 2nd Workshop on Compositional Learning at ICML 2026
- **リンク**: https://arxiv.org/pdf/2606.27226

## 落合陽一フォーマット

- **ひとことでいうと**: LLM評価を単一スコアで「判定」させるのではなく、タスク要件を細かいYes/No質問に分解して、解釈可能な多次元スコアと改善フィードバックを得るBINEVALを提案した論文。
- **先行研究と比べてどこがすごい？**: G-Evalのような一括LLM judgeはスコアの理由が曖昧で、UniEvalは多次元評価だが学習済み評価器に依存する。BINEVALは学習不要・タスク非依存で、評価基準そのものを原子的な二値質問へ分解する点が差分。SummEval、Topical-Chat、QAGSでUniEvalやG-Evalに匹敵または上回り、特に事実整合性評価で強いと報告している。
- **技術や手法の肝はどこ？**: タスクプロンプトから要件を抽出し、それぞれを「満たしているか？」の二値質問に変換する。評価LLMは各質問に独立にYes/Noと説明を返し、質問単位の平均から次元別・全体スコアを作る。さらに、失敗した質問やモデル間の不一致を「レッスン」として抽出し、評価プロンプトや生成プロンプトを反復更新する。
- **どうやって有効だと検証した？**: SummEval、Topical-Chat、QAGSで人間評価とのSpearman、Kendall、Pearson相関を比較した。ベースラインはUniEval、G-Evalなど。加えて、SummEvalとIFBenchで自己更新およびクロスモデル更新を行い、質問レベルのフィードバックがプロンプト改善に使えることを示した。PDF本文では、短すぎるが妥当な要約や部分的に読める文など、従来の一括判定が極端なスコアに倒れるケースでBINEVALがより人間評価に近い例も示している。
- **議論はある？**: 二値質問の品質はメタプロンプトと評価LLMに依存する。Yes/No化により解釈性は上がるが、曖昧な基準や主観的品質を過度に離散化する可能性がある。実験はgpt-oss-120bとClaude Sonnet 4を中心に温度0・2回平均で行われており、モデルやデータセットを変えた頑健性はさらに確認が必要。高リスク用途では評価LLMのバイアスや盲点を人間が監督すべきだと本文も述べている。
- **次に読む/試すなら**: BINEVAL風に自分のLLM出力評価タスクを10〜30個の二値質問へ分解してみる。既存のLLM judgeスコアと質問平均スコアの相関・分布を比較する。失敗質問からプロンプトを更新する最小ループをSummEval風の小規模データで再現する。
- **キーワード**: `LLM evaluation`, `LLM-as-a-judge`, `binary questions`, `interpretable evaluation`, `prompt optimization`, `BINEVAL`

## 気になったこと

- 二値質問を自動生成したとき、質問の冗長性・抜け・重み付けをどう制御するのがよいか。
- 全質問を単純平均する設計で、致命的な factual error と軽微な文体ミスを同じ重みにしてよいのか。
- 評価LLM自身が誤ったYes/Noを返す場合、質問分解はどこまでロバスト性を上げるのか。
- RAG評価、エージェント評価、コード生成評価に適用する場合、質問単位のキャリブレーションが必要そう。
- arXiv IDはPDF本文から `2606.27226v1` と読めるが、メタデータの `arxiv_id` 欄は空。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
