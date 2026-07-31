# Paperpile Brief 2026-08-01 - A new role for relevance: Guiding Corpus Interaction in agentic search

## 基本情報

- **タイトル**: A new role for relevance: Guiding Corpus Interaction in agentic search
- **著者**: Jiangnan Li, Yuqing Li, Mo Yu, Jinchao Zhang, Jie Zhou
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.24223v1 / arXiv:2607.24223v1 / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: agentic searchにおいて、relevanceを単なるtop-k選択ではなく、`ripgrep`によるコーパス探索の実行順序と観測優先度に使うRARGを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のretrieval agentは関連文書を上位に出すだけで、DCIは細かく探索できるがrelevance非依存で収束が遅い。RARGはdocument-level relevanceで探索順を制御し、match-level relevanceで出力制限内に有用なexcerptを残すことで、精度とtool call効率の両方を改善している。
- **技術や手法の肝はどこ？**: `embed_recall(scope_query)`で関連文書パスをranked scope fileに保存し、`cat scope | xargs ... rg -j1 "PATTERN"`として、`rg`を関連度順に逐次走査させる点。さらにRARG+ではquery-relevant paragraphを初期手がかりとして渡し、RARG++では広めに集めた`rg` matchを再ランキングして、低rank文書内の有用な局所証拠もLLMに見せる。
- **どうやって有効だと検証した？**: BrowseComp-Plusの100 query設定、100Kから1M documentsへの拡張、BRIGHTの4 domainsで評価。PDF本文によると、100K BrowseComp-PlusではGPT-5.4-miniのRARG++が84% accuracyで、RISE/DCIの78%を上回り、平均tool callsも23.9でDCIの99.1より大幅に少ない。GPT-5.4ではRARG++が91% accuracy、1M documentsでも79%を維持。BRIGHTではRARG+が平均nDCG@10で53.36を達成し、DCI、RISE、NeMoを上回った。
- **議論はある？**: embedding modelへの依存が強く、document-levelとmatch-levelで必要な粒度が違う。`rg -j1`の逐次化やmatch rerankingにはlatency overheadがある。backbone LLMのinstruction following能力にも敏感で、GPT-5.4-nanoではprotocol追従が弱い。長くノイズの多い文書にスケールすると偶発的なlexical matchが増え、relevance guidanceでも完全には抑えられない。評価対象もBrowseComp-Plus、BRIGHT、GPT-5.x系に限定される。
- **次に読む/試すなら**: RARGのGitHub実装を確認して`embed_recall`と`rg -j1`挿入の実装を見る。既存のDCI/RAG agentにscope file方式を追加して小規模コーパスで再現実験する。match-level rerankingをembedding rerankerとLLM rerankerで比較する。
- **キーワード**: `agentic search`, `Direct Corpus Interaction`, `RARG`, `ripgrep`, `relevance-aware retrieval`, `RAG`, `BRIGHT`, `BrowseComp-Plus`

## 気になったこと

- `rg -j1`で順序保証する設計は分かりやすいが、実運用でのlatencyと並列探索のトレードオフをどう調整するか。
- scope上限10,000 documentsが、ドメインやコーパスサイズを変えたときにも十分なevidence recallを保つのか。
- match-level rerankingで使うlocal excerptの切り出し幅、周辺文脈、重複除去が精度にどれくらい効くのか。
- RARG++のgenerative reranking-query variantが速いが精度を落とすという点は、prompt/protocol設計の問題なのかモデル能力の問題なのか。
- open-web searchや動的Web環境でも、ranked scope file的な考え方をどう一般化できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [li2026-rf-a-new-role-for-relevance-guiding-corpus-interaction-in-agentic-f6085e75.md](../../chat/2026-08-01/li2026-rf-a-new-role-for-relevance-guiding-corpus-interaction-in-agentic-f6085e75.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
