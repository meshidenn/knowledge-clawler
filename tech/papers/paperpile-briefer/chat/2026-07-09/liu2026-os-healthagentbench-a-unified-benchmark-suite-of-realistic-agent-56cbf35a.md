# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {HealthAgentBench}: A unified benchmark suite of realistic agentic healthcare environments for challenging frontier {AI} agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - HealthAgentBench: A unified benchmark suite of realistic agentic healthcare environments for challenging frontier AI agents

## 基本情報

- **タイトル**: HealthAgentBench: A unified benchmark suite of realistic agentic healthcare environments for challenging frontier AI agents
- **著者**: Qianchu Liu, Sheng Zhang, Guanghui Qin, Jeya Maria Jose Valanarasu, Maximilian Rokuss, Mingyu Lu, Timothy Ossowski, Juan Manuel Zambrano Chaves, Cliff Wong, Peniel Argaw, Yashna Hasija, Mu Wei, Wen-Wai Yim, Qin Liu, Zilin Jing, Jason Entenmann, Naoto Usuyama, Tristan Naumann, Hoifung Poon
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2606.31179 / https://github.com/microsoft/HealthAgentBench

## 落合陽一フォーマット

- **ひとことでいうと**: 医療AIエージェントを、静的QAではなくDocker上の実行環境で評価するための、54タスク・7カテゴリからなる統合ベンチマークを作った論文。
- **先行研究と比べてどこがすごい？**: 既存の医療ベンチマークがQA、対話シミュレーション、単一モダリティ、固定ワークフローに寄りがちな一方で、本研究はX-ray、CT、病理WSI、臨床テキスト、構造化EHRをまたぎ、診断・治療計画・データ管理・研究ワークフローを実行環境としてまとめている。現行 frontier agent でも最高が約42%成功率に留まり、飽和していない点も強い。
- **技術や手法の肝はどこ？**: 各タスクをDocker/Harborベースのterminal環境としてパッケージ化し、agentには最小限の自然言語指示と生データだけを与える。agentはファイル探索、画像処理、DBクエリ、ツール導入、コード実行などを自律的に行い、最終出力を`submission.json`などに書く。評価は環境外のhidden expert labelsやverifierで二値成功/失敗に落とす。
- **どうやって有効だと検証した？**: 10種類のfrontier agentをHealthAgentBench上で評価。カテゴリはEHR Format Conversion、X-ray Report Correction、Clinical Trial Matching、CT Abnormality Classification、Pathology Tumor Area Selection、EHR Event Modelling、EHR Data Quality Auditing。成功基準はカテゴリごとに、全チェック通過、臨床的重大エラーなし、Recall@top-50、全ラベル正解、tile-level F1閾値、AUROC baseline超え、エラークラスタ全検出などで定義している。
- **議論はある？**: 医療画像、特にCTや病理WSIは依然として難しく、汎用agentだけでは臨床利用に近い性能には遠い。タスク数は54で多様だが、医療全体を網羅するものではない。PDF抽出テキスト上では、詳細な表や一部数値はレイアウト崩れの可能性があるため過度な断定は避けたい。
- **次に読む/試すなら**: 1. GitHubのタスク定義とverifierを確認する。2. 自分のagentを1カテゴリだけ走らせ、失敗ログを分類する。3. 医療画像タスクでvision専用バックエンドやOpenSlide処理を追加した場合の改善幅を見る。
- **キーワード**: `healthcare agent benchmark`, `agentic AI`, `medical imaging`, `EHR`, `Docker environment`, `terminal-based evaluation`

## 気になったこと

- 二値成功/失敗に落とすことで比較はしやすいが、臨床的に「部分的に有用」な出力をどの程度捨てているのか。
- 医療画像タスクでCodex系がClaude Code系より強い理由が、モデル能力なのか、ツール利用戦略なのか、環境適応なのかを分解したい。
- hidden labelsやexpert-derived criteriaの品質、再現性、公開範囲を確認したい。
- 実運用に近づけるなら、インターネット利用可・依存追加可という設定がどこまで現実の医療環境と整合するかが論点になる。
- 関連研究として、Terminal-Bench、MedAgentBench、PhysicianBench、AutoMedBench、HealthAdminBenchとの評価設計差分を追うとよさそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
