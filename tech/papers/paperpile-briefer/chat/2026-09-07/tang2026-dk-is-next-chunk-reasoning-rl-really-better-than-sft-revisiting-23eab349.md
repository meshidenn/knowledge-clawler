# Chat Prompt 2026-09-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Is next-chunk reasoning {RL} really better than {SFT}? Revisiting training strategies under no-{CoT} data

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-07 - Is next-chunk reasoning RL really better than SFT? Revisiting training strategies under no-CoT data

## 基本情報

- **タイトル**: Is next-chunk reasoning RL really better than SFT? Revisiting training strategies under no-CoT data
- **著者**: Yinhao Tang, Youqing Fang, Yanan Sun, Jiangning Liu, Ziyi Wang, Xun Zhao, Weiming Zhang, Bin Liu, Kuikun Liu, Wenwei Zhang, Kai Chen
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.23256v1](https://arxiv.org/abs/2608.23256v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 明示的なCoTを含まない解答データ（no-CoT）を活用するなら、次チャンク予測を報酬にするRLよりも、no-CoTとlong-CoTを混ぜた単純なSFT（Mixed SFT）の方が、後段RLVR後の推論性能と計算効率で優れることを示した論文。
- **先行研究と比べてどこがすごい？**: 既存のnext-chunk reasoning RLは「no-CoTのみのSFT」と比べていたが、本論文はlong-CoTも同時に学習するMixed SFTを比較対象として導入した。同一のRLVR後ではMixed SFTが数学内外の推論ベンチマークで最良の到達性能を示し、NTR/NSRより60倍超少ない学習計算量で済むと報告する。
- **技術や手法の肝はどこ？**: Qwen3-30B-A3B-Baseから、(1) token単位のnext-token reasoning（NTR）、(2) 文単位のnext-sentence reasoning（NSR）、(3) no-CoT→long-CoTのSequential SFT、(4) 両データを一段階で学ぶMixed SFTを比較し、全方式の後段に同一のGRPOベースRLVRを置く。Mixed SFTは事前評価では出力形式の不安定さで低得点でも、no-CoT由来の知識を忘却せず、RLVRがその潜在能力を引き出すという設計思想である。
- **どうやって有効だと検証した？**: AoPS由来のno-CoT解答42.1万件と、DeepSeek-V3.2で生成・正解選別したlong-CoT 15.2万件を用い、DAPO-Math-17Kで同一RLVRを実施した。AIME 2024–2026、HMMT 2025–2026、IMO-Answerに加え、HLE、GPQA-Diamond、MMLU-Proで前後比較した。Mixed SFTのRLVR後のin-domain平均は67.4で、次点NTRの64.2を上回り、GPU時間はSFT 65.6時間に対しNTR 4,608.1時間、NSR 4,283.7時間だった。
- **議論はある？**: 検証は主に単一のベースモデル、AoPS中心の数学データ、特定のRLVR設定に依存しており、他モデル・他領域・異なるデータ混合比での一般化は未検証である。Mixed SFTは事前RLVR時点では`<think>`形式の崩れを起こしやすく、RLVRで回復する前提にも依存する。また、NTRの失敗要因として局所的な補完への退化を示唆するが、因果機構の完全な切り分けには追加検証が必要である。
- **次に読む/試すなら**:
  1. 自分のno-CoTデータとCoTデータを混ぜたSFT→RLVRを、逐次SFTおよびno-CoT単独SFTと比較する。
  2. RLVR前の精度だけで選別せず、同一RLVR予算後の性能上限で初期化手法を評価する。
  3. 混合比、出力フォーマット統一、非数学領域のno-CoTデータでMixed SFTの再現性を検証する。
- **キーワード**: `no-CoT`, `Mixed SFT`, `next-chunk reasoning`, `RLVR`, `GRPO`, `reasoning post-training`

## 気になったこと

- Mixed SFTの最適なno-CoT/long-CoT混合比と、データサンプリング方針はどの程度性能を左右するか。
- Mixed SFTの形式不安定性を、RLVRなしにテンプレート設計や補助損失で抑えられるか。
- 数学以外の領域で、no-CoTが持つ「潜在知識」をRLVRが同様に引き出せるか。
- NTR/NSRの比較は既存手法の特定実装に依存するため、より強い報酬設計や長期予測タスクでも結論が維持されるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
