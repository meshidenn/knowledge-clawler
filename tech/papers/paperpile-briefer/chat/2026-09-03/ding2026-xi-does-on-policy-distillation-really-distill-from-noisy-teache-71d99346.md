# Chat Prompt 2026-09-03

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Does on-policy distillation really distill? From noisy teacher to self-improvement

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-03 - Does on-policy distillation really distill? From noisy teacher to self-improvement

## 基本情報

- **タイトル**: Does on-policy distillation really distill? From noisy teacher to self-improvement
- **著者**: Yi Ding, Ruqi Zhang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2608.31046v1](https://arxiv.org/abs/2608.31046v1)

## 落合陽一フォーマット

- **ひとことでいうと**: On-policy distillation（OPD）の改善は教師知識の蒸留というより、学生モデルが低確率トークンを抑制する効果で説明できると示し、教師・正解報酬・ヒントなしでそれを行うOPS A（On-Policy Self-Adaptation）を提案した。
- **先行研究と比べてどこがすごい？**: OPDでは教師が学生生成のoff-policy軌跡を採点するため信号がノイジーであり、ノイズのみ／除去後／通常の教師信号でもほぼ同等に学習することを実証した。そのうえで、外部教師のlogitアクセスや共有語彙を不要にし、Qwen3-1.7BでOPDをAIME24のAvg@32で16.77ポイント上回ったと報告する。
- **技術や手法の肝はどこ？**: 各生成位置で学生自身のlog-probabilityが低い下位20%のトークンを選び、エントロピーに応じた負のadvantageを与える。低エントロピー位置では分布を鋭くしてtail tokenを抑えつつ、高エントロピーの分岐ではhead token間へ確率を再配分し、多様性を保つ設計である。
- **どうやって有効だと検証した？**: Qwen3-1.7Bを学生、Qwen3-4B／30B-A3B／235B-A22B-Instructを教師として、DAPO-17k由来の問題とAIME24、AIME25、HMMT25で評価した。教師信号の符号と検証可能な最終解答の正誤の不一致率、ノイズ軌跡だけを使う統制実験、固定負advantageとの比較、エントロピー・学習対象割合のablation、Pass@kと応答多様性を検証している。AIME24では基盤Qwen3-1.7B比でAvg@32を35.41ポイント改善、相対263%向上と報告する。
- **議論はある？**: 「OPDは蒸留していない」という結論は、主に小規模モデル（最大9B）と数学推論ベンチマークでの実験に基づく。大規模モデルやMoEへのスケール、既に分布が鋭い強くpost-training済みのモデルでの有効性、探索フロンティア自体を広げられるかは未検証・限定的である。また、最終解答トークンの正誤で教師信号のノイズを定義しており、中間推論の品質は直接評価していない。
- **次に読む/試すなら**:
  - Qwen系の小規模モデルで、低logp下位20%への固定負advantageとエントロピー適応版を再現比較する。
  - 教師規模と学生との差を変え、教師信号の符号ノイズ率と性能の関係を再検証する。
  - コード生成・科学QAなど、検証可能な数学以外のタスクでPass@kと多様性への影響を測る。
- **キーワード**: `on-policy distillation`, `self-improvement`, `token-level RL`, `negative advantage`, `entropy-adaptive learning`, `LLM reasoning`

## 気になったこと

- 正答・誤答との符号不一致を教師信号の「ノイズ」とみなす基準は、途中の推論トークンには適用しにくい。最終解答以外でも同じ結論が成立するか確認したい。
- OPSAは既存分布のtailを抑える操作なので、知識不足による誤答や真に低確率な正解発見をどう扱うかが重要である。
- Avg@32の改善に対し、thinking-modeでのPass@k改善は相対的に控えめだという記述がある。精度向上と探索能力向上を分離して評価したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
