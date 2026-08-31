# Paperpile Brief 2026-09-01 - ITER: Interaction-aware Retrieval for Agentic Search

## 基本情報

- **タイトル**: ITER: Interaction-aware Retrieval for Agentic Search
- **著者**: Haodong Chen, Shuai Wang, Yu Yin, Shengyao Zhuang, Guido Zuccon, Teerapong Leelanupab
- **年 / venue**: 2026 / arXiv [cs.IR]（under review）
- **リンク**: [arXiv:2608.27912v1](https://arxiv.org/abs/2608.27912v1) / [Code](https://github.com/ielab/ITER)

## 落合陽一フォーマット

- **ひとことでいうと**: Deep Researchエージェントの過去の検索・閲覧履歴を使い、「すでに読んだ情報」ではなく次に必要な新規証拠を上位に出すDense Retriever、ITERを提案した論文。
- **先行研究と比べてどこがすごい？**: 現在のsub-queryだけを処理するLRAT等と違い、主質問と過去sub-queryを明示的に条件化する。既読かつ有用だった文書を「冗長な負例」として強く学習させ、6つのagent backbone・2ベンチマーク全12比較でLRATを上回った。未見agentへの転移でもAgentIRより高いタスク成功率を報告している。
- **技術や手法の肝はどこ？**: クエリ表現を「主質問 + 現在sub-query + 過去sub-query」で構成し、検索の文脈を保持する。将来訪問され有用と判定された文書を正例、既読で有用な文書を冗長負例、既読だが無用な文書をhard negative、未訪問の検索結果をweak negativeとして、重み付き対照学習を行う。冗長負例の重みを最大にすることで、関連性だけでなく履歴に対する限界利得を最適化する。
- **どうやって有効だと検証した？**: InfoSeek-EvalとBrowseComp-Plusで、Tongyi-DeepResearch-30Bを含む3モデル系列・6 backboneを比較した。学習軌跡を生成したTongyiでは、InfoSeek-Evalの成功率80.0（LRAT 72.7）、BrowseComp-Plus 46.6（LRAT 43.4）を報告。入力文脈・負例設計のablationも行い、過去sub-queryと冗長負例が主な寄与要因であることを示した。
- **議論はある？**: 軌跡・文書訪問・事後推論に依存するため、学習データを生成したagentや検索環境への依存が残る。既読文書本文やその解釈をクエリに直接入れると性能が下がっており、「agentが何を理解済みか」を表現する方法は未解決。結果はpreprintであり、実Web検索・異なるコーパス・長期的なコスト削減への検証は限定的である。
- **次に読む/試すなら**:
  1. ITERを既存のDeep Research agentに接続し、重複閲覧率と回答品質の変化を測る。
  2. 「既読だが再提示すべき文書」を扱えるよう、冗長性を二値ではなく情報利得で推定する設計を試す。
  3. LRAT、AgentIR、会話履歴を使うcontext-aware retrievalとの比較条件を確認する。
- **キーワード**: `agentic search`, `dense retrieval`, `interaction-aware retrieval`, `trajectory learning`, `redundancy negatives`, `deep research`

## 気になったこと

- 既読文書を下げることが、重要証拠の再確認を妨げるケースをどう防ぐか。
- 「有用」の判定が事後推論とLLM verifierに依存しており、その誤判定が学習へ与える影響。
- 検索履歴が長くなった場合の入力長、検索遅延、履歴選択戦略。
- タスク成功率の改善が、検索回数・トークン消費・外部検索APIコストの削減にもつながるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [chen2026-zu-iter-interaction-aware-retrieval-for-agentic-search-de5653eb.md](../../chat/2026-09-01/chen2026-zu-iter-interaction-aware-retrieval-for-agentic-search-de5653eb.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
