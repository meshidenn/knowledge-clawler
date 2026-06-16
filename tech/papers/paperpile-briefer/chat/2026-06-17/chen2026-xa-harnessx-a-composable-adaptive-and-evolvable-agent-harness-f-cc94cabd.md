# Chat Prompt 2026-06-17

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {HarnessX}: A Composable, Adaptive, and Evolvable Agent Harness Foundry

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-17 - HarnessX: A Composable, Adaptive, and Evolvable Agent Harness Foundry

## 基本情報

- **タイトル**: HarnessX: A Composable, Adaptive, and Evolvable Agent Harness Foundry
- **著者**: Tingyang Chen, Shuo Lu, Kang Zhao, Weicheng Meng, Hanlin Teng, Tianhao Li, Chao Li, Xule Liu, Jian Liang, Zhizhong Zhang, Yuan Xie, Heng Qu, Kun Shao, Jian Luan
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2606.14249 / arXiv:2606.14249

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントの性能を、モデル本体ではなくプロンプト、ツール、メモリ、制御フローからなる「harness」を合成・適応・進化させることで改善するフレームワーク HarnessX を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のエージェント基盤は、プロンプト最適化、ワークフロー探索、手作業のツール設計に分かれがちだった。本論文は harness を型付きの第一級オブジェクトとして扱い、9次元の processor taxonomy と substitution algebra で部品交換可能にし、さらに実行トレースから自動進化させる点が差分。5ベンチマークで平均 +14.5%、最大 +44.0% の改善を報告している。
- **技術や手法の肝はどこ？**: コアは3つ。第一に、context、tools、skills、control、memory などを processor として lifecycle hook に差し込む composable harness 設計。第二に、AEGIS という trace-driven な進化エンジンで、Digester、Planner、Evolver、Critic が実行ログを圧縮し、変更計画を立て、候補を生成し、ゲートする。第三に、harness 進化で得た reward 付き trajectory を replay buffer に入れ、cross-harness GRPO によりモデル学習信号にも使う co-evolution ループ。
- **どうやって有効だと検証した？**: ALFWorld、GAIA、WebShop、τ3-Bench、SWE-bench Verified の5ベンチマークで評価。タスクエージェントは Claude Sonnet 4.6、GPT-5.4、Qwen3.5-9B、メタエージェントは主に Claude Opus 4.6。静的 harness と比較し、15構成中14構成で改善。ALFWorld では Qwen3.5-9B が 53.0% から 97.0% に改善、SWE-bench Verified でも各モデルで +10.9% から +18.2% の改善を報告。
- **議論はある？**: 評価は evolution に使った同じタスクセット上での改善であり、未見タスクへの汎化は本文中でも未評価とされている。コードベースは将来公開予定で、現時点で再現性は限定的。GAIA のような異質なタスク集合では単一 harness が停滞し、variant isolation が必要になる。SWE-bench ではピーク後に劣化もあり、構造的なコード編集や同種編集の蓄積が regression を起こし得る。
- **次に読む/試すなら**: Harness を processor/hook 単位で分解する設計を、自分のエージェント実装に写像してみる。AEGIS の Digester→Planner→Evolver→Critic を最小構成で再現し、既存タスクログから prompt/tool/control の変更提案を出せるか試す。未見タスクでの汎化評価、variant isolation、編集ゲート設計を追加で確認する。
- **キーワード**: `agent harness`, `self-evolving agents`, `AEGIS`, `GRPO`, `tool use`, `agent workflows`, `runtime scaffolding`

## 気になったこと

- 改善が同一タスクセット上の進化・評価に基づくため、benchmark overfitting と未見タスク汎化をどう切り分けるか。
- AEGIS の Critic/gating がどの程度 deterministic で、失敗時にどの粒度で rollback できるのか。
- 「コードは将来公開」とあるため、現時点では substitution algebra、processor interface、trace schema の実装詳細が追いにくい。
- cross-harness GRPO は魅力的だが、harness ごとに prompt/tool schema が変わるときの log-prob 再計算と保存コストが実運用でどれくらい重いか。
- GAIA の停滞や SWE-bench のピーク後劣化を見ると、単純な進化よりも variant 管理、regression test、編集タイプごとの blast radius 推定が重要そう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
