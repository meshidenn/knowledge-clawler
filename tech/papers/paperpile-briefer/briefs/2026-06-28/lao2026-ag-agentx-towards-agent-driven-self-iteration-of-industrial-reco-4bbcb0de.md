# Paperpile Brief 2026-06-28 - AgentX: Towards agent-driven self-iteration of industrial recommender systems

## 基本情報

- **タイトル**: AgentX: Towards agent-driven self-iteration of industrial recommender systems
- **著者**: Changxin Lao, Fei Pan, Guozhuang Ma, Han Li, Huihuang Lin, Jijun Shi, Kangzhi Zhao, Kun Gai, Mo Zhou, Qinqin Zhou, Quan Chen ほか
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2606.26859 / arXiv:2606.26859

## 落合陽一フォーマット

- **ひとことでいうと**: 産業用推薦システムの仮説生成、実装、A/B評価、学習を、複数エージェントで閉ループ化し、自己改善する開発基盤 AgentX を実運用した論文。
- **先行研究と比べてどこがすごい？**: AutoMLや研究自動化ではなく、Kuaishou Appの本番推薦でオンラインA/Bを報酬信号にしている点。3週間で374アイデアから10件のローンチ可能施策を作り、8倍の並列性、手動エンジニア比3.7倍の事業価値、ユーザーアプリ滞在時間+0.561%、年換算RMB 100M超の売上効果を主張している。
- **技術や手法の肝はどこ？**: Brainstorm Agentが実験KB、システムKB、データ分析、外部研究を重み付けして実装可能な提案に絞る。Developing Agentはリポジトリ知識、スキーマ照会、DSLチェック、C++チェック、Dryrunで「動くコード」ではなく「本番で安全にレビュー可能な差分」を作る。Evaluation Agentは安全なトラフィック投入、CUPED/DiD等を含むA/B判定、ガードレール拒否、失敗知識化を担う。さらにSGPOで実行軌跡をプロンプト/エージェント仕様の改善へ戻す。
- **どうやって有効だと検証した？**: PDF本文では、Kuaishou Appのメインフィードとライフサービス推薦で3週間の本番デプロイを行ったとされる。評価はオンラインA/B、ローンチ件数、並列性、事業価値、アプリ滞在時間、年換算売上を含む。ただし抽出本文は20ページ分までで、実験章の詳細な表や統計条件は取得範囲外のため、細かい数値の検定条件はメタデータ/抽出本文からは不明。
- **議論はある？**: 本番内部システム依存が強く、外部再現性は低い。人間レビューや社内OpenAPI、社内KB、A/B基盤が前提なので、AgentX単体の汎用性は未検証。提示された効果は強いが、抽出本文からは対照条件、分散、長期副作用、失敗率、コスト、ガードレール詳細までは確認できない。
- **次に読む/試すなら**: 1. SGPOの更新規則とpaired replayの詳細を確認する。2. Developing Agentの8次元品質スコアを自分のコード生成ワークフローに置き換えて試す。3. 失敗実験をKB化して次回提案の制約に戻す最小ループを作る。
- **キーワード**: `LLM agent`, `recommender systems`, `A/B testing`, `self-evolution`, `multi-agent system`, `production ML`, `SGPO`

## 気になったこと

- オンラインA/Bを報酬にすると強いが、探索の多重検定、季節性、他施策との干渉をどこまで制御しているか。
- 「自己改善」がプロンプト最適化中心なのか、基盤モデル学習まで含むのか、その寄与分解。
- 374アイデアから10ローンチまでの脱落理由、失敗パターン、人的レビュー介入率。
- 社内KBの品質維持がボトルネックにならないか。
- 推薦以外の本番ML、例えば広告、検索、ランキング、CRMに移植できる境界条件。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [lao2026-ag-agentx-towards-agent-driven-self-iteration-of-industrial-reco-4bbcb0de.md](../../chat/2026-06-28/lao2026-ag-agentx-towards-agent-driven-self-iteration-of-industrial-reco-4bbcb0de.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
