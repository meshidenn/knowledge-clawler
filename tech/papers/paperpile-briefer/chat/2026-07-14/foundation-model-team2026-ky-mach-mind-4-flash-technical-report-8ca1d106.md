# Chat Prompt 2026-07-14

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Mach-Mind-4-Flash Technical Report

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-14 - Mach-Mind-4-Flash Technical Report

## 基本情報

- **タイトル**: Mach-Mind-4-Flash Technical Report
- **著者**: Foundation Model Team
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.09375v1 / arXiv:2607.09375v1

## 落合陽一フォーマット

- **ひとことでいうと**: 35B MoE、推論時3B activeの小型agentic modelを、事前学習スケールではなくpost-training、multi-teacher distillation、token効率化で100B級以上に近づけた技術報告。
- **先行研究と比べてどこがすごい？**: 混合reward RLで起きる能力のsee-saw劣化を、領域別expertを作ってからMOPDで統合する設計で抑えている。AIME'26 92.70、IFBench 82.82、Behavioral-SafetyBench 80.74、BFCL-v4 75.80、BrowseComp-zh 72.31、ClawBench 84.20など、activated sizeが10〜30倍大きいモデルと同等以上を主張している。
- **技術や手法の肝はどこ？**: まずRL/OPDを同一training frameworkに統合し、dynamic multi-teacher routingで複数teacherを追加しやすくする。次にReasoning、General、Agent系の専門RL expertを並列に作り、各sampleを対応teacherにrouteしてtoken-level reverse-KLでstudentをon-policy distillationするMOPDで統合する。最後にHMPOで正解rolloutのmedian lengthから適応的budgetを作り、短いが誤った回答へのreward hackingを避けながらreasoning chainを圧縮する。
- **どうやって有効だと検証した？**: PDF本文では、reasoning、instruction following、writing、safety、tool-use、code agent、DeepSearch、OpenClawの複数benchmarkで比較している。MOPDのablationではSFT base、expert teacher、MOPD finalの推移を示し、General系ではIFBenchが72.79から82.92へ改善、Agent系ではClawBenchが80.70から83.20へ改善している。一方、SWE-bench Verifiedはexpert 73.80に対してMOPD final 71.10で、長期agent行動の保持に課題が残る。
- **議論はある？**: 限界として、MOPDはrepository-level software engineeringのような極端なlong-horizon taskで専門挙動を少し平滑化する。HMPOは主にsingle-turn reasoning向けで、multi-turn agent trajectoryへの拡張は未解決。DeepSearchやlong-context comprehensionもcompact modelの弱い軸として残る。評価値はtechnical report内の自社harnessや一部official scoreに依存するため、第三者再現性は追加確認が必要。
- **次に読む/試すなら**: MOPDのreverse-KL objectiveとAppendix Bの導出を確認する。HMPOを既存reasoning modelのlength-control RLとして再現できるか調べる。SWE-benchのようなlong-horizon agent taskでdistillation後に何が失われるかを小規模に検証する。
- **キーワード**: `Mixture-of-Experts`, `agentic model`, `post-training`, `reinforcement learning`, `MOPD`, `on-policy distillation`, `HMPO`, `token efficiency`, `tool use`, `long-horizon agents`

## 気になったこと

- MOPDでteacherとstudentのparameter countを揃えると良いという観察が、どの程度一般化するのか。
- HMPOの「正解rolloutのmedian length」は、正解率が低い初期段階や多解問題で安定するのか。
- Behavioral-SafetyBenchやContent-SafetyBenchが内部評価由来なので、公開benchmarkとの相関や再現性を確認したい。
- Agent系でSWE能力がMOPD後に落ちる理由が、scaffold-specific behaviorの消失なのか、長期credit assignmentの劣化なのかを切り分けたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
