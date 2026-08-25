# Chat Prompt 2026-08-26

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Argus: A general-purpose agentic reasoning runtime for long-horizon tasks

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-26 - Argus: A general-purpose agentic reasoning runtime for long-horizon tasks

## 基本情報

- **タイトル**: Argus: A general-purpose agentic reasoning runtime for long-horizon tasks
- **著者**: Boxiu Li, Zimo Wen, Yijia Fan, Chuan Wen, Fan Yang, Hangxi Guo, Jiaao Wu, Jiachen Zhang, Junxiang Lei, Mukai Li, Ruize Tang, Runjing Gu, Shibo Hu, Sihan Chen, Sufeng Guo, Wanbo Zhang, Xian Zhang, Xiaoyu Chen, Xuanhe Zhou, Xuyao Huang, Yifei Gao, Yifei Shen, Yilin Chen, Yuheng Wu, Yuzhe Zhang, Zelong Zhao, Zhijie Deng
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.05144](https://arxiv.org/abs/2608.05144) / [PDF](https://arxiv.org/pdf/2608.05144.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: 長期・曖昧・途中で目的自体が変わり得るタスクに対し、固定LLMの周辺状態を検証付きで更新し続ける、永続的なエージェント実行基盤「Argus」を提案した。
- **先行研究と比べてどこがすごい？**: 単に長いコンテキストや反復を使うのではなく、「ユーザーの恒久的な意図」と「証拠に応じて変えてよい運用上の目標」を分離する。方針転換を失敗の合理化にしないため、証拠・権限・来歴を伴う検証ゲートを設けた点が新しい。SWE-Bench ProではDirect Copilotの約59%に対し約78%を報告するが、総トークンは1.41倍である。
- **技術や手法の肝はどこ？**: Manager、Planner、Engineer、Reviewerが、永続プロジェクト状態の上で有限な「mission」を実行する。記憶、スキル、手順、検証器、ルーティング、棄却済み経路は、担当ロールのレビューと可能ならタスク固有の検証を通過したものだけを再利用可能な状態へ登録する。モデル重みは更新せず、状態と制御方策を進化させる。
- **どうやって有効だと検証した？**: ソフトウェア修正、GPUカーネル最適化、LLM学習、研究アシスタント、数学データ合成など7種類の評価で検証した。SWE-Bench Proの731タスクの時系列では、成熟後のwaveは初期waveより解決時入力トークンが21%、アクティブ作業時間が15%少ないと報告する。また、Verifierによる34件の回復、厳格なReviewerループによる22件の救済を記録した。
- **議論はある？**: 後半waveの効率改善は、タスク難度・リポジトリ構成・実行遅延も変わる観察研究であり、永続状態そのものの因果効果は未分離である。Reviewerの割当もランダム化されていない。低リスク作業ではEngineer自己レビューを許すため、検証の独立性は一律ではない。PDF本文の抽出テキストにはレイアウト崩れがあり、細部の数値や実装仕様は原PDF・公開実装で要確認。
- **次に読む/試すなら**:
  - Argusの公開リポジトリで、mission境界・状態スキーマ・レビュー記録を確認する。
  - 自分の長期タスクで「意図／運用目標／制約／検証基準」を明示的に分離して運用する。
  - 固定状態・更新状態を比較する再実行実験を設計し、状態蓄積の因果効果を測る。
- **キーワード**: `agentic runtime`, `long-horizon reasoning`, `persistent state`, `verification-gated self-evolution`, `multi-agent review`

## 気になったこと

- 「有効なピボット」と目標逸脱を、実運用でどの程度安定して区別できるか。
- 永続スキル・Wiki・棄却経路が増えた際の検索、陳腐化、誤知識の伝播をどう抑えるか。
- SWE-Benchの後半効率化を、難度を揃えた凍結状態との比較で再現できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
