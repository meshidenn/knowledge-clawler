# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {AgenticDataBench}: A Comprehensive Benchmark for Data Agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - AgenticDataBench: A Comprehensive Benchmark for Data Agents

## 基本情報

- **タイトル**: AgenticDataBench: A Comprehensive Benchmark for Data Agents
- **著者**: Zhaoyan Sun, Shan Zhong, Daizhou Wen, Jiaxing Han, Guoliang Li, Ying Yan, Peng Zhang, Yu Su, Xiang Qi, Baolin Sun, Chengyuan Yang, Tao Fang, Huaiyu Ruan
- **年 / venue**: 2026 / arXiv [cs.DB]
- **リンク**: https://arxiv.org/pdf/2607.01647

## 落合陽一フォーマット

- **ひとことでいうと**: LLMベースのdata agentを、実世界に近いデータサイエンス作業で細かく評価するための包括的ベンチマーク AgenticDataBench を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存ベンチマークが少数のタスク種別や粗いスコアに寄りがちな点に対し、15ドメイン、344タスク、342データファイル、27.3GB規模のデータを用意し、433個のdata science skillでタスクを細粒度に注釈している。実世界B2Bユースケースも含め、単なる正解率ではなく「どのスキルで失敗したか」まで見える設計。
- **技術や手法の肝はどこ？**: Stack Overflowの大量の解法からLLMで手順単位のskill記述を抽出し、embeddingによる階層クラスタリングとLLMによる分割・精緻化で433個のskill treeを作る。さらに、実ビジネスタスクはskill構成の多様性が最大化されるよう選択し、public datasetではdataset profileとskill samplingを使ってLLMにworkflowとtaskを生成させる。
- **どうやって有効だと検証した？**: Smolagents、DA-Agent、Claude Code、CodeXの4種類のagent harnessと、Qwen3.5-397B-A17B、Kimi-K2.5、Claude Sonnet 4.6の組み合わせを評価。table/modeling/JSON/chart/text matchingなどの評価関数でPass@1を測り、さらにLLMを使ったskill-level failure analysisを行っている。総合ではCodeX + Kimi-K2.5が最も高いスコアを示したが、ドメインごとに最良のagentは異なった。
- **議論はある？**: LLMによるskill抽出・task生成・failure analysisに依存しており、注釈品質や評価の再現性には注意が必要。PDF本文では専門家による検証や960 person-hoursの注釈が述べられているが、生成タスクが本当に実務の曖昧さや組織固有の制約を再現できるかは追加確認が必要。評価対象のモデル・agent harnessも時点依存で、2026年以降のagentには再評価が必要。
- **次に読む/試すなら**: AgenticDataBenchのGitHubを確認して、データ・評価関数・実行環境がどこまで公開されているか見る。自分のdata agentを1〜2タスクだけ走らせて、skill-levelの失敗分析が実用的か確認する。既存のDSBench、BLADE、DataSciBenchとの差分を表で比較する。
- **キーワード**: `data agent`, `benchmark`, `data science automation`, `LLM agent`, `skill-level evaluation`, `AgenticDataBench`

## 気になったこと

- skill抽出に使ったStack Overflow解法が、現代のdata science実務や企業内ワークフローをどこまで代表しているか。
- LLM-generated tasksの品質保証で、どの程度人手修正が入っているのか。
- skill-level failure analysisにLLMを使う場合、評価者LLMのバイアスやagentとの相性が結果に混ざらないか。
- CodeX + Kimi-K2.5が高スコアだった理由が、汎用的なagent設計の優位なのか、ベンチマーク環境との相性なのか。
- 公開testbedで商用・非公開データ由来のB2Bタスクがどの程度再現されているか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
