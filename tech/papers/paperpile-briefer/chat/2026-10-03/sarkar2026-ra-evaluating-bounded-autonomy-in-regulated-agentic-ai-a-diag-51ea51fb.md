# Chat Prompt 2026-10-03

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Evaluating bounded autonomy in regulated agentic {AI}: A diagnostic harness with constitutional rewards, escalation labels, and runtime governance

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-10-03 - Evaluating bounded autonomy in regulated agentic AI: A diagnostic harness with constitutional rewards, escalation labels, and runtime governance

## 基本情報

- **タイトル**: Evaluating bounded autonomy in regulated agentic AI: A diagnostic harness with constitutional rewards, escalation labels, and runtime governance
- **著者**: Dipankar Sarkar
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2609.37501

## 落合陽一フォーマット

- **ひとことでいうと**: 規制領域のAIエージェントについて、「答えるか、人間にエスカレーションするか」を学習・評価可能な信号として扱う診断基盤REGLLMを提案した。
- **先行研究と比べてどこがすごい？**: 回答品質だけでなく、引用妥当性、根拠性、スキーマ準拠、エスカレーション正確性、憲法的整合性、安全でない行動率を分離して評価する。さらに、同じドメイン憲法を報酬設計と実行時ガードレールの双方に利用する。
- **技術や手法の肝はどこ？**: ReAct型エージェントに、`ANSWER`と`ESCALATE`を含む行動系を持たせ、タスクごとの`should_escalate`ラベルとの一致を報酬化する。決定論的な実行時監督層は、根拠のない回答を遮断し、必要に応じてエスカレーションし、介入を監査ログに記録する。
- **どうやって有効だと検証した？**: UK FCA Handbookを用いた小規模実験を実施。オフライン評価（n=12）では、ガバナンス有効化によりエスカレーション再現率が0から0.67、安全でない行動率が0.33から0.08に改善した。一方、Qwen2.5-3BのGPUパイロット（n=8）では、同一条件のはずの2実行で性能が大きく変動し、DPOアダプターの効果方向も反転した。
- **議論はある？**: 実験は単一ドメイン・単一モデル・単一seed・極小データで、実運用性能を示さない。エスカレーションラベルは専門家ではなく著者作成のテンプレート由来であり、LLM judgeと語彙重複ベースのgrounding評価にも限界がある。GPU実験では実行時ガバナンスの介入がゼロで、能力境界の検出は未解決である。
- **次に読む/試すなら**:
  1. `should_escalate`ラベルを専門家アノテーションで作り、複数seed・大規模評価セットで再実験する。
  2. DPO前に、エスカレーション精度・再現率・安全でない行動率を固定ベンチマーク化する。
  3. FCA以外の規制領域で、憲法・根拠オラクル・エスカレーション基準を差し替えて再現する。
- **キーワード**: `bounded autonomy`, `regulated agentic AI`, `escalation labels`, `runtime governance`, `constitutional rewards`

## 気になったこと

- 実行時監督層がGPUパイロットで一度も介入しなかったのは、ガードレールの設計不足なのか、評価タスクが単純すぎるのか。
- `should_escalate`の専門家間不一致を、報酬や評価指標にどう反映するべきか。
- 語彙重複によるgrounding評価が、実際の規制解釈の正確性をどの程度代理できるのか。
- DPO効果の変動がGPU差・依存パッケージ差・非決定的カーネルのどれに由来するのかは、PDF本文からは確定できない。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
