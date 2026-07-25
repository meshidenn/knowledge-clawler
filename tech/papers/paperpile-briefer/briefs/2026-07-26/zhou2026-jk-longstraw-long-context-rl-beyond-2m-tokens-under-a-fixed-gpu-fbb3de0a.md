# Paperpile Brief 2026-07-26 - LongStraw: Long-Context RL Beyond 2M Tokens under a Fixed GPU Budget

## 基本情報

- **タイトル**: LongStraw: Long-Context RL Beyond 2M Tokens under a Fixed GPU Budget
- **著者**: Changhai Zhou, Kieran Liu, Yuhua Zhou, Qian Qiao, Jun Gao, Harry Zhang, Irvine Lu, Nolan Ho, Lucian Li, Andrew Lei, Cleon Cheng, Steven Chiang, Yihang Zeng, Di Zhang, Rio Yang, Kaijie Chen, Andrew Chen, Pony Ma, Weizhong Zhang, Cheng Jin
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.14952 / Code: https://github.com/MindLab-Research/longstraw

## 落合陽一フォーマット

- **ひとことでいうと**: 2M token超の長文コンテキストでRL post-training、特にGRPOを固定GPU予算内で動かすための実行システム LongStraw を提案した論文。
- **先行研究と比べてどこがすごい？**: 長文推論はmillion-token化している一方、RL post-trainingは256K以下に留まりがちというギャップに対し、attention kernel単体の高速化ではなく、prompt状態の寿命、response replay、分散ownershipを設計対象にしている。Qwen3.6-27Bでは8枚のH20で2,097,152 positionsのresponse-only GRPOをG=2/G=8で実行し、4,456,448-position prefixでもG=8を8 cycle支えたと報告している。
- **技術や手法の肝はどこ？**: full promptのautograd graphを保持せず、後続tokenに必要なmodel-nativeなresident stateだけをno-gradで保持する点。response replayではprompt境界を復元し、old/reference branchはgraphなしでscoreし、policy responseだけをautograd付きで再構築してbackpropし、またprompt境界に戻す。QwenではGDN recurrent stateとCP8-sharded KV page、GLMではCPU-resident MLA/DSA stateとIndexShare-aware sparse selection、top-8 MoE replayを使う。
- **どうやって有効だと検証した？**: PDF本文によると、Qwen3.6-27Bで8 H20上の2M positions response-only GRPO、G=2/G=8、4.45M prefixでの複数replayを測定。GLM-5.2では32 H20上でdeterministic 2M executionと78-layer backward passを実行。外部統合としてvLLM-DAPO-Tinker/Megatron loopのpreliminary validationもある。ただし測定対象はresponse-only executionで、full-sequence gradient equivalenceではない。
- **議論はある？**: 限界はかなり明示されている。QwenのCP8ではreplicated adapter update equivalenceが未確立で、K/V adapter更新の完全なrank間整合性は別課題。GLMのhistorical 2M runにはCP-local response attentionやgradient finalization未完の制約がある。入力はsynthetic random tokensやdeterministic rewardsを含み、実タスクでの学習品質・長期drift・prefix reuseの許容範囲は追加検証が必要。
- **次に読む/試すなら**: LongStrawのGitHub実装を確認し、resident stateとresponse replayの境界がどのtensorで表現されているか読む。小さいQwen系モデルで、prompt capture + suffix replayの最小再現を作る。GRPO実装側でold/reference/policy branchのmemory lifetimeを計測する。
- **キーワード**: `long-context RL`, `GRPO`, `resident state`, `response replay`, `context parallelism`, `MoE`, `Qwen`, `GLM`

## 気になったこと

- 「response-only execution」と「実際のRL trainingで必要なgradient/update equivalence」の差がどこまで実用上問題になるか。
- prefix state reuseのdriftを、実タスク報酬やagent trajectoryでどの頻度でrefreshすべきか。
- synthetic token/rewardではなく、tool-use agentやlong-document QAで同じmemory envelopeが成立するか。
- Qwen CP8のK/V adapter gradient finalizationを完全に閉じた場合、peak memoryや通信コストがどれだけ増えるか。
- OOMB、Ring Attention、DeepSpeed-Ulysses、USPなどとの実測比較条件を揃えると、LongStrawの優位性がどの軸に残るか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhou2026-jk-longstraw-long-context-rl-beyond-2m-tokens-under-a-fixed-gpu-fbb3de0a.md](../../chat/2026-07-26/zhou2026-jk-longstraw-long-context-rl-beyond-2m-tokens-under-a-fixed-gpu-fbb3de0a.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
