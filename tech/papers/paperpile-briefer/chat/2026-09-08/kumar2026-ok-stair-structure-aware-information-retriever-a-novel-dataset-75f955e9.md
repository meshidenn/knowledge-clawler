# Chat Prompt 2026-09-08

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {STAIR} ({STructure} Aware Information Retriever): A novel dataset and {LLM} based retriever for document structure augmentation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-08 - STAIR (STructure Aware Information Retriever): A novel dataset and LLM based retriever for document structure augmentation

## 基本情報

- **タイトル**: STAIR (STructure Aware Information Retriever): A novel dataset and LLM based retriever for document structure augmentation
- **著者**: Vineet Kumar, Meghanadh Pulivarthi, Vishwajeet Kumar, Jaydeep Sen, Riyaz Ahmad Bhat, Sachindra Joshi
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2609.03874](https://arxiv.org/abs/2609.03874) / [PDF](https://arxiv.org/pdf/2609.03874)

## 落合陽一フォーマット

- **ひとことでいうと**: 長文書の目次（ToC）をLLMに与え、回答箇所に対応する節を生成させることで、RAG向け検索の精度と出力の整合性を上げる検索器 STAIR を提案した論文。
- **先行研究と比べてどこがすごい？**: 固定長チャンクや文書IDを検索単位にする代わりに、意味的な境界を持つToCの葉ノードを検索単位にした。SearchTomeでRecall@1 82.6%を達成し、fine-tuned DSIの76.9%、DPRの68.7%、BM25の59.5%を上回った。無効な非葉ノードを生成する割合も0.05%未満と報告している。
- **技術や手法の肝はどこ？**: クエリと文書全体のToCを入力し、正解の節タイトル（葉ノード）を出力するようLLMを教師ありfine-tuningする。推論時には生成候補を有効なToC葉ノードに制約し、モデル内に取り込んだ文書知識と明示的な階層構造を結び付ける。
- **どうやって有効だと検証した？**: 6分野・18冊のオープン教科書から、ToCと節本文を対応付けたSearchTomeを構築した。Mixtral 8x7Bで段落ベースの質問を生成し、Recall@1、Recall@3、nDCG@3でMistral、BM25、DPR、DSIなどと比較した。訓練例を減らすアブレーションでも、STAIRは低データ条件で比較的安定し、DSIより不正な節見出しの生成が少ないとした。
- **議論はある？**: 評価対象は既存のToCを持つ書籍に限定されており、構造がないWebコーパスや企業内の大規模・更新頻繁な文書群への一般化は未検証である。質問は主にLLM生成であり、自然発生クエリでの有効性や、ToC抽出誤りへの頑健性も追加検証が必要。
- **次に読む/試すなら**:
  - 自分の技術文書で、固定長チャンク検索と「見出し単位」検索を比較する。
  - ToCを持たない文書に対し、見出し抽出・階層クラスタリングで擬似ToCを作る実験を行う。
  - STAIRの候補節取得後に本文再ランキングやRAG回答生成を接続し、end-to-endの回答品質を測る。
- **キーワード**: `RAG`, `information retrieval`, `table of contents`, `model-based indexing`, `DSI`, `long-context`

## 気になったこと

- ToC全体を毎回入力するため、目次が極端に大きい文書集合でのコンテキスト長・推論コストはどう増えるか。
- 節タイトルが曖昧、重複、または粒度不均一な場合にどの程度性能が落ちるか。
- 構造的な節検索の改善が、最終的なRAG回答の正確性・引用忠実性・幻覚抑制へどの程度転移するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
