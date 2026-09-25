# Chat Prompt 2026-09-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Does on-policy distillation really distill? From noisy teacher to self-improvement

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-02 - Does on-policy distillation really distill? From noisy teacher to self-improvement

## 基本情報

- **タイトル**: Does on-policy distillation really distill? From noisy teacher to self-improvement
- **著者**: Yi Ding, Ruqi Zhang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2608.31046v1 （arXiv:2608.31046v1）

## 落合陽一フォーマット

- **ひとことでいうと**: On-policy distillation（OPD）の性能向上は教師からの知識蒸留よりも、低確率トークンを抑制する効果で説明できると示し、教師・報酬・正解なしで同効果を得るOn-Policy Self-Adaptation（OPSA）を提案した論文。
- **先行研究と比べてどこがすごい？**: OPDでは教師が学生生成軌跡を採点するため教師にとってoff-policyとなり、教師信号のノイズが大きいことを定量化した。しかもノイズのみで学習しても性能が大きく変わらない点から、「蒸留」という前提そのものを問い直している。OPSAは教師logitへのwhite-boxアクセスやヒント、検証可能報酬を不要にする。
- **技術や手法の肝はどこ？**: 学生が生成したトークンのうちlog-probabilityが低い下位20%を対象に、トークンエントロピーに応じた負のadvantageを与える。これにより低確率のtail tokenを抑制しつつ、高エントロピーな分岐点ではhead token間の確率質量を再配分して探索多様性を保つ。
- **どうやって有効だと検証した？**: Qwen3-1.7Bを学生、Qwen3-4B/30B-A3B/235B-A22B-Instructを教師としてOPD信号を分析した。AIME24・AIME25・HMMT25で評価し、Qwen3-1.7BではAIME24のAvg@32を35.41ポイント改善、OPD比でも16.77ポイント上回ったと報告している。モデルファミリー・タスクをまたぐ実験、ノイズ信号の除外／限定、トークン選択率とadvantage設計のablationも行う。
- **議論はある？**: ノイズの定義は、検証可能な最終回答トークンでadvantageの符号と正誤が食い違う場合に限られ、中間推論の品質までは測れていない。実験は最大9B程度であり、大規模モデルやMoEへのスケール性は未検証。既に分布が鋭い強くpost-training済みのモデルでは効果が小さい可能性があり、探索のフロンティア自体を広げる手法ではない。
- **次に読む/試すなら**:
  - OPDのK1 estimatorと、負のadvantageだけで改善する勾配機構を数式レベルで追う。
  - 小規模なQwen系モデルで、下位20%低logpトークンへの固定負advantageとentropy-adaptive負advantageを比較する。
  - OPD、OPSA、RLVRを同一計算予算で比較し、Pass@k・応答長・多様性・エントロピー推移を測定する。
- **キーワード**: `on-policy distillation`, `self-improvement`, `token-level reinforcement learning`, `negative advantage`, `entropy`, `LLM reasoning`

## 気になったこと

- 「教師信号は不要」という結論が、数学推論ベンチマーク以外のコード生成・対話・事実性タスクでも成立するか。
- 低確率トークンの抑制が、誤ったが高確率なトークンへの過信やmode collapseをどこまで回避できるか。
- エントロピーに応じたadvantageの設計が、tokenizer、温度、長さ正規化、KL正則化にどの程度敏感か。
- OPDの改善を「蒸留」ではなく自己分布の再整形と捉えるなら、既存のself-distillation研究との境界をより厳密に比較したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
