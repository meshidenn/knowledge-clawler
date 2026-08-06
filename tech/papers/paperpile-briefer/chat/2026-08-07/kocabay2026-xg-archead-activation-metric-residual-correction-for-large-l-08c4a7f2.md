# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {ARCHead}: Activation-metric residual correction for large language model output heads

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - ARCHead: Activation-metric residual correction for large language model output heads

## 基本情報

- **タイトル**: ARCHead: Activation-metric residual correction for large language model output heads
- **著者**: Şuayp Talha Kocabay, Talha Rüzgar Akkuş, Kamer Ali Yuksel
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2608.02703 / arXiv:2608.02703

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの最後の巨大なLM-headを、BF16の密行列を残さずに圧縮するため、量子化低ランクコア・group-wise INT4残差・activation metricに基づく低ランク補正を組み合わせた手法。
- **先行研究と比べてどこがすごい？**: GPTQ/AWQ/bitsandbytesなどは主にTransformer blockを量子化し、実装上LM-headをBF16/FP16のまま残すことがある。ARCHeadはこの取り残された出力射影を対象にし、Qwen3-8B-BaseでBF16 headの25.6%の保存容量にしつつrelative PPL 1.007を報告している。保存容量を合わせた単純INT4はrelative PPL 1.14〜1.16程度。
- **技術や手法の肝はどこ？**: LM-headの重み誤差を単なるFrobenius normで見るのではなく、最終hidden stateの共分散 `C = H^T H / N` から作るactivation-derived metricで評価する点。固定された量子化コア `Wd` の残差 `E = W - Wd` に対し、`E Tp` をtruncated SVDして低ランク補正を作り、頻繁に活性化される方向のlogit誤差を優先的に直す。
- **どうやって有効だと検証した？**: WikiText-103のtraining splitからcalibration activationを取り、held-out 16,384 tokensでCE/PPL/logit MSE/KL/agreementなどを評価。Qwen3-8B-Base、Gemma-4-E4B、VibeThinker-3Bでhead-only比較を行い、さらにAWQやbitsandbytes NF4が残したQwenのBF16 headをARCHeadに置き換えるhybrid実験も実施。保存サイズは理論bit数ではなく、PyTorchの実際の`state_dict` bufferサイズから測定している。
- **議論はある？**: 最適性主張は「固定されたcore」「未量子化の低ランク補正」「invertibleなmetric transform」に対する条件付きのもの。INT8 factor量子化後のend-to-end最適性ではない。また、主評価はWikiText perplexityとlogit fidelity中心で、HellaSwag/TruthfulQA/WinoGrandeはsanity check扱い。fused Triton kernelの検証も単一GPU中心で、本番backendや多様なhardwareでの一般性は未検証。
- **次に読む/試すなら**: 
  1. GitHub実装 https://github.com/suayptalha/archead を確認し、Qwen系モデルでLM-headのみ置換できるか試す。
  2. 自分の量子化済みcheckpointで`lm_head`がBF16/FP16のまま残っているか確認する。
  3. calibration tokens数、metric power `p`、rank `rc/rr`を変えた保存容量とPPLのトレードオフを再現する。
- **キーワード**: `LM-head compression`, `activation-aware quantization`, `low-rank correction`, `INT4 quantization`, `LLM deployment`

## 気になったこと

- AWQやbitsandbytes以外の量子化backendでは、LM-headが実際にどのprecisionで保存されるのか。
- WikiText以外のdomain-specific corpusでcalibrationした場合、activation metricの効果はどれくらい変わるのか。
- vocabularyが大きいモデルでは特に効きそうだが、小語彙・小hidden dimensionのモデルでの損益分岐点はどこか。
- fused kernelなしでも実運用で十分速いのか、また複数GPU・batch inference・long context時のpeak memoryにどう効くのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
