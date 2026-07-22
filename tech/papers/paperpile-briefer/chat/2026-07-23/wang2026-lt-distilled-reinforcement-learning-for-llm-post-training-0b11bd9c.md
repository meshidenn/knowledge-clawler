# Chat Prompt 2026-07-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Distilled Reinforcement Learning for {LLM} post-training

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-23 - Distilled Reinforcement Learning for LLM post-training

## 基本情報

- **タイトル**: Distilled Reinforcement Learning for LLM post-training
- **著者**: Chen Wang, Zhaochun Li, Jionghao Bai, Yining Zhang, Hexuan Deng, Ge Lan, Yue Wang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.17247v1 / arXiv:2607.17247v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのpost-trainingで、RLの粗い報酬信号とOPDの無条件なteacher imitationの弱点を避けるため、teacherのtoken-level preferenceをRL objective内に直接入れるDistilled RLを提案した論文。
- **先行研究と比べてどこがすごい？**: 通常のRLはsequence-level rewardなのでcredit assignmentが粗く、OPDはKLでteacher logitsを無条件に模倣するためteacher-studentの分布差が大きいcross-family distillationで壊れやすい。Distilled RLはteacherを独立した模倣対象ではなく、成功軌道上のRL勾配を細かく再重み付けするガイドとして使う点が新しい。実験ではDSQW-1.5B、Qwen3-4B、Qwen3-1.7BでOPD/RL/OPD+RLを上回り、特にcross-family設定で差が大きい。
- **技術や手法の肝はどこ？**: コアは3つ。1つ目はteacher確率と旧student確率の比 `π_teacher / π_old` を使うreverse importance sampling。2つ目はnegative sample resetで、advantageが負の応答ではteacher重みを1に戻し、teacher好みのtokenを逆に罰してしまう事故を避ける。3つ目はsequence-level geometric normalizationで、token-level ratioの幾何平均を1に正規化し、系列全体の学習信号を過度に増減させずtoken間の相対的なteacher preferenceだけを残す。
- **どうやって有効だと検証した？**: EasyR1とVeRL上で実装し、DAPO-17Kで学習。teacherは主にQwen3-8B-GRPO、studentはDSQW-1.5B、Qwen3-4B、Qwen3-1.7B。AIME24/25/26、CMIMC25、HMMT25、AMC23、GSM8K、MATH500、Minerva Math、OlympiadなどでPass@1を評価し、MMLU-ProとSuperGPQA、Pass@16も確認している。DSQW-1.5Bでは平均Pass@1がbase 31.70からDistilled RL 40.00、Qwen3-4Bでは46.33から58.96へ改善。ablationではnegative sample resetを外すと大きく劣化し、geometric normalizationも一貫して効く。
- **議論はある？**: teacherをstudent生成軌道の評価にだけ使い、teacher自身の完全回答を常にrolloutしないため、teacherがその問題を本当に解けるかは直接確認していない。成功したstudent軌道ではteacherも十分有能である、という仮定が残る。studentが学習でteacherに追いつく、あるいは局所的にteacherを上回る場合、teacher重みが逆に悪い誘導になる可能性がある。細かい数値はPDF抽出テキスト由来なので表のレイアウト崩れに注意。
- **次に読む/試すなら**: Distilled-RLのGitHub実装でloss計算部分を確認する。GRPO実装にteacher-to-student ratio、negative reset、geometric normalizationだけを足した最小実験を作る。teacher competence gatingやteacher rollout併用で弱点を潰せるか検討する。
- **キーワード**: `Distilled RL`, `LLM post-training`, `reinforcement learning`, `on-policy distillation`, `knowledge distillation`, `GRPO`, `importance sampling`, `cross-family distillation`

## 気になったこと

- teacherが固定の場合、studentがteacherに近づいた後もteacher preferenceを使い続けるべきか、重みをannealする条件が必要そう。
- negative sample resetはかなり効いているが、binary correctness reward以外のrewardやprocess rewardでも同じ挙動になるか確認したい。
- OPD+RLが伸びない原因を、KL local optimumだけでなくentropy collapseやresponse lengthの変化として分解できるか見たい。
- teacher確率をtokenごとに取る計算コストが大きいはずなので、実運用ではoffline cacheや部分token評価でどこまで近似できるかが重要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
