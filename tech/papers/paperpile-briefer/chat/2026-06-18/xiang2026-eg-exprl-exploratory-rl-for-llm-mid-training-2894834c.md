# Chat Prompt 2026-06-18

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {ExpRL}: Exploratory {RL} for {LLM} Mid-Training

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-18 - ExpRL: Exploratory RL for LLM Mid-Training

## 基本情報

- **タイトル**: ExpRL: Exploratory RL for LLM Mid-Training
- **著者**: Violet Xiang, Amrith Setlur, Chase Blagden, Nick Haber, Aviral Kumar
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2606.17024 / PDF: https://arxiv.org/pdf/2606.17024.pdf / Code: https://github.com/violetxi/ExpRL

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの推論能力をSparse reward RLで伸ばす前段階として、参照解を「模倣対象」ではなく「報酬足場」として使い、オンポリシー生成の部分的進捗に dense reward を与える mid-training 手法 ExpRL を提案した論文。
- **先行研究と比べてどこがすごい？**: SFTやself-distillationのように参照解をそのまま学習ターゲットにせず、モデル自身が生成した推論トレースだけをRLで更新する点が差分。Qwen3-4B-Instructでの数学推論実験では、Stage-IIのSparse GRPO後にAIME2026でExpRL-Processが63.41%となり、GRPO baselineの58.75%を上回るなど、RL前の初期化として強い。
- **技術や手法の肝はどこ？**: 参照解をpolicyには見せず、LLM judgeだけに渡して、生成トレースが参照解にどれだけ近い有用な進捗を含むかを1〜5段階で採点する。ExpRL-Outcomeは全文トレースにdense終端報酬を与え、ExpRL-Processは`###`区切りのprefixごとに採点してsegment-level advantageを作る。つまり「正解したか」ではなく「正解に向かう探索分布を広げたか」をRLで直接押す。
- **どうやって有効だと検証した？**: InT+POPE由来の難問・参照解ペアでStage-I mid-trainingを行い、その後、参照解なしのSparse reward GRPOでStage-IIを実施。評価はHMMT Nov 2025、IMO-AnswerBench、AIME2025、AIME2026で、128サンプルからpass@1/pass@kを計測。比較対象はSFT、Sparse GRPO、Self-Distillation。さらに8B policy + 4B judgeのmixed-domain実験、judge calibration、推論行動分析も行っている。
- **議論はある？**: ExpRLは良い参照解があることに依存するため、参照解の入手が難しい領域では使いにくい。codingでは実行環境によるSparse rewardが強く、参照解ベースのjudge報酬は数学・科学ほど効きにくい。Process rewardでは長さ制御やdelimiter使用の崩れも観測されており、報酬較正・長さ正規化・judge設計は未解決。
- **次に読む/試すなら**: ExpRLのjudge promptを自前タスクに移植して、SFTではなくon-policy rollout scoringで小規模再現する。 / 参照解あり数学データでOutcome rewardとProcess rewardの差を見る。 / codingやagent taskでは環境報酬とExpRL型dense rewardをどう混ぜるか検証する。
- **キーワード**: `LLM reinforcement learning`, `mid-training`, `dense reward`, `reference-guided reward`, `GRPO`, `process reward`, `pass@k`, `reasoning coverage`

## 気になったこと

- 参照解と異なるが正しい解法をjudgeが過小評価する可能性をどう抑えるか。
- Process rewardで`###` delimiterに依存する設計は、別モデルや別ドメインでも安定するのか。
- ExpRLの効果は「探索分布の拡大」なのか「judge好みの推論様式への誘導」なのかを分けて測る追加実験が欲しい。
- 自然言語feedbackをscalar rewardだけで捨てているので、critic trainingやreflection dataとして使う余地がある。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
