# Paperpile Brief 2026-07-15 - KronQ: LLM Quantization via Kronecker-Factored Hessian

## 基本情報

- **タイトル**: KronQ: LLM Quantization via Kronecker-Factored Hessian
- **著者**: Donghyun Lee, Yuhang Li, Ruokai Yin, Priyadarshini Panda
- **年 / venue**: 2026 / COLM 2026, arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.07964 / GitHub: https://github.com/Intelligent-Computing-Lab-Panda/KronQ

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのpost-training quantizationで、従来の入力activation統計だけでなく出力側gradient covarianceも使い、特に2-bit量子化を安定化する手法KronQを提案した論文。
- **先行研究と比べてどこがすごい？**: GPTQ/GPTAQ系は入力側Hessian近似 `H_X` だけを見るため、出力channelごとの重要度差を暗黙に無視していた。KronQはK-FAC近似 `H ≈ H_X ⊗ H_G` によりgradient covariance `H_G` を導入し、output-side sensitivityを量子化前処理とmixed-precision割当に使う。LLaMA-3-70Bの2-bit weight-onlyで、GPTQ/GPTAQが発散または極端に悪化する条件でもWikiText-2 perplexity 7.93を報告している。
- **技術や手法の肝はどこ？**: コアは2つ。第一に、`H_G` を使ったbidirectional incoherence processingで、従来の入力側rotation/rescalingに加えて出力側も平坦化し、weight magnitudeの偏りを行・列の両方向で減らす。第二に、`tr(H_G) · tr(H_X)` をsublayer sensitivityとして使い、Q/K/V/Oなど入力統計だけでは区別しにくい層間のbit allocationを分ける。重要なのは、量子化更新式では `H_G` が代数的にキャンセルされるため、GPTAQ系の効率を大きく崩さずにgradient情報を使える点。
- **どうやって有効だと検証した？**: LLaMA-2/3の7B〜70B、Mistral-7Bなどで、W2/W3/W4のweight-onlyおよびweight-and-activation量子化を評価。WikiText-2 perplexity、PiQA/ArcE/ArcC/HellaSwag/WinoGrande/BoolQ/OpenBookQAなどのzero-shot accuracyでGPTQ、GPTAQ、BoA、OmniQuant、AWQ、QuIP系、YAQA、GuidedQuantなどと比較している。本文では特に2-bitでの改善幅が大きい。
- **議論はある？**: `H_G` はsingle backward passで得る設計だが、forward-only PTQよりはcalibrationコストと実装複雑性が増える。K-FACの独立仮定 `x ⊥ g` に依存しており、この近似がどの層・モデルでどこまで妥当かは追加検証余地がある。PDF抽出上、細かい表の数値はレイアウト崩れがあり得るため断定しすぎない方がよい。また、inference時にはHadamard transform由来のoverheadがあり、実運用スタックでのlatency/throughput評価は確認したい。
- **次に読む/試すなら**: KronQのGitHub実装でLLaMA-3-8B W2/W3を再現する。YAQAとKronQのgradient covariance利用箇所の違いを読む。自分の量子化対象モデルで `tr(H_G)·tr(H_X)` のsublayer rankingを可視化する。
- **キーワード**: `LLM quantization`, `post-training quantization`, `K-FAC`, `Kronecker-factored Hessian`, `GPTQ`, `GPTAQ`, `mixed precision`, `incoherence processing`

## 気になったこと

- `H_G` 推定に使うcalibration datasetのサイズ・分布で、sublayer sensitivity rankingがどれくらい安定するか。
- KronQの改善が主にBiIP由来なのか、mixed-precision allocation由来なのか、ablationの細部を確認したい。
- Hadamard transformを含む実装がvLLMやTransformersの既存quantized inference pipelineにどれだけ自然に載るか。
- reasoning-heavy benchmarkで2-bit量子化時の劣化がどの能力に集中するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [donghyun2026-rz-kronq-llm-quantization-via-kronecker-factored-hessian-1a33f3dc.md](../../chat/2026-07-15/donghyun2026-rz-kronq-llm-quantization-via-kronecker-factored-hessian-1a33f3dc.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
