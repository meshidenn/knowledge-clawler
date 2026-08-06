# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {LegalPincite}: Multi-level Legal Information Retrieval Dataset

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - LegalPincite: Multi-level Legal Information Retrieval Dataset

## 基本情報

- **タイトル**: LegalPincite: Multi-level Legal Information Retrieval Dataset
- **著者**: Theresia Veronika Rampisela, Henrik Palmer Olsen, Giovanni Colavizza
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: https://arxiv.org/abs/2608.03756 / PDF: https://arxiv.org/pdf/2608.03756.pdf / Dataset: https://huggingface.co/datasets/theresiavr/legalpincite / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: EU司法裁判所（CJEU）判決を対象に、case-to-case、paragraph-to-case、paragraph-to-paragraph の3階層で法的引用検索を評価できる LegalPincite データセットを作った論文。
- **先行研究と比べてどこがすごい？**: 既存の legal IR データセットは paragraph-level の pinpoint citation が少なく、あっても query に引用先情報が残る data leakage や、citing/cited paragraph だけに候補集合を絞る非現実的設定があった。本研究は引用情報を mask した query、全 paragraph を含む corpus、case/paragraph level の ground truth、部分的な法律専門家検証をまとめて提供する点が強い。
- **技術や手法の肝はどこ？**: 既存のCJEU paragraph citation datasetsを統合・修復し、EUR-Lexから近年分を追加取得する。langdetectで非英語 paragraph を除外し、Cellar APIや手動確認で欠損・segmentation errorを補正し、legal NERと正規表現で case title、case number、paragraph number、関係者名などの citation-related information を query から除去する。
- **どうやって有効だと検証した？**: train/dev/test を時系列で分割し、TF-IDF、BM25、LMIR、DPH を PyTerrier で評価。指標は HR@k、NDCG@k、MAP、MRR。test では paragraph-to-paragraph で TF-IDF/BM25 が NDCG@10 約0.555/0.557、paragraph-to-case で TF-IDF が NDCG@10 約0.604。さらに leakage mitigation の比較で、単に paragraph ID を除くだけでは性能が膨らむ場合があり、citation information の除去が必要だと示している。
- **議論はある？**: ground truth の多くが EUR-Lex 由来なので、裁判官が既存IRシステムで見つけた上位結果を引用している feedback loop の可能性がある。専門家 annotation は単一 dense retriever の top-10 に対して行われており網羅性に限界がある。非英語除去や citation masking は自動処理で、漏れが残る可能性もある。判決文には個人名・組織名が残りうる。
- **次に読む/試すなら**: LegalPinciteをHugging Faceから取得してPyTerrierでBM25/TF-IDF baselineを再現する。citation masking前後で自分のretrieverのNDCG@10差を見る。dense retrieverやhybrid retrievalを paragraph-to-paragraph で試す。
- **キーワード**: `legal information retrieval`, `pinpoint citation`, `CJEU`, `paragraph retrieval`, `data leakage`, `PyTerrier`

## 気になったこと

- dense retriever を計算資源の都合で試していないため、現代的な embedding / hybrid retrieval でどこまで伸びるか。
- citation masking が legal NER と regex 依存なので、漏れや過剰maskが retrieval 難易度をどう変えるか。
- EUR-Lex由来 citation を ground truth としたとき、法的関連性と実務上の引用慣行をどこまで区別できるか。
- paragraph-to-paragraph retrieval を RAG の evidence selection として使う場合、短い paragraph 単位で十分か、周辺文脈も必要か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
