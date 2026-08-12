# Paperpile Brief 2026-08-13 - Factorized Hypothesis Search for evidence-to-taxonomy retrieval

## 基本情報

- **タイトル**: Factorized Hypothesis Search for evidence-to-taxonomy retrieval
- **著者**: Linhai Ma, Ethan F. Wei, Xueqing Peng, Yan Wang, Lingfei Qian, Víctor Gutiérrez-Basulto
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2608.06614 / PDF: https://arxiv.org/pdf/2608.06614.pdf / arXiv:2608.06614

## 落合陽一フォーマット

- **ひとことでいうと**: 表セルや臨床記述のような「そのままでは検索クエリにならない証拠」から、大規模taxonomy上の正しい概念を引くために、複数の構造化仮説を並列に作って検索・検証するFHSを提案した論文。

- **先行研究と比べてどこがすごい？**: HyDEやQuery2Doc的な単一クエリ書き換えではなく、入力の意味自体が曖昧な状況を「retrieval readiness gap」と定式化している点が肝。Financial TaggingではFHSがRecall@1 0.185、MRR 0.257、最終Accuracy 0.255で非oracle手法中トップ。CodiEspでもRecall@1 0.264、MRR 0.352、Accuracy 0.330でトップ。深いRecallでは反復型が勝つ場合もあるが、最終判断に効くhead rankingではFHSが強い。

- **技術や手法の肝はどこ？**: 入力factを直接クエリにせず、Family、Role、Event、Qualifier、Scope、Temporalなどの意味次元に分解した複数の部分仮説として表現する。未確定次元は無理に埋めず空にする。各仮説から、LLM生成のdefinition-form queryと、解決済み次元を規則的に並べたlabel-form queryを作り、複数検索結果をRRFで融合する。その後、候補ごと・次元ごとにLLM verifierがsupport / no support / abstainを返し、既存候補プール内の順位を再調整する。

- **どうやって有効だと検証した？**: 2024 US-GAAP taxonomyを使うFinancial Taggingと、CodiEsp diagnosis codingで評価。全手法は同じBM25 index、Qwen3-32B backbone、downstream listwise selectorを共有。指標は検索段階のRecall@1/10/50、MRR、selector後のtop-1 accuracy。Ablationでは、factorized pathをfree-text ensembleに置き換えるとFinancial TaggingのRecall@1が0.185から0.116、MRRが0.257から0.194へ低下。LLM verifierを外すとRecall@1が0.124、MRRが0.205に落ちる。

- **議論はある？**: FHSは候補プールを広げるより、既に届いている候補をheadに上げる設計。Financial TaggingではFeedback refineのRecall@50が0.660でFHSの0.543より高いので、深いcoverageでは反復型に利がある場合がある。またfree-text ensembleとの差分はfactorization単独ではなく、dimension-level verificationも同時に失う比較なので、寄与分解には注意が必要。Qwen3-32Bとタスク固有dimension設計への依存、taxonomyごとの語彙・profile設計コストも実運用上の論点。

- **次に読む/試すなら**: 
  1. GitHub実装 https://github.com/SarielMa/FHS を確認し、dimension schemaとverifier promptを読む。
  2. 自分のtaxonomy retrievalタスクで「raw evidence検索」と「gold label+definition検索」の差を測り、retrieval readiness gapが本当にあるか診断する。
  3. free-text query ensemble、single structured hypothesis、FHSの3条件だけで最小ablationを再現する。

- **キーワード**: `evidence-to-taxonomy retrieval`, `Factorized Hypothesis Search`, `taxonomy tagging`, `query rewriting`, `candidate verification`, `RRF`, `BM25`, `semantic dimensions`

## 気になったこと

- dimension schemaは金融・臨床以外のtaxonomyにどれくらい移植しやすいのか。
- verifierが「候補プール外」を救えない設計なので、dense retrievalやhybrid retrievalと組み合わせた場合に改善幅が変わるか。
- Qwen3-32B以外の小型モデルで、仮説生成とdimension-level verificationがどこまで保つか。
- sequential refinementが効かなかった理由が、タスク性質なのか実装・prompt設計なのか追加検証したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [ma2026-ne-factorized-hypothesis-search-for-evidence-to-taxonomy-retrieva-c9cc38da.md](../../chat/2026-08-13/ma2026-ne-factorized-hypothesis-search-for-evidence-to-taxonomy-retrieva-c9cc38da.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
