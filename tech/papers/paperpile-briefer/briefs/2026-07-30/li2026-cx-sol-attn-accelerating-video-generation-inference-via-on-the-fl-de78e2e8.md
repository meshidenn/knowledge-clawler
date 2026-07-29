# Paperpile Brief 2026-07-30 - Sol-Attn: Accelerating video generation inference via on-the-fly attention sparsification

## 基本情報

- **タイトル**: Sol-Attn: Accelerating video generation inference via on-the-fly attention sparsification
- **著者**: Haopeng Li, Yitong Li, Junsong Chen, Tian Ye, Haozhe Liu, Jincheng Yu, Duomin Wang, Ruihua Zhang, Zeke Xie, Enze Xie, Song Han
- **年 / venue**: 2026 / arXiv [cs.CV]
- **リンク**: https://arxiv.org/abs/2607.24027 / arXiv:2607.24027

## 落合陽一フォーマット

- **ひとことでいうと**: 動画生成Diffusion Transformerのattention推論を、学習なしで、動的なblock sparse attentionに置き換えて高速化する論文。
- **先行研究と比べてどこがすごい？**: 従来のtop-k/top-p型 sparse attention は、proxy score mapやrouting indexを一度作ってから sparse attention を実行するため、routing自体が重く、また捨てたblockの寄与を完全に失う。Sol-Attnはrouting、sparse計算、捨てたblockの近似補正をonline softmaxの1パス内に統合し、動画生成で2.1倍、動画編集で2.3倍、Sol-Engine統合では最大5.08倍程度のend-to-end高速化を報告している。
- **技術や手法の肝はどこ？**: block proxy logitsがモデル内でおおむねGaussian的に分布するという観察から、各query blockごとに `tau = mu + beta sigma` の閾値を作り、key blockを走査しながらon-the-flyで採否判定する。選ばれたblockは厳密attentionで計算し、選ばれなかったblockはpooled key/valueを使った0次近似でsoftmaxの分母・分子に寄与させる。これにより「捨てる」のではなく「粗く残す」sparse attentionになっている。
- **どうやって有効だと検証した？**: Wan2.1-14B、HunyuanVideo-13B、LTX 2.3-22Bでtext-to-video、Bernini-14Bでvideo editing、SANA-WM Refinerでvideo refinement、Ideogram 4で2K text-to-imageを評価。品質指標にはVBench、Bernini-Bench、Qwen-Image-Bench、pose accuracy、dense出力とのPSNR/SSIM/LPIPSを使い、速度はFA3/FA4 dense attention比のwall-clock end-to-end speedupで比較している。H100上のkernel評価では128K tokens・90% sparsityでFA3比5.41倍、routing latencyはtop-k比11.5倍、top-p比32.7倍高速と報告。
- **議論はある？**: 評価対象は主に双方向のdiffusion-based visual generationで、autoregressive video generationは未検証。B200 kernelはBlackwell性能を十分使い切れておらず、現状はforward inferenceのみ対応。近似補正はblock内のscore spreadが小さいtail blockでは効きやすいが、heterogeneousなblockでは誤差が残る可能性がある。PDF本文上ではコード公開リンクの存在は示されているが、実装詳細の再現容易性はメタデータからは不明。
- **次に読む/試すなら**: Sol-AttnのGitHub実装が公開済みか確認する。既存のFlashAttention系kernelとの差し替え範囲を調べる。自分の動画生成パイプラインでattention sequence lengthとsparsityを測り、beta閾値で品質劣化が出る点を小規模に評価する。
- **キーワード**: `sparse attention`, `video generation`, `Diffusion Transformer`, `online softmax`, `attention sparsification`, `training-free acceleration`, `FlashAttention`

## 気になったこと

- `mu + beta sigma` のGaussian仮定が、モデル・layer・denoising stepごとにどれくらい安定しているか。
- text tokenやcross-attentionをdenseに残す設計が、他のMMDiT/DiTアーキテクチャでも同じように必要か。
- 0次近似で十分なblockと、厳密計算すべきblockを分ける基準が、映像破綻や文字崩れにどう効くか。
- Kernel実装がH100/RTX 5090/B200以外のGPUでどの程度そのまま効くか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [li2026-cx-sol-attn-accelerating-video-generation-inference-via-on-the-fl-de78e2e8.md](../../chat/2026-07-30/li2026-cx-sol-attn-accelerating-video-generation-inference-via-on-the-fl-de78e2e8.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
