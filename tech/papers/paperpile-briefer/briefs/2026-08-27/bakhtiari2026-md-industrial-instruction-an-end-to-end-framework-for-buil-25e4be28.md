# Paperpile Brief 2026-08-27 - Industrial-instruction: An end-to-end framework for building instruction-tuning and benchmark datasets from industrial technical reports

## 基本情報

- **タイトル**: Industrial-instruction: An end-to-end framework for building instruction-tuning and benchmark datasets from industrial technical reports
- **著者**: Parsa Bakhtiari, Hassan Bashiri, Alireza Khalilipour, Masoud Nasiripour, Moharram Challenger
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.22817v1](https://arxiv.org/abs/2608.22817v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 工業技術報告書PDFから、検索ノイズや複数文書推論を含む産業QAの学習・評価データを一気通貫で作るパイプラインを提案した論文。
- **先行研究と比べてどこがすごい？**: 公開Panasonic文書906件・7,525ページを対象に、実務に近い5種類の検索―質問関係を明示的にデータ化した。Qwen生成版とClaude生成版を同じ工程で比較し、データ生成器の品質・コスト・下流性能・汎用知識保持まで検証している。
- **技術や手法の肝はどこ？**: Dots.OCRによるレイアウト保持型PDF抽出、Markdown化した表を含むテキストの索引化、EmbeddingGemma＋FAISSによる検索、そして「無関係文書／単一・複数文書の補助／単一・複数文書に答えがある」の5シナリオに基づく選択式QA合成で構成する。
- **どうやって有効だと検証した？**: 初期生成約2.39万件をフィルタし、各データセット約1.36万件のQAを作成。Qwen3-4B-Instructの完全fine-tuningではPanasonicベンチマークのSet-Match Accuracyが28.5%から42.0%、F1が46.6%から63.5%へ向上した。Claude生成データでは別split上でSet-Match Accuracyが40.9%から56.4%に改善し、MMLUの低下もほぼ見られなかった。
- **議論はある？**: 対象はPanasonicの公開文書に限られ、画像は除外されている。OCRでは7,525ページ中291ページに抽出問題があり、表構造の崩れも起こり得る。またQwen版とClaude版は評価split自体が異なるため、性能差を厳密な直接比較として解釈できない。Claude版は高品質だが生成費用は約330ドルで、Qwen版の約3.2ドルより約2桁高い。
- **次に読む/試すなら**:
  1. 公開コード・データセットで5シナリオの生成条件と品質フィルタを確認する。
  2. 自組織のマニュアルで、表をMarkdown化した場合と画像も扱う場合を比較する。
  3. 生成モデルを変えたときのデータ品質、RAG頑健性、忘却を同一評価セットで測る。
- **キーワード**: `industrial QA`, `instruction tuning`, `RAG`, `synthetic data generation`, `PDF extraction`, `fine-tuning`

## 気になったこと

- QAの正解性・根拠文書との整合性を、人手でどの程度監査したかを確認したい。
- 無関係文書シナリオが幻覚抑制へ実際にどれほど寄与したか、シナリオ別のablationが必要そう。
- 画像を捨てているため、図面・回路図・グラフが重要な工業文書への一般化は未検証である。
- Claude生成版の優位性が生成器の能力によるものか、データ量差・フィルタ率差によるものかを切り分けたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [bakhtiari2026-md-industrial-instruction-an-end-to-end-framework-for-buil-25e4be28.md](../../chat/2026-08-27/bakhtiari2026-md-industrial-instruction-an-end-to-end-framework-for-buil-25e4be28.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
