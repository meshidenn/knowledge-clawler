# Paperpile Brief 2026-07-26 - SOAP, Muon, and Beyond: Pushing LLM Pretraining Scales

## 基本情報

- **タイトル**: SOAP, Muon, and Beyond: Pushing LLM Pretraining Scales
- **著者**: Mikail Khona, Aditya Vavre, Boxiang Wang, Deyu Fu, Hao Wu, Mike Chrzanowski, Bryan Catanzaro, Dheevatsa Mudigere, Jeff Pool, Michael Lightstone, Mohammad Shoeybi, Mostofa Patwary, Nima Tajbakhsh, Tijmen Blankevoort
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.20548 / arXiv:2607.20548

## 落合陽一フォーマット

- **ひとことでいうと**: Muon や SOAP などの高次・行列構造を使う optimizer を、LLM の大規模 pretraining、とくに巨大 batch・MoE・Megatron-LM 環境で実用的に動かすための安定化、比較評価、分散実装をまとめた論文。
- **先行研究と比べてどこがすごい？**: AdamW より収束が速いとされる Muon/SOAP を、単なる小規模実験ではなく multi-billion parameter model、trillions of tokens、最大 100M tokens の global batch size まで押し上げて評価している点。さらに update-RMS matching で optimizer 間の learning rate 比較を揃え、SOAP の大 batch 時の loss spike 原因と対策まで踏み込んでいる。
- **技術や手法の肝はどこ？**: AdamW が各パラメータを独立にスケールするのに対し、SOAP は Shampoo 系の Kronecker-factored preconditioner と eigenbasis 上の Adam 的更新を組み合わせる。Muon は second moment を持たず、momentum を Newton-Schulz iteration で orthogonalization して spectral update にする。実用面では、SOAP の preconditioner と現在の gradient statistics のズレを per-step QR orthogonalization や KL-Shampoo 系の covariance estimation で抑え、さらに layer-wise distributed optimizer で 2D 行列構造を壊さず分散更新する。
- **どうやって有効だと検証した？**: PDF本文によると、AdamW、Muon、SOAP を update-RMS matching で比較し、Qwen3-30B-A3B などの MoE 系アーキテクチャや最大 72B parameter 規模、最大 100M tokens の global batch size で next-token prediction の pretraining loss/stability を評価している。結果として、AdamW は大 batch で劣化しやすい一方、Muon と SOAP は安定性と token efficiency を維持し、KL-SOAP が Muon よりわずかに良いケースがあると報告している。
- **議論はある？**: SOAP は memory footprint が大きく、preconditioner/eigenbasis の更新が重く、Tensor Parallelism や fused tensor、QKV splitting への対応が今後の課題。Muon も 2D matrix update 前提なので、通常の ZeRO/FSDP 的な 1D shard と相性が悪い。また Mamba2 の Conv1D filter への orthogonalization では精度劣化や NaN が出る場合があり、行列ベース optimizer が全アーキテクチャに普遍的に合うわけではない。大規模化に伴う小さい singular value の数値ノイズ、BF16/FP32 precision、epsilon tuning も未解決。
- **次に読む/試すなら**: 1. NVIDIA-NeMo/Emerging-Optimizers の実装を読み、Muon と KL-SOAP の optimizer state と対象 parameter の切り分けを見る。2. 小さめの Transformer で AdamW/Muon を update-RMS matching して loss と throughput を比較する。3. Megatron-LM の layer-wise optimizer 実装が ZeRO/FSDP と何を変えているか確認する。
- **キーワード**: `LLM pretraining`, `Muon`, `SOAP`, `AdamW`, `Shampoo`, `higher-order optimizer`, `large batch training`, `MoE`, `Megatron-LM`, `distributed optimizer`

## 気になったこと

- KL-SOAP が Muon より良い場合、その差が optimizer 自体の性質なのか、memory/compute を多く使えることによる実装上の優位なのかを切り分けたい。
- update-RMS matching は optimizer 間比較として筋が良いが、実運用の最適 hyperparameter search とどれくらい一致するのか確認したい。
- Conv1D、MLA、LoRA、fused QKV など、どの tensor shape や operator に Muon/SOAP を適用すべきで、どこは AdamW に残すべきかのルール化が重要そう。
- 100M tokens batch での安定性は魅力的だが、最終性能だけでなく wall-clock、GPU utilization、optimizer step overhead、communication overlap の実測を見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [khona2026-dy-soap-muon-and-beyond-pushing-llm-pretraining-scales-8972f6ad.md](../../chat/2026-07-26/khona2026-dy-soap-muon-and-beyond-pushing-llm-pretraining-scales-8972f6ad.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
