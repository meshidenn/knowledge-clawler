# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {MultAttnAttrib}: Training-Free Multimodal Attribution in Long Document Question Answering

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - MultAttnAttrib: Training-Free Multimodal Attribution in Long Document Question Answering

## 基本情報

- **タイトル**: MultAttnAttrib: Training-Free Multimodal Attribution in Long Document Question Answering
- **著者**: Dang Quang Thien Tran, Quang V. Dang, Vinamra Tyagi, Sai Soorya Rao Veeravalli, Trang Nguyen, Ryan A. Rossi, Franck Dernoncourt, Nedim Lipka, Koustava Goswami, Samyadeep Basu
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.01420

## 落合陽一フォーマット

- **ひとことでいうと**: 長いマルチモーダル文書QAで、回答の根拠がどのテキスト範囲・画像・その組み合わせにあるかを、追加学習なしでattentionから推定する手法と評価データセットを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のcitation生成、RAG、caption化、promptingベースの手法では、長文書内の細粒度なマルチモーダル根拠特定が弱い。本論文はVLMのprefill pass中のattention headを使い、単一forward passで根拠を出す。Qwen3-VL-30B上ではprompting系baselineよりF1が一貫して高く、画像・マルチモーダル根拠で特に改善。非vLLM・A100条件ではVLM promptingより約7.3倍低レイテンシ、peak VRAMも約15GB低いと報告している。
- **技術や手法の肝はどこ？**: 小さなprobe setで、Causal Mediation Analysisにより根拠検索に効くattention headを選ぶ。選ばれたheadのattentionを平均し、画像patch tokenとテキストsliding windowにスコアを割り当て、min-max正規化後にtext/image別のF1最大化しきい値でcitationを決める。根拠がしきい値を超えない場合は最高スコアの候補へfallbackする。
- **どうやって有効だと検証した？**: 著者らはMultAttrEvalという、長いPDF文書に対するQuestion-Answer-Attribution tripletのbenchmarkを作成。5ドメイン、text-only / image-only / text+imageの3設定で評価している。90件をprobe、608件をtestに使い、Qwen3-VL-30BとGPT-5.4、VLM/LLM prompting、Cohere RAG、ColQwen RAGなどとmacro precision/recall/F1で比較した。PDF本文上では、Cohere + MultAttnAttribがtext F1 0.665、image F1 0.786、text+image F1 0.601を示し、同一Qwen backboneのprompting baselineを上回る。
- **議論はある？**: probe setのラベルをhead選択とthreshold calibrationに使うため、完全な教師なし手法ではない。attentionが根拠を表すという仮定にも依存する。テキストではrecallが上がる一方でprecisionが落ちる傾向があり、loosely related textを拾う可能性がある。評価データセット自体も生成・フィルタリング過程を含むため、ground truth attributionの粒度や完全性には検証余地がある。
- **次に読む/試すなら**: MultAttrEvalのデータ生成・rubricを確認する。手元のVLMでprefill attentionを取得できるか調べる。CMAではなくMean Attention Scoringでどこまで近似できるか小規模再現する。
- **キーワード**: `multimodal attribution`, `long document QA`, `attention heads`, `training-free`, `VLM`, `grounded QA`, `citation generation`, `CMA`

## 気になったこと

- GPT-5.4というモデル名が論文中に出てくるが、外部から再現可能なAPI・モデル仕様なのかはメタデータ/PDF本文からは不明。
- attention取得が必要なので、閉じたVLM APIではそのまま実装できない可能性がある。
- probe setでhead選択としきい値調整を行う設計が、別ドメインや別モデルへどれだけ移るか確認したい。
- text span評価がfuzzy substringと長さpenaltyなので、意味的に正しいが表現が違うcitationの扱いが気になる。
- 画像patch単位のattention集約が、図表・OCR・細かい視覚要素のどこまで局所化できるか追加で見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
