# Paperpile Brief 2026-07-09 - Self-distillation enables continual learning

## 基本情報

- **タイトル**: Self-distillation enables continual learning
- **著者**: Idan Shenfeld, Mehul Damani, Jonas Hübotter, Pulkit Agrawal
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: Foundation modelのcontinual learningにおいて、デモンストレーションから自己蒸留でon-policyな学習信号を作り、忘却を抑えながら新しいスキルや知識を獲得する手法 SDFT を提案した論文。
- **先行研究と比べてどこがすごい？**: 通常のSFTはexpert demonstrationを使える一方でoff-policyになり、既存能力の忘却を起こしやすい。SDFTは、デモ条件付きの自モデルをteacherとして使うことで、明示的なrewardなしにon-policy learningに近い更新を実現し、SFTより新タスク精度と忘却抑制の両方で優れると主張している。
- **技術や手法の肝はどこ？**: demonstrationを直接SFTするのではなく、in-context learningでデモを条件付けたモデル自身をteacherにし、その出力を蒸留対象にする点。つまり「デモから正解列を真似る」のではなく、「デモを見た自分がどう振る舞うか」を学習信号にして、分布ずれと過剰な能力上書きを抑える。
- **どうやって有効だと検証した？**: abstractベースでは、skill learning、knowledge acquisition、sequential learningの実験でSFTと比較し、新タスク性能の向上とcatastrophic forgettingの低減を示したとされる。細かいタスク名、モデル規模、評価指標、数値差、比較手法はメタデータからは不明。
- **議論はある？**: PDF本文がないため詳細な限界は不明。気になる点は、teacherが同じモデルである以上、in-contextで出せない能力は蒸留できない可能性、デモ品質への依存、長い系列での知識蓄積時の安定性、SFT以外のcontinual learning手法との比較範囲。
- **次に読む/試すなら**: SDFTの具体的なloss設計とデータ生成手順を確認する。SFTとの差が出たタスク設定と失敗例を読む。小さなLLMで「既存タスク + 新スキル」の逐次学習をSFT/SDFT比較で再現する。
- **キーワード**: `continual learning`, `self-distillation`, `on-policy learning`, `supervised fine-tuning`, `catastrophic forgetting`, `in-context learning`

## 気になったこと

- SDFTで生成するteacher出力は、どの程度サンプリング温度やプロンプト設計に依存するのか。
- SFTより忘却が少ない理由は、on-policy性そのものなのか、teacher出力が元モデル分布に近いことによる正則化なのか。
- RLHF/RLAIF、DPO、behavior cloning、learning without forgettingとの関係を整理したい。
- sequential learningで「performance regressionなし」とあるが、何タスク・何ステップまで確認しているのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [shenfeld2026-uq-self-distillation-enables-continual-learning-ca92c113.md](../../chat/2026-07-09/shenfeld2026-uq-self-distillation-enables-continual-learning-ca92c113.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
