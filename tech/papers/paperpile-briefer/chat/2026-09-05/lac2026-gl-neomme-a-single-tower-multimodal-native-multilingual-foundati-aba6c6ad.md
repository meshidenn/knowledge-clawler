# Chat Prompt 2026-09-05

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {NeoMME}: A single-tower multimodal-native multilingual foundation encoder for efficient fine-tuning and inference

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-05 - NeoMME: A Single-Tower Multimodal-Native Multilingual Foundation Encoder for Efficient Fine-Tuning and Inference

## 基本情報

- **タイトル**: NeoMME: A Single-Tower Multimodal-Native Multilingual Foundation Encoder for Efficient Fine-Tuning and Inference
- **著者**: Aurélien Lac, Tony Wu
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: [arXiv:2609.01657](https://arxiv.org/abs/2609.01657)、[Hugging Face collection](https://hf.co/collections/Hcompany/neomme)

## 落合陽一フォーマット

- **ひとことでいうと**: 画像パッチと多言語テキストを、別々の視覚モデルなしに単一の双方向Transformerで処理し、軽量かつ高性能な文書画像検索器を作った論文。
- **先行研究と比べてどこがすごい？**: ColPali系のようにVLMや事前学習済みvision towerを流用せず、260M/800M規模のモデルをスクラッチから学習した。ViDoRe v3で260M版は0.523 nDCG@10、800M版は0.556を達成し、260M版は300M未満の比較モデルを上回る。2048×2048入力ではColModernVBERTの約2倍のページ符号化スループットも報告する。
- **技術や手法の肝はどこ？**: 32×32の生RGBパッチとテキストtokenを別々に埋め込みつつ、その後は全層を共有するsingle-tower・双方向encoderに統合する。画像を条件としたmasked discrete-diffusionによるテキスト復元で事前学習し、下流ではdense埋め込みとMaxSim型late-interaction埋め込みを同時学習する。階層的token poolingと非対称量子化で、文書埋め込みを255倍圧縮する。
- **どうやって有効だと検証した？**: Visual document retrievalをViDoRe v1/v2/v3、テキスト検索をBEIR-15で評価した。ViDoRe v3では高解像度入力、モデルサイズ、dense/late-interaction head、圧縮率の影響を比較し、圧縮後もベースラインの95%以上のnDCG@10を維持したとする。比較値の一部は著者らの再評価であり、外部リーダーボード由来の値も含む。
- **議論はある？**: 主評価は検索であり、生成能力や他のmultimodal理解タスクへの汎化は十分に検証されていない。多言語tokenizerは対象14言語では効率的だが、本文では204言語で見ると対象外言語のカバレッジが弱い可能性にも触れる。高性能なlate interactionはストレージ・検索計算量を増やすため、圧縮や専用indexへの依存が実運用上の前提になる。
- **次に読む/試すなら**:
  1. NeoMME-260M-RetrieverをViDoRe互換の自前PDFコーパスで試し、OCRベースRAGとの差を測る。
  2. 1536pxへの解像度削減とpooling・量子化を組み合わせ、検索品質・保存容量・レイテンシのPareto点を探す。
  3. ColPali、ColModernVBERT、dense-only NeoMMEを同一データ・同一GPUで再比較する。
- **キーワード**: `multimodal retrieval`, `visual document retrieval`, `late interaction`, `single-tower encoder`, `masked diffusion`, `multilingual embedding`

## 気になったこと

- 単一backbone化による効率改善が、学習総計算量・事前学習データ量まで含めても優位か確認したい。
- ViDoRe以外の実文書、低品質スキャン、複雑な表・数式・多言語混在ページでの失敗例を見たい。
- 圧縮後の255倍という結果が、検索indexの構築時間・検索遅延・更新頻度に与える影響を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
