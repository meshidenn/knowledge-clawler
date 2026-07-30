# Paperpile Brief 2026-07-31 - Squeeze Evolve: Unified multi-model orchestration for verifier-free evolution

## 基本情報

- **タイトル**: Squeeze Evolve: Unified multi-model orchestration for verifier-free evolution
- **著者**: Monishwaran Maheswaran, Leon Lakhani, Zhongzhu Zhou, Shijia Yang, Junxiong Wang, Coleman Hooper, Yuezhou Hu, Rishabh Tiwari, Jue Wang, Harman Singh, Qingyang Wu, Yuqing Jian, Ce Zhang, Kurt Keutzer, Tri Dao, Xiaoxia Wu, Ben Athiwaratkun, James Zou, Chenfeng Xu
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2604.07725

## 落合陽一フォーマット

- **ひとことでいうと**: verifierなしのLLM進化的推論を、強い高コストモデルと安いモデルの役割分担で高速・低コスト化する「Squeeze Evolve」を提案した論文。
- **先行研究と比べてどこがすごい？**: RSAやself-aggregation系の単一モデル進化では、多段ループで出力多様性が潰れてpass@K上限が落ちる、という問題を指摘している。Squeeze Evolveは、初期化・選択・再結合・fitness推定を統一的な進化フレームワークとして整理し、強いモデルを高効用な箇所にだけ使う。AIME 2025、HMMT 2025、GPQA-Diamond、LiveCodeBench V6、MMMU-Pro、BabyVision、ARC-AGI-V2、circle packingで評価し、単一高コストモデルRSAに対してAPIコストを最大約3倍削減、固定GPU予算でスループットを最大約10倍改善したと報告している。
- **技術や手法の肝はどこ？**: 肝は「model-intrinsic confidence」を外部verifierの代替的なfitness信号として使い、candidate groupごとに安いモデル・高いモデル・軽量集約へroutingする点。初期populationは強いModel 2で生成し、その後の再結合ではgroup confidenceやanswer diversityに基づいて、簡単そうなgroupは安いModel 1やmajority voteへ、難しいgroupはModel 2へ送る。cross-model confidenceはprefill-only forward passで計算し、vLLM上のcustom confidence engineでlogprob tensor全体を返さずscalarだけを返すことでrouting overheadを抑えている。
- **どうやって有効だと検証した？**: 数学・コード・視覚・ARC・科学的発見タスクで、Model 2のみのRSAと比較している。代表例では、AIME25でQwen3 Instruct/Thinking構成が89.2%・$0.94から90.7%・$0.66へ、HMMT25でGPT-OSS 20B/120B構成が89.7%・$0.41から92.0%・$0.25へ改善。MMMU-Proではtext-onlyのQwen3.5-35Bを後段に使って79.06%・$0.46を達成し、Kimi-2.5-Thinking単独の78.58%・$1.04を上回った。ARC-AGI-V2では97.5%・$7.74/task、Gemini 3.0 Flash併用のsingle recombinationでは同じ97.5%を$5.93/taskで達成したとする。
- **議論はある？**: confidenceやdiversityは軽量だがnoisyな代理指標であり、正しさを保証するverifierではない。人口サイズ、group size、loop数、routing thresholdはタスクごと固定で、動的停止や探索拡張は未検証。完全なtrajectory単位で処理するため、推論途中の不確実箇所だけを再生成するような細粒度最適化は今後課題。PDF本文では収束保証やconfidenceが正誤を分離できる条件も未解決問題として挙げられている。
- **次に読む/試すなら**: RSA実装にgroup confidence routingだけを追加して、手元のLLM pairでコスト対精度曲線を再現する。logprobsが取れないAPIではanswer diversity routingを試す。小規模なコード生成・数学QAで、初期化だけ強モデル、再結合は安モデルという設定の損益分岐を測る。
- **キーワード**: `test-time scaling`, `verifier-free evolution`, `model routing`, `recursive self-aggregation`, `confidence scoring`, `multi-model orchestration`

## 気になったこと

- confidenceが「正しさ」ではなく「モデルが自信を持てる分布」を測っているため、過信・同質化・誤答への収束をどう防ぐか。
- 初期化を強モデルに寄せる設計は妥当そうだが、探索型タスクでは安いモデルの多様性を初期populationに混ぜた方がよいケースがありそう。
- routing percentile `p` のチューニングを、固定値ではなく予算・難易度・収束度に応じて自動化できるか。
- verifier-freeでcircle packingに迫る結果は面白いが、実行feedbackなしでどこまで一般のプログラム探索に効くかは追加確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [maheswaran2026-ss-squeeze-evolve-unified-multi-model-orchestration-for-v-88511fbd.md](../../chat/2026-07-31/maheswaran2026-ss-squeeze-evolve-unified-multi-model-orchestration-for-v-88511fbd.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
