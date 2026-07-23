# Paperpile Brief 2026-07-24 - Where should optimizer state live? Tiered state allocation for memory-efficient mixture-of-experts training

## 基本情報

- **タイトル**: Where should optimizer state live? Tiered state allocation for memory-efficient mixture-of-experts training
- **著者**: Nuemaan Malik
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.19058v1

## 落合陽一フォーマット

- **ひとことでいうと**: MoEのoptimizer stateを一律に持つのではなく、backbone・experts・routerごとに必要な状態を変えることで、Adam系の性能を保ちながら学習メモリを大幅に削る論文。
- **先行研究と比べてどこがすごい？**: AdamW、Lion、Muon、Adafactorのようなoptimizerは基本的にモデル全体へ均質な状態管理を適用するが、本論文はMoEのパラメータ群ごとの役割と勾配統計の違いに着目している。6.78B MoEでAdamWのoptimizer state 50.55GBに対し、SkewAdamは1.29GB、peak memoryは81.4GBから31.3GBへ下がり、40GB級GPUに収まる。
- **技術や手法の肝はどこ？**: SkewAdamは、dense backboneにはfp32 momentumとfactored second moment、巨大なexpert群にはfactored second momentのみ、routerには小さいのでfull second momentを持たせる。つまり「Adamのどの成分をどこに置くか」をパラメータtierごとに決める。性能差の主因はtier allocationそのものではなく、backboneにmomentumを残すことだと実験で示している。
- **どうやって有効だと検証した？**: 6.78Bパラメータ、top-2 routing、128 expertsのMoE言語モデルを、OpenWebText上で約82M tokens、10,000 steps学習。AdamW、Muon、Lion、Adafactor、GaLore風baselineと比較し、validation perplexity、peak memory、optimizer state、throughput、router load balanceを評価した。SkewAdamはvalidation perplexity 108.4で、AdamW 126.8、Muon 120.2、Lion 393.7を上回った。learning rate sweep後もAdamWの最良118.5、Adafactorの最良139.7には届かれなかった。
- **議論はある？**: 実験は2-blockの浅いMoEで、専門家パラメータに95%を集中させたstress testであり、多層MoEで同じ挙動になるかは未検証。多くの設定がsingle seedで、82M tokens・context長128も小さい。weight decayはbf16丸めの影響で実質無効化されており、本格的な長期学習では再検証が必要。GaLoreやLion/Muonのtuningも限定的。
- **次に読む/試すなら**: SkewAdam実装を見て、既存MoE trainerにtier別state allocationを入れられるか確認する。多層MoE・長いcontext・長期学習でexpert momentumが本当に不要か小規模再現する。ZeROや8-bit optimizerとSkewAdamの組み合わせでメモリ削減がさらに効くか検証する。
- **キーワード**: `Mixture-of-Experts`, `optimizer state`, `SkewAdam`, `Adafactor`, `AdamW`, `memory-efficient training`, `tiered allocation`, `bfloat16`

## 気になったこと

- SkewAdamの優位が2-block MoEという極端な構成にどれだけ依存しているか。
- expert momentumを捨てても長期学習・多層routing・大規模token予算で劣化しないか。
- routerのfull second momentは実験上ほぼ効いていないように見えるが、routingが不安定な設定では効くのか。
- bf16 master weightsでweight decayが実質no-opになっている点は、実運用のoptimizer比較として注意が必要。
- ZeRO、FSDP、8-bit optimizer、quantized stateとtiered allocationを組み合わせたときの実装複雑性と実効メモリ削減。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [malik2026-tc-where-should-optimizer-state-live-tiered-state-allocation-f-0b6f0927.md](../../chat/2026-07-24/malik2026-tc-where-should-optimizer-state-live-tiered-state-allocation-f-0b6f0927.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
