# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Meta-{RL} induces exploration in language agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - Meta-RL induces exploration in language agents

## 基本情報

- **タイトル**: Meta-RL induces exploration in language agents
- **著者**: Yulun Jiang, Liangze Jiang, Damien Teney, Michael Moor, Maria Brbić
- **年 / venue**: 2025 / arXiv [cs.LG]、PDF本文上では ICLR 2026 conference paper
- **リンク**: https://arxiv.org/abs/2512.16848v2

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agentにMeta-RLを使い、複数エピソードにまたがる試行錯誤から「探索してから活用する」方策を学ばせるLaMerを提案した論文。
- **先行研究と比べてどこがすごい？**: 通常のRLが単一エピソード報酬を最大化して固定的な方策に寄りがちな点に対し、LaMerはcross-episode returnを最適化する。Sokoban、MineSweeper、WebshopでRL baselineを上回り、pass@3でそれぞれ55.9%、74.4%、89.1%を達成。最良RL比でSokobanは約11.8pt、MineSweeperは約19.3pt、Webshopは約13.9pt改善している。
- **技術や手法の肝はどこ？**: 試行を複数エピソード列として扱い、前の失敗・軌跡・reflectionを次エピソードのcontextに入れて方策を適応させる点。報酬もエピソード内だけでなく、trajectory discount factor `gamma_traj` によって後続エピソードの成果まで伝播させ、初期エピソードの探索行動を学習対象にする。
- **どうやって有効だと検証した？**: Qwen3-4Bを主なbase modelとして、Sokoban、MineSweeper、Webshop、ALFWorldで評価。Zero-shot、ReAct、Reflexion、PPO、RLOO、GRPO、GiGPOと比較し、pass@1/2/3、trajectory diversity、難化タスク、ALFWorldのOODカテゴリで検証している。ALFWorldではMeta-RLがCoolで81.0%、Pick2で50.2%を出し、RLの58.1%、36.0%を上回る。
- **議論はある？**: エピソード間依存があるためrolloutを逐次生成する必要があり、現在の実装では通常RLより訓練時間が約2倍かかる。`gamma_traj` の最適値は環境依存で、探索を強めれば常に良いわけではない。また、完全に未知な環境への汎化までは実証されておらず、主に同種または比較的近いドメインでの難化・分布シフト評価に留まる。
- **次に読む/試すなら**: LaMerの公開コードでSokobanまたはMineSweeperの最小実験を動かす。`reflection-only` memoryがdefaultより良い理由を再現確認する。自分のagent環境でcross-episode reward設計と`gamma_traj` sweepを試す。
- **キーワード**: `Meta-RL`, `LLM agent`, `exploration`, `in-context adaptation`, `self-reflection`, `test-time scaling`, `cross-episode training`

## 気になったこと

- reflection-onlyがtrajectory+reflectionより良いなら、長い履歴をcontextに入れるより「圧縮された失敗知識」を学習させる方が重要なのか。
- 探索の多様性はentropyで測っているが、それが「有用な探索」か「単なるばらつき」かを分ける指標が必要そう。
- WebshopやALFWorldで、reflection文そのものが環境依存のprompt engineeringに強く依存していないか確認したい。
- 実運用agentでは、失敗エピソードのコストが高い場合にcross-episode探索をどう制約するかが論点になりそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
