# Paperpile Brief 2026-08-26 - AVO: Agentic Variation Operators for Autonomous Evolutionary Search

## 基本情報

- **タイトル**: AVO: Agentic Variation Operators for Autonomous Evolutionary Search
- **著者**: Terry Chen, Zhifan Ye, Bing Xu, Zihao Ye, Timmy Liu, Ali Hassani, Tianqi Chen, Andrew Kerr, Haicheng Wu, Yang Xu, Yu-Jung Chen, Hanfeng Chen, Aditya Kane, Ronny Krashinsky, Ming-Yu Liu, Vinod Grover, Luis Ceze, Roger Bringmann, John Tran, Wei Liu, Fung Xie, Michael Lightstone, Humphrey Shi
- **年 / venue**: 2026 / arXiv [cs.LG]（preprint）
- **リンク**: [arXiv:2603.24517](https://arxiv.org/abs/2603.24517) / [PDF](https://arxiv.org/pdf/2603.24517.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: 進化的探索の「変異」を単発のLLMコード生成から、調査・実装・実行・デバッグを自律反復するコーディングエージェントへ置き換え、B200向けAttentionカーネルを専門家実装以上に高速化した。
- **先行研究と比べてどこがすごい？**: FunSearchやAlphaEvolve型では、親個体選択や評価手順は固定で、LLMは候補生成を担う。本研究はエージェントが過去の系譜・ハードウェア文書・プロファイル結果を参照し、探索方針自体を長時間かけて変える。MHAでcuDNN比最大3.5%、FlashAttention-4比最大10.5%の性能向上を報告する。
- **技術や手法の肝はどこ？**: `Vary(P)=Agent(P, K, f)` と定式化し、系譜 `P`、知識ベース `K`、正確性・スループット評価器 `f` をエージェントに直接渡す。候補は正確性を通り、既存最良と同等以上の場合だけ系譜にコミットする。発見例には、分岐を除くaccumulator再スケーリング、Correction warpとMMAのパイプライン重畳、warp group間のレジスタ再配分がある。
- **どうやって有効だと検証した？**: NVIDIA Blackwell B200上で、BF16・head dimension 128・16 headsのMHA forwardを7日間、人手介入なしで進化させた。500超の最適化方向を探索し、40個の改善済みカーネルをコミット。cuDNNとFlashAttention-4を比較対象にし、GQAへの転移も約30分の追加自律適応で評価した。
- **議論はある？**: 評価は主にB200上のAttention forwardカーネルに限られ、他GPU・他ドメイン・backward計算への一般化は未検証。ベースライン比較は環境差（ドライバ、温度、クロック等）の影響を受けうる。エージェントのモデル、計算資源、探索コスト、完全な内部試行軌跡の再現性は本文から十分には明確でない。
- **次に読む/試すなら**:
  1. FlashAttention-4とcuDNNの比較条件・ベンチマークスクリプトを確認する。
  2. AVOの系譜管理・知識ベース・評価ゲートだけを小規模CUDAカーネル最適化に再現する。
  3. 異なるGPU世代やAttention backwardで、探索結果が転移するか検証する。
- **キーワード**: `agentic coding`, `evolutionary search`, `GPU kernel optimization`, `Attention`, `Blackwell`, `FlashAttention`

## 気になったこと

- 7日間の探索に必要なエージェント推論量、GPU時間、失敗試行数を含む総コストはどの程度か。
- コミット判定が「最良版以上」であるため、多様性を維持する探索と比べて局所解へ陥るリスクをどう扱うか。
- 文書・既存実装を知識ベースに含める際、ベースライン実装への依存度や、発見の独自性をどう定量化するか。
- 性能向上の一部は非causal条件で大きく、causalや別形状での頑健性をさらに確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [chen2026-eu-avo-agentic-variation-operators-for-autonomous-evolutionary-9ace9b6e.md](../../chat/2026-08-26/chen2026-eu-avo-agentic-variation-operators-for-autonomous-evolutionary-9ace9b6e.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
