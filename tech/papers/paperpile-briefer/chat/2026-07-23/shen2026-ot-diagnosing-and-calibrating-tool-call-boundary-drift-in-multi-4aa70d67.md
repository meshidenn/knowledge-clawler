# Chat Prompt 2026-07-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Diagnosing and calibrating tool-call boundary drift in multi-teacher on-policy distillation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-23 - Diagnosing and calibrating tool-call boundary drift in multi-teacher on-policy distillation

## 基本情報

- **タイトル**: Diagnosing and calibrating tool-call boundary drift in multi-teacher on-policy distillation
- **著者**: Jiabin Shen, Guang Chen, Chengjun Mao
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.07050 / arXiv:2607.07050v2

## 落合陽一フォーマット

- **ひとことでいうと**: multi-teacher on-policy distillationで、tool-callすべきか直接回答すべきかの境界がずれる問題を診断し、Soft Clampで過剰なtool-callを抑える論文。
- **先行研究と比べてどこがすごい？**: 集約lossやtoken exposureだけでは見えない「tool-call boundary drift」を、局所的なtoken-level divergenceと生成モード切替の観点で説明した点。vanilla GKDはcall recallを上げる一方でover-callingを増やすが、Soft ClampはAPIGen-MT-derived decision setでover-callingを14.2±2.1%から9.0±0.2%へ下げ、decision accuracyは同程度に保った。
- **技術や手法の肝はどこ？**: `tool_call`開始token、function name、構造markerのような「behavior leverage」が高い位置のJensen-Shannon divergenceが、全体loss以上に生成モードを支配するという見立て。Soft Clampはbatch平均に基づくdetached thresholdを作り、普通のtokenはそのまま、極端に大きいtoken divergenceだけをforward上は圧縮しつつgradientはゼロにしない。
- **どうやって有効だと検証した？**: APIGen-MT由来のdecision set、BFCL multi-turn diagnostic、When2Callで評価。seed 42/44/60のmulti-seed比較で、Vanilla GKD、Hard Clip、Global Reweight、Soft Clamp、inference-time entry biasを比較した。さらにtraining log上のtoken exposure、per-token JSD、response側の`P(tool)`、top-1 tool rate、loop/repeated callなどを診断した。
- **議論はある？**: Soft Clampが常に全指標で最良ではなく、Global Reweightも強い比較対象。主張は完全な因果分解ではなく、behavior leverage imbalanceという診断的解釈に留まる。teacher logitはtop-32近似でJSDを計算しており、BFCL scoreもlocal BFCL-v4-styleで公式leaderboardではない。実験は主にQwen3.5-9B/4B、APIGen-MT派生データ、特定のtool-call serializationに依存する。
- **次に読む/試すなら**: Soft Clampを自前のtool-use distillation lossに入れて、response例での`P(<tool_call>)`をtraining中にlogする。Global Reweightとの比較を小規模seedで回す。最初のentry tokenだけでなく、function名やXML/JSON構造token別のdivergence集中を可視化する。
- **キーワード**: `multi-teacher on-policy distillation`, `tool-call boundary drift`, `Soft Clamp`, `Jensen-Shannon divergence`, `agentic LLM`, `over-calling`

## 気になったこと

- Soft Clampのclamp factor `k=3` が、別モデル・別tool schema・JSON function callingでも安定するか。
- over-calling抑制とcall recall維持のPareto frontierを、validation tuningなしでどこまで制御できるか。
- 「behavior leverage」をtoken位置ごとに定量化する一般的な指標を作れるか。
- tool-call serializationがXML-style前提なので、OpenAI/Anthropic風のstructured function calling APIでは同じ症状が出るか。
- inference-time entry biasでかなり再現できる部分と、training-time calibrationでないと改善しない部分の切り分け。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
