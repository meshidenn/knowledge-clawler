# Chat Prompt 2026-08-27

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Same agent, different answers: A repeat-aware audit of corpus-induced answer churn in retrieval-augmented {QA}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-27 - Same agent, different answers: A repeat-aware audit of corpus-induced answer churn in retrieval-augmented QA

## 基本情報

- **タイトル**: Same agent, different answers: A repeat-aware audit of corpus-induced answer churn in retrieval-augmented QA
- **著者**: Jingjie Ning, Xueqi Li
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: [arXiv:2608.22856v1](https://arxiv.org/abs/2608.22856v1)

## 落合陽一フォーマット

- **ひとことでいうと**: RAGの検索コーパスを拡張すると、平均正答率がほぼ変わらなくても同じ質問への回答が有意に入れ替わることを示し、その変化を生成の偶然性から分離して測る監査法を提案した論文。
- **先行研究と比べてどこがすごい？**: RAG評価を平均EM/F1だけでなく「旧スナップショットとの回答互換性」として扱う。1回ずつの比較ではなく、同一スナップショット内の再実行不一致を差し引くため、LLMの非決定性をコーパス更新の影響と取り違えにくい。
- **技術や手法の肝はどこ？**: `Snapshot Compatibility Audit` は、各質問について旧・新スナップショットで独立に2回答ずつ生成し、同一状態内の一致度から状態間の一致度を引いた excess answer churn を算出する。正規化完全一致と、状態・証拠・正解を隠した意味的一致判定を併用する。
- **どうやって有効だと検証した？**: FineWebの固定されたネスト済みコーパスを1 shardから7 shardsへ拡張し、モデルID、プロンプト、検索深さ（top-8）などを固定。事前登録済みのNatural Questions 400問では、正規化完全一致・意味的 churn がそれぞれ6.44pp・10.25ppで、EM変化は-1.50ppに留まった。TriviaQA 200問でもより小さいが同方向の結果を得ており、別のDeepSeek構成による100問の追試でも意味的 churn は8.75ppだった。
- **議論はある？**: 検証は単一のFineWeb shard順序、検索サービス、主にDeepSeek系生成器、英語QAに限定されるため、「コーパスを増やすほど churn が増える」という一般法則は示していない。意味的一致はLLM judgeに依存し、50問のクロスファミリー監査はあるものの人手検証ではない。また回答変更は誤りや害を直ちに意味せず、改善も含み得る。
- **次に読む/試すなら**:
  - 本番RAGのインデックス更新前後で、重要クエリに対する2回以上の反復生成と excess churn を計測する。
  - churn が大きい質問を、正答性・下流ワークフローへの影響・検索結果の差分で人手レビューする。
  - ランダムなコーパス分割、複数retriever、時系列更新で同じ監査が再現するか確かめる。
- **キーワード**: `RAG`, `answer churn`, `backward compatibility`, `LLM evaluation`, `corpus update`, `stochasticity`

## 気になったこと

- 1→7 shardsという単一の固定経路なので、回答変化が「データ量」ではなく追加文書の内容やランキングの変化にどの程度起因するかは分離できていない。
- 各状態2回の生成は最小設計であり、出力分布をどこまで安定に推定できるか、反復数を増やした場合の推定量の挙動を確認したい。
- 高churnかつ高影響な回答を自動で優先度付けするには、意味的変化と事業・安全上の影響をどう接続するかが必要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
