# Chat Prompt 2026-07-18

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- A two-dimensional framework for {AI} agent design patterns: Cognitive Function and Execution Topology

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-18 - A two-dimensional framework for AI agent design patterns: Cognitive Function and Execution Topology

## 基本情報

- **タイトル**: A two-dimensional framework for AI agent design patterns: Cognitive Function and Execution Topology
- **著者**: Jia Huang, Joey Tianyi Zhou
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: arXiv:2605.13850v2 / https://arxiv.org/abs/2605.13850v2

## 落合陽一フォーマット

- **ひとことでいうと**: LLMベースのAI agent設計パターンを、「何をするか」という認知機能と「どう実行されるか」という実行トポロジーの2軸で整理する分類フレームワークを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のAnthropic、Google、LangChain系の整理は主に実行トポロジー、認知科学系のsurveyは主に機能分類に寄っており、同じ構造でも異なる目的を持つagent設計を区別しにくい。本論文は7つのCognitive Functionと6つのExecution Topologyを掛け合わせ、7×6の行列として28個のnamed patternを整理する点が差分。
- **技術や手法の肝はどこ？**: 軸1はPerception, Memory, Reasoning, Action, Reflection, Collaboration, Governanceの7カテゴリ。軸2はChain, Route, Parallel, Orchestrate, Loop, Hierarchyの6 archetype。これにより、たとえば同じOrchestrator-Workers構造でも、Plan-and-Execute、Hierarchical Delegation、Observability Harnessを別パターンとして扱える。
- **どうやって有効だと検証した？**: PDF本文では、軸同士が独立していることを、同じLoop topologyがFailure Journal, Iterative Hypothesis Testing, Self-Heal Loopに使われる例や、ReasoningがChain, Route, Parallel, Loopで実装される例で示している。また、financial lending、legal due diligence、network operations、healthcare triageの4ドメインに適用し、パターン選択の説明力を確認している。
- **議論はある？**: 実証は主に記述的・分類的で、ベンチマークによる定量性能評価ではない。42セル中28セルが埋まっており、空セルが本質的に不可能なのか、未探索なのか、現在の技術制約なのかは未確定。パターン粒度も著者の設計判断に依存する。細かい数値や効果量はPDF抽出テキスト由来なので断定しすぎない方がよい。
- **次に読む/試すなら**: 自分のagent実装を7×6行列にマッピングして、混同しているpatternを洗い出す。特にGovernance系のApproval Gate、Observability Harness、Blast Radius Controlを設計チェックリスト化する。関連するAgent Design Pattern CatalogueやCognitive architectures for language agentsと比較する。
- **キーワード**: `AI agents`, `design patterns`, `cognitive function`, `execution topology`, `agent architecture`, `governance`

## 気になったこと

- このフレームワークは設計語彙としては有用だが、分類の妥当性をどう定量評価するかが気になる。
- 28個のパターンのうち、実装テンプレートとしてすぐ使えるものと、概念整理に近いものを分けたい。
- 「五つの経験則」は実務感がある一方、4ドメインからの帰納なので、より多様なagent運用例で検証したい。
- ReflectionのParallelやOrchestrateセルが空いている点は、multi-critic ensembleやmeta-critic設計として試せそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
