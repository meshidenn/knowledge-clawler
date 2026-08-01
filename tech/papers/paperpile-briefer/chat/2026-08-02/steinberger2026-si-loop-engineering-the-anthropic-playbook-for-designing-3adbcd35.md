# Chat Prompt 2026-08-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Loop Engineering: The Anthropic Playbook for Designing Systems That Prompt Your Agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-02 - Loop Engineering: The Anthropic Playbook for Designing Systems That Prompt Your Agents

## 基本情報

- **タイトル**: Loop Engineering: The Anthropic Playbook for Designing Systems That Prompt Your Agents
- **著者**: Peter Steinberger, Boris Cherny, Addy Osmani
- **年 / venue**: 2026 / メタデータからは不明
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: AI agentに作業させるためのpromptやcontext設計を超えて、人間が直接作業する位置から外れ、agentを回す「loop」そのものを設計する考え方を整理した論文。
- **先行研究と比べてどこがすごい？**: prompt engineering、context engineering、harness engineeringの上位レイヤーとして「loop engineering」を定義し、1ターンを discovery / handoff / verification / persistence / scheduling の5つの動きに分解している点。特に、生成agentと評価agentを分ける設計を重視している。
- **技術や手法の肝はどこ？**: agentに自己評価させると出力を過大評価しがちなので、生成器とは独立した懐疑的な evaluator を置くこと。loopは単なる自動化ではなく、発見、引き継ぎ、検証、記録、次回実行のスケジューリングを含む作業循環として設計する。
- **どうやって有効だと検証した？**: PDF本文がないためabstractベース。1人のエンジニアの朝のtriageから、Stripeの週1,300件超のmachine-written pull request merge pipelineまで、実運用中の3つのloopをsurveyしているとされる。ただし、詳細な実験設定、比較対象、定量評価はメタデータからは不明。
- **議論はある？**: verification debt、comprehension rot、cognitive surrender、token blowout という4つの静かなコストを挙げている。生成コストがほぼゼロに近づく一方で、判断が希少資源になるという主張が中心。同じloopでも設計者次第で成果が逆になり得る点が重要。
- **次に読む/試すなら**: 最小loopを1つ作り、生成agentと評価agentを分離して精度を見る。既存の開発workflowで discovery / handoff / verification / persistence / scheduling がどこにあるか棚卸しする。Stripeのmachine-written PR pipelineに関する一次情報を探す。
- **キーワード**: `loop engineering`, `AI agents`, `generator evaluator separation`, `agent workflow`, `verification debt`

## 気になったこと

- 「Anthropic Playbook」と題しているが、Anthropicの公式文書なのか、Anthropic的な設計思想を参照した独立noteなのかはメタデータからは不明。
- 週1,300件超のmachine-written PRをmergeするStripe事例の根拠、期間、品質管理方法を確認したい。
- generator/evaluator分離の有効性について、どの程度 empirical evidence があるのかを本文で確認したい。
- loop engineeringと既存のworkflow automation、CI/CD、agent harness、eval pipelineとの差分をもう少し厳密に見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
