# Chat Prompt 2026-08-25

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Search-{o1}: Agentic search-enhanced large reasoning models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-25 - Search-{o1}: Agentic Search-Enhanced Large Reasoning Models

## 基本情報

- **タイトル**: Search-{o1}: Agentic Search-Enhanced Large Reasoning Models
- **著者**: Xiaoxi Li, Guanting Dong, Jiajie Jin, Yuyao Zhang, Yujia Zhou, Yutao Zhu, Peitian Zhang, Zhicheng Dou
- **年 / venue**: 2025 / EMNLP 2025
- **リンク**: [論文PDF](https://aclanthology.org/2025.emnlp-main.276.pdf) / [実装](https://github.com/RUC-NLPIR/Search-o1)

## 落合陽一フォーマット

- **ひとことでいうと**: o1系の長い推論の途中で知識不足を自律検知してWeb検索し、得た長文を別モジュールで圧縮・吟味してから推論へ戻すAgentic RAGフレームワーク。
- **先行研究と比べてどこがすごい？**: 問題ごとに一度だけ検索する通常RAGではなく、推論の各段階で必要に応じて複数回検索する。さらに検索結果をそのままCoTへ流し込まず、`Reason-in-Documents`で現在の検索クエリと直前の推論文脈に沿った情報へ精製するため、ノイズによる推論破綻を抑える。
- **技術や手法の肝はどこ？**: LRMが特殊トークンで検索クエリを生成すると推論を中断し、検索結果を取得する。その後、独立した文書読解モジュールが「直前の推論・検索クエリ・取得文書」から有用な事実だけを抽出し、短い根拠として推論列へ注入する。検索と推論を反復できる設計である。
- **どうやって有効だと検証した？**: QwQ-32B-Previewを主バックボーンに、GPQA、MATH500、AMC 2023、AIME 2024、LiveCodeBenchと、6つのopen-domain QAで直接推論・通常RAG・Agentic RAGと比較した。複雑推論5タスク平均で、Reason-in-DocumentsなしのAgentic RAGを4.7%、直接推論を3.1%上回ったと報告する。GPQAではQwQ-32Bの58.1に対し63.6、GPQA拡張セットでは人間専門家平均48.9に対し57.9だった。
- **議論はある？**: 検索ツールのみを対象とし、計算機・コード実行・外部APIは未統合。検索利用は主にプロンプト指示に依存しており、検索方策や検索結果の利用をfine-tuning/RLで最適化していない。Web検索の鮮度・出典品質・検索コスト・誤情報への頑健性も十分には検証されていない。対象はテキストLRMで、マルチモーダル推論は未検証。
- **次に読む/試すなら**:
  1. 公開実装で、検索結果を直接投入する条件とReason-in-Documentsを挟む条件を比較する。
  2. 自分のタスクで、検索回数・取得件数・精製後コンテキスト長に対する精度とレイテンシを計測する。
  3. 検索根拠の引用・検証器・コード実行を加え、検索の誤りが最終回答へ伝播するケースを評価する。
- **キーワード**: `agentic RAG`, `large reasoning models`, `test-time search`, `document refinement`, `o1-like reasoning`

## 気になったこと

- 検索を起動する「不確実性」の判断は、明示的な不確実性推定器ではなくモデル自身のクエリ生成に依存している。不要検索・検索漏れをどう定量評価するか。
- 精製モジュール自体が検索文書を誤読・要約してしまう場合に、元文書へ遡って検証する経路がない。
- 評価時のBing検索結果は時点や地域で変動するため、再現実験には取得済みコーパス・検索ログ・キャッシュの公開が重要になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
