# Paperpile Brief 2026-06-04 - Harness-1: Reinforcement learning for search agents with state-externalizing harnesses

## 基本情報

- **タイトル**: Harness-1: Reinforcement learning for search agents with state-externalizing harnesses
- **著者**: Pengcheng Jiang, Zhiyi Shi, Kelly Hong, Xueqiang Xu, Jiashuo Sun, Jimeng Sun, Hammad Bashir, Jiawei Han
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: 検索エージェントを強化学習で改善する際に、「state-externalizing harnesses」という外部化された状態管理の仕組みを使う研究。本文・abstractがないため、具体的な問題設定や成果はメタデータからは不明。
- **先行研究と比べてどこがすごい？**: タイトルからは、検索エージェントの内部状態や探索過程をハーネス側に外部化し、強化学習しやすくする設計が新規性の中心に見える。ただし、既存手法との差分、性能向上、比較対象はメタデータからは不明。
- **技術や手法の肝はどこ？**: 「state-externalizing harnesses」が肝と思われる。検索中の状態、履歴、観測、行動、報酬設計などをエージェント内部に閉じず、外部ハーネスとして明示的に扱うことで、RLの学習信号や再現性を改善する狙いがあると推測されるが、詳細はメタデータからは不明。
- **どうやって有効だと検証した？**: メタデータからは不明。ベンチマーク、検索タスク、ベースライン、評価指標、アブレーションの有無は確認できない。
- **議論はある？**: PDF本文・abstractがないため不明。想定される論点は、ハーネス設計への依存、実環境検索への汎化、報酬設計の妥当性、学習コスト、状態外部化による情報リークや評価の公平性。
- **次に読む/試すなら**: arXiv IDまたはPDFを取得してabstractと実験設定を確認する。`state-externalizing harnesses` が具体的に何を外部化しているかを読む。既存の検索エージェントRL、tool-use RL、browser/search agent benchmarkとの比較を調べる。
- **キーワード**: `search agents`, `reinforcement learning`, `state externalization`, `agent harness`, `tool-use agents`

## 気になったこと

- 「Harness-1」がモデル名なのか、学習フレームワークなのか、評価環境なのかを確認したい。
- state-externalizing harnesses が、単なるログ・メモリ管理なのか、RL環境設計そのものなのかが重要。
- 検索エージェントの評価で、正解到達率・引用品質・探索効率・コストのどれを最適化しているのかを確認したい。
- 関連研究として、WebArena、BrowserGym、Search-R1、tool-use RL、agent trajectory optimization あたりを探したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [jiang2026-ci-harness-1-reinforcement-learning-for-search-agents-with-sta-4037c33a.md](../../chat/2026-06-04/jiang2026-ci-harness-1-reinforcement-learning-for-search-agents-with-sta-4037c33a.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
