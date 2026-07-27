# Chat Prompt 2026-07-28

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Multi-turn on-Policy Distillation with prefix replay

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-28 - Multi-turn on-Policy Distillation with prefix replay

## 基本情報

- **タイトル**: Multi-turn on-Policy Distillation with prefix replay
- **著者**: Baohao Liao, Hanze Dong, Christof Monz, Xinxing Xu, Li Dong, Furu Wei
- **年 / venue**: 2026 / arXiv [cs.LG], arXiv:2607.04763v2
- **リンク**: https://arxiv.org/pdf/2607.04763

## 落合陽一フォーマット

- **ひとことでいうと**: multi-turn agent task における On-Policy Distillation を、毎回環境を実行せず、事前収集した teacher trajectory の prefix replay で近似する ReOPD を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来の OPD は student rollout ごとに環境実行と teacher query が必要で高コストだった。ReOPD は student が選択ステップで行動し、prefix と observation は teacher trajectory から再利用するため、student training 中の tool call を 0 にしつつ、OPD 並みまたはそれ以上の accuracy を維持する。
- **技術や手法の肝はどこ？**: multi-turn OPD の問題を「prefix trap」として定式化し、student occupancy への適合と teacher reliability の二面の distribution shift に分解する点。実装上は、早い step ほど teacher-student shift が小さいとみなし、step-decaying sampling schedule `ω(t;κ)=κ^t` で early prefix を多めにサンプリングする。
- **どうやって有効だと検証した？**: Qwen3 系モデルを teacher/student に使い、Python tool 付き数学推論と検索 QA 環境で評価。数学では AIME24/25, AMC23, Minerva, OlympiadBench, MATH500、検索では NQ, TriviaQA, PopQA, HotpotQA, 2Wiki, MuSiQue, Bamboogle を使用。数学では ReOPD が OPD の平均 accuracy を複数 teacher scale で上回り、検索ではほぼ同等。multi-environment distillation でも OPD と同等水準を示した。
- **議論はある？**: teacher trajectory pool の品質と coverage に強く依存する。teacher が student-induced history でどこまで信頼できるかという仮定が中心で、κ の選び方は経験的要素が残る。検証は主に Qwen3 系、数学 Python tool、検索 QA であり、browser 操作・API 操作・長期 planning などへの一般化は本文からは限定的。
- **次に読む/試すなら**: ReOPD の公開コード `baohaoliao/ReOPD` を確認する。既存 agent training pipeline の rollout log を prefix pool として再利用できるか確認する。κ を `1.0, 0.8, 0.6, 0.4` などで ablation して、自分の環境で early-prefix bias が効くか見る。
- **キーワード**: `on-policy distillation`, `prefix replay`, `agentic LLM`, `knowledge distillation`, `tool use`, `distribution shift`

## 気になったこと

- teacher trajectory が失敗軌跡を含む場合、prefix replay の sampling は reward や correctness で filter すべきか。
- teacher reliability を KL 以外で測るなら、実行結果の正否・tool observation の安定性・自己整合性を使えるか。
- search では OPD と ReOPD がほぼ同等だった理由を、teacher-student gap だけで説明してよいか。
- browser/API 系 agent でも「early step は低 shift」という仮定が成り立つか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
