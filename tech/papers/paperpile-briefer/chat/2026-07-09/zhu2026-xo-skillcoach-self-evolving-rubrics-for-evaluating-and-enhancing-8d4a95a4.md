# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {SkillCoach}: Self-evolving rubrics for evaluating and enhancing agentic skill-use

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - SkillCoach: Self-evolving rubrics for evaluating and enhancing agentic skill-use

## 基本情報

- **タイトル**: SkillCoach: Self-evolving rubrics for evaluating and enhancing agentic skill-use
- **著者**: Jiayin Zhu, Kelong Mao, Yudong Guo, Dengbo He, Sulong Xu, Simiu Gu, Yutao Yue
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.01874 / PDF: https://arxiv.org/pdf/2607.01874.pdf / arXiv:2607.01874

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agent が「スキル」を正しく選び、手順通り使い、組み合わせ、最後に検証できているかを、最終成功率とは別に評価・学習に使う自己進化型 rubric フレームワークを提案した論文。

- **先行研究と比べてどこがすごい？**: 従来の skill benchmark や verifier 成功率だけでは、たまたま成功したがスキル利用は壊れている trajectory を見逃す。SkillCoach は skill selection / following / composition / reflection の4軸でプロセスを評価し、distractor skill が混じる現実的な skill library で失敗を診断する。自己進化後の rubric は human-gold に対する coverage、usability、filtering consistency を改善し、hallucination rate も下げたと報告している。

- **技術や手法の肝はどこ？**: gold skill、distractor skill、task instruction、oracle solution、verifier 情報、実 rollouts から初期 rubric を作り、実 trajectory の観測証拠に基づいて局所 patch を提案する。候補 rubric は held-out validation rollouts 上で hard gate と soft objective を通過した場合だけ採択される。評価軸は、正しい skill を選んだか、key step を証拠付きで実行したか、複数 skill の順序・中間成果物の受け渡しが正しいか、提出前チェックをしたか、の4つ。

- **どうやって有効だと検証した？**: SkillsBench / SkillLearnBench 由来の skill-dependent tasks を、18 training task families と10 test task familiesに分けて評価。rubric 品質では R0 から Rbest への進化で gold-keypoint coverage が 71.56 から 83.70、usability が 81.53 から 94.33、filtering consistency が 82.00 から 96.00 に改善。agent 評価では Gold Skills だけより Gold + Distractors で selection が崩れることを示し、最終成功率だけでは見えない失敗を可視化した。さらに rubric-filtered SFT は Qwen3.5-4B を 8.0% から 24.0%、Qwen3.5-9B を 14.0% から 32.0% に改善し、outcome-only SFT より強かった。

- **議論はある？**: 実験対象は選別済みの skill-dependent tasks で、実運用の巨大かつ継続的に増える skill repository より小さい。学習は offline SFT に限られ、on-policy RL や長期運用 feedback は未検証。rubric 品質評価は human-gold と judge-assisted audit に依存しており、評価者モデルのバイアスや rubric 自体の汎化には注意が必要。

- **次に読む/試すなら**: 
  1. 自分の agent skill repository に対して selection / following / composition / reflection の4軸ログを取れるか確認する。
  2. verifier-passing trajectory をそのまま SFT に使わず、process rubric でフィルタする最小実験を組む。
  3. distractor skill を意図的に混ぜ、skill selection F1 と abstention を測る。

- **キーワード**: `LLM agents`, `agentic skill-use`, `rubric-based evaluation`, `process supervision`, `skill selection`, `trajectory evaluation`, `SFT`, `distractor skills`

## 気になったこと

- rubric を自己進化させる arbitration model と judge model の品質にどれだけ依存するのか。
- enterprise skill library で skill が頻繁に更新される場合、rubric もどの頻度で再進化させるべきか。
- verifier が弱いタスク、または正解が一意でないタスクでも process score が有効に働くか。
- RL reward として使った場合、rubric hacking や過剰な手順遵守が起きないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
