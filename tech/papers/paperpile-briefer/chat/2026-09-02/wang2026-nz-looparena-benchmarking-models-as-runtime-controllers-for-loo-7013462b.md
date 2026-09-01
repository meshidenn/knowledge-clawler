# Chat Prompt 2026-09-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {LoopArena}: Benchmarking models as runtime Controllers for loop Engineering

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-02 - LoopArena: Benchmarking Models as Runtime Controllers for Loop Engineering

## 基本情報

- **タイトル**: LoopArena: Benchmarking Models as Runtime Controllers for Loop Engineering
- **著者**: Yi Wang, Haopeng Zhang, Chengxiang Huang, Rui Dai, Kaikui Liu, Piotr Koniusz, Xiangxiang Chu
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.28281](https://arxiv.org/abs/2608.28281) / [GitHub](https://github.com/AMAP-ML/LoopArena)

## 落合陽一フォーマット

- **ひとことでいうと**: 長時間のコーディングエージェントを「次に何をさせるか」で管理するLLM、すなわちControllerの能力を、Workerの実装能力から切り分けて測るベンチマーク。
- **先行研究と比べてどこがすごい？**: SWE-bench系が最終成果物からエージェント全体を測るのに対し、Worker・ツール・予算・評価器を固定して、外側のループ制御だけを比較対象にした。単一判断（Type I）、途中工程（Type II）、全タスク（Type III）の3粒度を用意し、安価な評価と本番に近い評価を接続している。
- **技術や手法の肝はどこ？**: Workerの作業後、読み取り専用のReporterが進捗・検証根拠・未解決点をEvidence Packetとして要約し、Controllerが次のLoop Contractを返す。Contractは `advance`、`verify`、`stop` と次の作業指示からなり、Controller自身はコード編集やツール実行をしない。Type Iでは候補Contractを事前リプレイし、実行結果で正解を固定する。
- **どうやって有効だと検証した？**: SCBenchとBeyondSWE由来の27タスクをType II/IIIで評価し、Type Iには90問を構成した。Type IIIの全タスク評価で最高Strict Success Rateは24.69%に留まり、長期ループ制御の難しさを示した。Type IIはType IIIと主要基準で高い順位相関（Spearmanのρ=0.9747）を示しつつ、推定推論コストを平均64.4%削減した。
- **議論はある？**: 27タスク・90問という規模で、特定のWorker、Reporter設計、実行環境に結果が依存する。Reporterの要約品質がController評価に混入しうるほか、Type Iの「正解」は事前定義されたリプレイ条件での勝者であり、すべての実行条件で普遍的に最適とは限らない。実運用での異種Workerや異なる組織的開発フローへの一般化は未検証。
- **次に読む/試すなら**:
  1. 公開ハーネスで、自分が使うWorkerを固定したController比較を再現する。
  2. Evidence Packetの粒度・根拠引用の有無を変え、Controller性能への影響を測る。
  3. `fixed control`（目標の反復）と状態依存Controllerを、自分の開発タスクで比較する。
- **キーワード**: `coding agents`, `agent orchestration`, `loop engineering`, `benchmark`, `runtime control`

## 気になったこと

- ReporterがWorkerと同一モデル設定であることは、要約の品質差をどの程度Controller性能に混入させるか。
- Type IIとType IIIの順位相関が高いのは、どのモデル群・どの種類のタスクでも維持されるのか。
- 実運用で重要な「人間へのエスカレーション」や、要件変更・外部サービス障害を含む制御は評価対象外である。
- Strict Success Rateが24.69%のとき、失敗の主因が停止判断、検証不足、指示分解、Worker能力のどれにあるかを分解して見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
