# Paperpile Brief 2026-10-01 - Effective dense retrieval using only in-Context Examples

## 基本情報

- **タイトル**: Effective dense retrieval using only in-Context Examples
- **著者**: Nour Jedidi、Abdul Basit Ali、Hang Li、Jimmy Lin
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: https://arxiv.org/abs/2609.38099v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMに少数の文脈内例を与えるだけで、学習なしに高品質な密ベクトル検索表現を生成する手法RICEを提案した。
- **先行研究と比べてどこがすごい？**: 通常は検索用表現を得るためにretriever trainingが必要だが、RICEはtraining-freeでLLMをdense retrieverとして利用する。prompt-based LLM embeddingsの精度を大きく改善したと報告している。
- **技術や手法の肝はどこ？**: クエリと文書のエンコードに共通する文脈を、in-context examplesとしてLLMに与える。その条件下で得られる表現を、検索用のdense embeddingsとして利用する。
- **どうやって有効だと検証した？**: prompt-based LLM embeddingsとRICE embeddingsの検索精度を比較し、RICEによる改善を確認したとされる。ただし、PDF本文が取得できていないため、データセット、評価指標、モデル、比較対象、具体的な数値はメタデータからは不明。
- **議論はある？**: PDF本文がないため、計算コスト、例の選び方への依存、モデルやタスクをまたいだ再現性、通常のretriever trainingとの精度差、in-context examplesの情報漏洩リスクはメタデータからは不明。
- **次に読む/試すなら**:
  1. arXiv本文と公開コードを確認し、RICEのプロンプト構成と例の選定方法を再現する。
  2. 小規模な質問・文書データセットで、通常のLLM embeddingとRICE embeddingの検索精度を比較する。
  3. 例の数や内容を変えたときの性能・推論コストの変化を測定する。
- **キーワード**: `RICE`, `dense retrieval`, `in-context learning`, `LLM embeddings`, `training-free retriever`

## 気になったこと

- クエリと文書に共有させる文脈は、どのように設計・選定されるのか。
- RICEの改善は、表現能力の向上によるものか、単に検索タスク向けの指示を明確化した効果なのか。
- LLMの推論回数・トークンコストは、専用retrieverの運用コストと比べて許容できるのか。
- 評価は英語中心なのか、多言語・長文・ドメイン特化検索でも成立するのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [jedidi2026-ep-effective-dense-retrieval-using-only-in-context-examples-00e0f033.md](../../chat/2026-10-01/jedidi2026-ep-effective-dense-retrieval-using-only-in-context-examples-00e0f033.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
