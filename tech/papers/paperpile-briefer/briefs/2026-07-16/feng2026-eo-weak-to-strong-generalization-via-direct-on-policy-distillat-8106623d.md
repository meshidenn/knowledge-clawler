# Paperpile Brief 2026-07-16 - Weak-to-strong generalization via Direct On-Policy Distillation

## 基本情報

- **タイトル**: Weak-to-strong generalization via Direct On-Policy Distillation
- **著者**: Shiyuan Feng, Huan-Ang Gao, Haohan Chi, Hanlin Wu, Zhilong Zhang, Zheng Jiang, Bingxiang He, Wei-Ying Ma, Ya-Qin Zhang, Hao Zhou
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.05394

## 落合陽一フォーマット

- **ひとことでいうと**: 小さいモデルで安くRLVRを行い、その「RLで変わった方向」だけを強いモデルへ転送する Direct On-Policy Distillation を提案した論文。
- **先行研究と比べてどこがすごい？**: 通常のdistillationは弱いpost-RL teacherの最終policyを真似るため、強いstudentを劣化させうる。本手法は post-RL teacher と pre-RL reference の log-ratio を使い、弱いモデル固有の限界ではなくRLが誘導した policy shift だけを移す。Qwen3-1.7BをAIME 2024で48.3%から58.3%へ、8 A100で約4時間の訓練で改善したと報告している。
- **技術や手法の肝はどこ？**: teacher pair `πT` / `πTref` の差分 `log πT - log πTref` を、KL正則化RLにおける暗黙rewardとして読む点。studentは自分のon-policy状態上でこのdense rewardを評価し、student初期policyへのKLでアンカーしながら更新する。さらにtop-k action space、Rao-Blackwellizedなtoken-level policy gradient、adaptive KL制御を組み合わせている。
- **どうやって有効だと検証した？**: R1-Distill-1.5B→JustRL-1.5B、Nemotron-1.5B→QuestA-Nemotron-1.5B などのteacher pairを使い、Qwen3-1.7B、Qwen3-4B、R1-Distill-7Bに転送。AIME 2024/2025などのreasoning benchmarkで、通常OPD、step-matched direct RL、異なるKL係数やresponse length設定と比較している。
- **議論はある？**: teacher/referenceのpolicy shiftがstudent訪問状態で意味を持つことが前提。最適なKL強度やresponse lengthはteacher-student pair依存で、長いrolloutではlog-ratioがoff-distributionになり信頼性が落ちうる。抽出本文上では、より広いタスク・より大規模モデル・非reasoning領域での一般性は未検証に見える。
- **次に読む/試すなら**: 1. Direct-OPDのobjectiveをverl実装で確認する。2. 自分の小型RL済みcheckpoint pairでlog-ratio rewardを計算する最小実験を作る。3. KL係数とresponse lengthのsweepを小規模benchmarkで再現する。
- **キーワード**: `weak-to-strong generalization`, `Direct-OPD`, `RLVR`, `policy shift`, `implicit reward`, `on-policy distillation`, `KL-regularized RL`

## 気になったこと

- teacher pairのlog-ratioが「良いreward」として使える範囲を、事前に診断する指標はどこまで一般化するのか。
- adaptive KLが平均rewardをゼロ近傍へ寄せる設計は直感的だが、安定性の理論保証は本文からは限定的に見える。
- token-levelの即時shiftだけで将来returnを近似する設計が、長い推論連鎖や探索が必要な問題でどこまで効くか確認したい。
- 通常OPDが劣化する条件と、Direct-OPDが失敗する条件を同じteacher-student pairで比較したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [feng2026-eo-weak-to-strong-generalization-via-direct-on-policy-distillat-8106623d.md](../../chat/2026-07-16/feng2026-eo-weak-to-strong-generalization-via-direct-on-policy-distillat-8106623d.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
