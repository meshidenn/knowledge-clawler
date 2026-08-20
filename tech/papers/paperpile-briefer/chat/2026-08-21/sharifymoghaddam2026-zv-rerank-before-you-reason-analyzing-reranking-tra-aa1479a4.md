# Chat Prompt 2026-08-21

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Rerank before you reason: Analyzing reranking tradeoffs through effective token cost in deep search agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-21 - Rerank before you reason: Analyzing reranking tradeoffs through effective token cost in deep search agents

## 基本情報

- **タイトル**: Rerank before you reason: Analyzing reranking tradeoffs through effective token cost in deep search agents
- **著者**: Sahel Sharifymoghaddam, Jimmy Lin
- **年 / venue**: 2026 / Findings of ACL 2026（メタデータ上は arXiv [cs.IR]）
- **リンク**: [PDF（ACL Anthology）](https://aclanthology.org/2026.findings-acl.1289.pdf) ／ [実装（DeepHone）](https://github.com/sahel-sh/DeepHone)

## 落合陽一フォーマット

- **ひとことでいうと**: Deep search agentでは、検索後の候補を先にrerankする方が、検索エージェント自身の推論量を増やすより低コストで精度を上げやすいことを示した論文。
- **先行研究と比べてどこがすごい？**: agentic searchの評価を「精度だけ」でなく、キャッシュ入力・非キャッシュ入力・生成／推論トークンを重み付けする**Effective Token Cost（ETC）**で比較した。reranking深度を適度に増やすと、高推論設定と同程度の精度をより低いETCで達成できる。
- **技術や手法の肝はどこ？**: 検索器が返す上位 \(d=10,20,50\) 件をlistwise rerankerで並べ替え、最終上位5件だけを検索エージェントへ渡す。ETCは入力キャッシュ割引と出力トークンの高コストを反映し、異種モデル構成ではrerankerのFLOPs/tokenも補正する。
- **どうやって有効だと検証した？**: BrowseComp-Plusの830問で、gpt-oss-20b/120bの推論強度、reranking深度、モデル規模を比較。Recall@k、NDCG@k、最終回答Accuracy、検索回数、Calibration Error、ETC、レイテンシを測定した。たとえばone-shotではoss-120b・medium・\(d=50\) がNDCG@5 46.05で、rerankなしの19.72を大きく上回る。
- **議論はある？**: 多くの構成は1回のみの実行であり、反復試行は一部設定に限られる。BrowseComp-Plusの固定コーパス上の結果なので、実運用のWeb検索API・動的な文書分布へそのまま一般化できるかは未検証。ETCの重みもキャッシュ率・API価格・ハードウェア次第で変わる。
- **次に読む/試すなら**:
  1. DeepHoneで、手元のRAG/検索agentに \(d=10,20,50\) のrerankingを追加して精度・コスト曲線を測る。
  2. 軽量cross-encoder rerankerとLLM listwise rerankerを、実際のレイテンシ込みで比較する。
  3. 自分の料金体系・キャッシュ効率に合わせてETCの重みを設定する。
- **キーワード**: `deep search agents`, `listwise reranking`, `Effective Token Cost`, `agentic RAG`, `BrowseComp-Plus`

## 気になったこと

- 「moderate reranking」の最適深度は、コーパス規模・検索器品質・文書長でどの程度変化するか。
- rerankingにより検索回数は最大でも限定的にしか減らず、主因は「より良い証拠を最初から渡すこと」とされる。この効果を回答生成能力と証拠忠実性に分解して確認したい。
- ETCを実際のAPI課金額・GPU時間・待ち行列によるtail latencyまで含めた指標に拡張できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
