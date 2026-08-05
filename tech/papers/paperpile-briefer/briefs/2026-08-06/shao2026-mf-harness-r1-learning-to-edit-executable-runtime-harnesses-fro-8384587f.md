# Paperpile Brief 2026-08-06 - Harness-{R1}: Learning to edit executable runtime harnesses from agent failure trajectories

## 基本情報

- **タイトル**: Harness-{R1}: Learning to edit executable runtime harnesses from agent failure trajectories
- **著者**: Shuai Shao, Kangning Zhang, Qingyao Li, Shijian Wang, Hao Wang, Wenxiang Jiao, Yuan Lu, Yi Guo, Weiwen Liu, Weinan Zhang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2608.02276 / PDF: https://arxiv.org/pdf/2608.02276.pdf / arXiv: 2608.02276 / Code: https://github.com/DeepExperience/Harness-R1 / Models: https://huggingface.co/ShaoShuai0605/Harness-R1

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agent本体の重みではなく、context構築・tool mediation・action validation・recoveryなどの実行時harnessを、失敗trajectoryから学習して自動編集する9Bの「harness engineer」を作った論文。
- **先行研究と比べてどこがすごい？**: 従来のprompt最適化、Self-Refine、固定LLMによるharness編集、program search系は、編集器そのものを実行結果でpost-trainしないことが多い。本論文は、失敗に条件づけた実行可能patchを生成し、同じtask batchでrerunした実際の成功率差分をrewardにして、GRPOで編集policyを更新する点が新しい。vanilla Qwen3.5-9Bで平均成功率を44.3%から53.6%へ+9.3pt、Agent SFT後も59.2%から64.2%へ+5.0pt改善。
- **技術や手法の肝はどこ？**: target agentは凍結し、別の9B harness engineerだけを学習する。入力は失敗trajectoryから抽出したfailure packet。出力は既存runtimeに挿す実行可能overlay patchで、`on_init`、`make_pre_hint`、`on_before_action`、`on_post_step`の4 lifecycle hookを編集する。cold-start SFTで実行可能patchの形式を覚えさせた後、候補patchをK=8生成し、同一batch rerunで得たreward差分をgroup-relativeに正規化してGRPO更新する。
- **どうやって有効だと検証した？**: WebShop、ALFWorld、DBBenchで評価。比較対象はdefault harness、ReAct/Self-Refine/Reflection、Qwen3.5-397B・GLM-5.2・Kimi-K2.6・DeepSeek-V4-Pro・Gemini-3.5-Flash・GPT-5.5などのfrontier editor、supervised-only engineer。Harness-R1はsingle-episode評価でfrontier editorやsupervised-onlyを上回った。さらに20個の未学習target modelへの転移、10 failureだけからのheld-out task改善、lifecycle hookのablationも実施。
- **議論はある？**: rewardがsame-batch rerun由来なので、失敗抽出batchへのtransductive最適化に寄るリスクがある。held-out実験で一定の一般化は示しているが、長期運用でのregression、patchの安全性、実行コスト、multi-round co-evolutionの収束性は未解決。PDF本文では、細かな表の数値は抽出崩れがあるため過度に断定しない方がよい。
- **次に読む/試すなら**: 自分のagent runtimeに4 hook相当のpatch interfaceを切る / failure trajectoryから再利用可能なfailure packetを作る / まずはSFTなしでfrontier model patch + same-batch/held-out rerun評価を最小再現する
- **キーワード**: `LLM agents`, `agent harness`, `runtime adaptation`, `failure trajectories`, `GRPO`, `online reinforcement learning`, `executable patches`, `self-evolving agents`

## 気になったこと

- same-batch rewardで学習したpatchが、実サービスの分布変化や長期memoryを持つagentでどれだけregressionしないか。
- hookの権限設計が強すぎると、agentを助けるのではなく環境操作を肩代わりする抜け道にならないか。
- patchの安全性検証は「実行可能・complete・非regressive」だけで足りるのか。security sandboxや静的解析が必要そう。
- WebShopではpre-action、ALFWorldではpost-feedbackが効くという差分は、自作agentのfailure taxonomy設計に使えそう。
- direct target-agent SFTとharness engineer再学習を交互に回した場合、本当にcompounding gainが出るのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [shao2026-mf-harness-r1-learning-to-edit-executable-runtime-harnesses-fro-8384587f.md](../../chat/2026-08-06/shao2026-mf-harness-r1-learning-to-edit-executable-runtime-harnesses-fro-8384587f.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
