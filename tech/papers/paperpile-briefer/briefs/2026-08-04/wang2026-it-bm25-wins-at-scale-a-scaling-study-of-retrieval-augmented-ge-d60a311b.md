# Paperpile Brief 2026-08-04 - BM25 wins at scale: A scaling study of retrieval-augmented generation paradigms

## 基本情報

- **タイトル**: BM25 wins at scale: A scaling study of retrieval-augmented generation paradigms
- **著者**: Pengyu Wang, Benfeng Xu, Shaohan Wang, Mingxuan Du, Xin Zeng, Huarui Wu, Lei Zhang, Licheng Zhang
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.26497

## 落合陽一フォーマット

- **ひとことでいうと**: RAGの検索方式を、コーパスサイズを段階的に大きくしながら同一条件で比較し、大規模化するとBM25が最も強いデフォルトになることを示した論文。
- **先行研究と比べてどこがすごい？**: 既存のRAG比較は単一コーパスサイズ・異なるベンチマークでの比較が多いが、この研究はEnterpriseRAG-Bench上で28段階、約450倍のネストされたコーパス拡大を行い、質問・関連文書・敵対的文書を固定してスケーリング特性を見た点が新しい。
- **技術や手法の肝はどこ？**: BM25、DenseRAG、HippoRAG 2、MS-GraphRAG、LightRAG、LinearRAG、File-System Agentを、同じreaderモデル、同じ評価プロトコル、同じトークン計測で比較する。特に、最小tierにgold文書・trap・lureを固定した「bedrock」を置き、背景文書だけを増やすことで、検索方式がノイズ増加にどう耐えるかを測っている。
- **どうやって有効だと検証した？**: 511,959文書・約600.8M tokens・500質問のEnterpriseRAG-Benchで評価。File-System Agentは小規模tierで高いが、約10M corpus tokens付近でBM25が逆転し、最大規模ではBM25が50.5、File-System Agentが30.7、DenseRAGが29.9のcombined score。BM25は構築時LLM tokenなしで低コスト側のPareto frontierも押さえている。
- **議論はある？**: 結果はEnterpriseRAG-Benchという合成的な企業内知識ベースに強く依存する可能性がある。File-System Agentは80 LLM calls/questionの固定予算なので、より強い探索戦略や検索ツール併用で変わる余地がある。Graph-based RAGは構築コストやスケール限界が大きく、未完了tierがあるため、実装最適化の影響も残る。
- **次に読む/試すなら**: BM25+agentのcontrol実験を詳しく見る。自分のRAG環境でBM25、dense、hybridを同じreader・同じ質問で比較する。コーパスサイズを増やしたときのquery latencyとtoken costをログ化する。
- **キーワード**: `RAG`, `BM25`, `dense retrieval`, `agentic search`, `GraphRAG`, `scaling study`, `EnterpriseRAG-Bench`

## 気になったこと

- BM25が強い理由は、語彙一致そのものなのか、global candidate rankingがノイズ増加に強いからなのか。
- Dense retrievalが低いのはembedding model、chunk設計、top-k、企業文書の語彙特性のどれが主因か。
- File-System Agentはraw file探索では弱いが、BM25やstructured indexを道具として与えた場合にどこまで回復するか。
- 実運用では「BM25単体」ではなく、BM25で候補発見してagentが検証する構成が最小コストで強そう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [wang2026-it-bm25-wins-at-scale-a-scaling-study-of-retrieval-augmented-ge-d60a311b.md](../../chat/2026-08-04/wang2026-it-bm25-wins-at-scale-a-scaling-study-of-retrieval-augmented-ge-d60a311b.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
