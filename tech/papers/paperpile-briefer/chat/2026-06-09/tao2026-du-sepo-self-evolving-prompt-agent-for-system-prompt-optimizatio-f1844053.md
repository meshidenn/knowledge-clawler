# Chat Prompt 2026-06-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {SePO}: Self-evolving prompt agent for system prompt optimization

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-09 - SePO: Self-Evolving Prompt Agent for System Prompt Optimization

## 基本情報

- **タイトル**: SePO: Self-Evolving Prompt Agent for System Prompt Optimization
- **著者**: Wangcheng Tao, Han Wu, Weng-Fai Wong
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2606.04465 / arXiv:2606.04465v1

## 落合陽一フォーマット

- **ひとことでいうと**: タスク用システムプロンプトだけでなく、それを改善する「プロンプトエージェント自身のシステムプロンプト」も進化させる、自己参照型プロンプト最適化手法 SePO を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の Manual-CoT、TextGrad、MetaSPO などは、最適化を行う側のプロンプトエージェントが手書きで固定されている。SePO はこの固定点を外し、プロンプトエージェント自体を最適化対象に入れる。5タスク平均で Manual-CoT の 71.89 から SePO-Generalist の 76.38 へ改善し、平均 +4.49 ポイントと報告している。
- **技術や手法の肝はどこ？**: 自己参照的な2段階パイプライン。第1段階の pre-training では、複数タスク上でプロンプトエージェント自身のシステムプロンプトを進化させる。第2段階の fine-tuning では、その進化済みプロンプトエージェントを固定して、対象タスクのエージェントプロンプトを改善する。探索はアーカイブ付きの進化探索で、過去の候補プロンプトを stepping stone として残し、親より良い子を採用する。
- **どうやって有効だと検証した？**: AIME’25、ARC-AGI-1、GPQA、MBPP、Sudoku の5ベンチマークで評価。タスクエージェントに DeepSeek-V3.2、プロンプトエージェントに Gemini 3.1 Pro Preview を使用し、Manual-CoT、TextGrad、MetaSPO と比較した。SePO-Generalist は全タスクで最高精度を示し、自己改善なし・open-ended evolution なしのアブレーションも下回った。別モデルペアでも平均 +2.13 ポイントの改善を報告している。
- **議論はある？**: 検証は5タスク・特定モデルペア中心で、プロンプト進化の効果がどこまで一般化するかは追加検証が必要。評価は train split 上のプロンプト探索に依存するため、タスク選択や評価バッチ設計の影響が大きい。PDF本文ではコスト比較もあるが、実運用でのAPI価格・モデル更新・長コンテキスト利用可能性に左右される。手法は重みやツール、ワークフローを変えないため、失敗原因がプロンプト外にある場合の限界も残る。
- **次に読む/試すなら**: 1. GitHub実装を確認してプロンプト進化のテンプレートと評価ループを見る。 2. 自分の小規模タスクで「自己改善あり/なし」のアブレーションを再現する。 3. PromptBreeder、TextGrad、MetaSPO との設計差分を整理する。
- **キーワード**: `system prompt optimization`, `self-evolving agent`, `prompt agent`, `evolutionary search`, `meta prompt optimization`, `SePO`

## 気になったこと

- プロンプトエージェント自身を進化させるとき、評価データへの過適合をどう検出するのが実用上よいか。
- アーカイブ採用基準が「親より良い」だけだと、局所的な評価バッチに強いプロンプトが残りやすくならないか。
- 「プロンプト最適化スキル」が本当に学習されているのか、単に評価タスク群に合う汎用ヒューリスティックを獲得しているのかを切り分けたい。
- メタデータ上 DOI は空で、正式な DOI はメタデータからは不明。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
