# Chat Prompt 2026-07-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {DeepSearch}-World: Self-distillation for deep search agents in a verifiable environment

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-23 - DeepSearch-World: Self-distillation for deep search agents in a verifiable environment

## 基本情報

- **タイトル**: DeepSearch-World: Self-distillation for deep search agents in a verifiable environment
- **著者**: Xinyu Geng, Xuanhua He, Sixiang Chen, Yanjing Xiao, Fan Zhang, Shijue Huang, Haitao Mi, Zhenwen Liang, Tianqing Fang, Yi R. Fung
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.07820

## 落合陽一フォーマット

- **ひとことでいうと**: 検証可能なオフラインWikipedia検索環境 DeepSearch-World を作り、その中でエージェント自身の成功軌跡を反復的に蒸留して、deep search agent を強くする論文。
- **先行研究と比べてどこがすごい？**: SFT は固定軌跡の模倣で伸びが頭打ちになりやすく、RL は長いtool-useで報酬が疎すぎる。この論文は、検索・閲覧結果が決定的に再現でき、entity単位で途中進捗を検証できる環境を用意し、強い外部教師なしに自己生成軌跡から性能を上げる点が差分。DeepSearch-World-9B は BrowseComp 31.2%、GAIA 61.5%、HotpotQA 93.4% を報告している。
- **技術や手法の肝はどこ？**: 420K個のmulti-hop QAをWikipedia hyperlink graphのentity-level random walkから作り、約1000万entryのオフラインWikipedia corpusに接続する。toolはBM25検索の `web_search_wiki` とSQLite offset indexで本文を読む `visit_wiki`。各問題に正解entity集合を持たせ、tool callごとに未解決entityへ到達したかを検証し、失敗時には段階的なgrounded reflectionを返す。生成時はscaffold teacherが計画・作業記憶・失敗経験・証拠を明示的に持ち、学習時にはそれをReAct形式へ変換してSFTする。
- **どうやって有効だと検証した？**: BrowseComp、BrowseComp-ZH、HLE、GAIA、xbench、HotpotQA、Search-QA系で評価。Qwen3.5-9B-Instructから11ラウンドのself-evolving trainingを行い、全ベンチマークでbackboneを上回った。行動分析では平均interaction roundが4.7から18.0、search callが3.8から12.6、visit callが0.9から5.4に増え、Advanced Capability Scoreも19%から70%へ上がったと報告している。ablationでは rejection sampling と trajectory quality filtering、state internalization、reflection rewriting が効いている。
- **議論はある？**: 環境がWikipedia中心なので、実Webや専門ドメインへの一般化には限界がある。entity-level verificationは強力だが、正解entity集合を持てるタスクに依存する。学習はevolving SFT中心で、RLやOPSDとの最適な統合は未解決。PDF抽出本文では、code/data/envをrelease予定とあるが、メタデータからは実際の公開状態は不明。
- **次に読む/試すなら**: 1. DeepSearch-Worldの環境・データ公開状況を確認する。 2. 自前の論文検索/技術文書corpusでentity-level verificationを作れるか試す。 3. scaffold-to-ReAct変換が既存agent training pipelineに入るか最小実装する。
- **キーワード**: `deep search agent`, `self-distillation`, `verifiable environment`, `ReAct`, `tool-use agent`, `multi-hop QA`, `Wikipedia`, `trajectory filtering`

## 気になったこと

- Wikipedia以外のWeb、PDF、GitHub、企業ドキュメントのような半構造・非構造データで、同じentity-level verificationをどう作るか。
- 失敗時reflectionが強すぎると、自己蒸留というより環境oracleに近づく可能性がある。どの程度のヒントまでが妥当か確認したい。
- offline BM25環境からreal web toolsへ移したときのdistribution gapを、追加GRPO 1,600 real-tool instancesでどこまで埋められるのか。
- ablation上はreflection rewritingがかなり重要なので、ReAct変換promptやartifact除去の具体実装を読む価値が高い。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
