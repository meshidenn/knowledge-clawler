# Chat Prompt 2026-08-04

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Beyond relevance-centric retrieval: Rubric-oriented document set selection and ranking

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-04 - Beyond relevance-centric retrieval: Rubric-oriented document set selection and ranking

## 基本情報

- **タイトル**: Beyond relevance-centric retrieval: Rubric-oriented document set selection and ranking
- **著者**: Kailin Jiang, Lei Liu, Jian Xi, Hui Xu, Junlin Liu, Baochen Fu, Bin Li, Vichwang, Yu Lu, Haibo Shi
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.19747

## 落合陽一フォーマット

- **ひとことでいうと**: RAG/AI agent向け検索で、個別文書の関連度ではなく「文書集合として良いか」をrubricで評価・診断し、そのrubricをそのまま文書集合選択に使う論文。
- **先行研究と比べてどこがすごい？**: TREC-DL、BEIR、MTEB、RAGAS、ARESなどの文書単位評価やnDCG集約では見えない、冗長性・矛盾・補完性・完全性を評価対象にした点。SetwiseEvalKitは3階層・9次元の評価軸を持ち、約28Kのrubricで短文QAと長文research agentの両方を扱う。既存12 rerankerを診断し、最高でもoverall coverageが45%台に留まること、特にcross-document coordinationが弱いことを示している。
- **技術や手法の肝はどこ？**: クエリと参照回答からquery-specific rubricを生成し、文書集合全体を0〜4点で評価する。評価軸はDoc-levelのRelevance/Authenticity/Quality、Set-levelのComplementarity/Redundancy/Conflict、Global-levelのCompleteness/Density/Reachability。さらにRubric4Setwiseでは、rubricを評価基準に留めず、候補文書集合からrubric満足度が高い部分集合を選ぶtraining-freeな選択信号として使う。
- **どうやって有効だと検証した？**: Short-formではHotpotQA、2WikiMultihopQA、MuSiQue、Bamboogleから構成した2,061サンプル、Long-formではResearchQA 200サンプルとDR.Tulu-8Bのmulti-turn search trajectoryで評価。12 rerankerを比較し、rubric coverageと下流生成性能に強い相関があることを示した。Rubric4SetwiseはShort-formでEM 26.10、F1 29.32を達成し、平均2.66文書でSetR/Rank4Genを上回る。Long-formでもLLM-judge 70.57で最高、SetRより少ない文書数・検索round数で同等以上の性能を出している。
- **議論はある？**: 最大の制約はRubric4Setwiseが参照回答から生成したrubricを使うoracle設定であり、実運用では参照回答がない点。LLM-as-Judgeとrubric生成に強く依存するため、judge bias、モデル更新、rubric品質の再現性も論点になる。PDF本文では人手評価や二回評価の安定性を報告しているが、未知ドメイン・実Web検索ノイズ・商用検索環境で同じ傾向が保たれるかは追加検証が必要。
- **次に読む/試すなら**: 
  1. GitHub実装とSetwiseEvalKit datasetでrubric生成・評価プロンプトを確認する。
  2. 自分のRAG pipelineで「冗長性」「補完性」「到達可能性」だけを小さくrubric化してreranker比較する。
  3. 参照回答なしでrubricを生成する近似手法、またはrubric preferenceをreranker rewardに蒸留する方法を探す。
- **キーワード**: `RAG`, `document set selection`, `rubric-based evaluation`, `reranking`, `LLM-as-Judge`, `SetwiseEvalKit`, `Rubric4Setwise`

## 気になったこと

- 参照回答なしの実運用で、どのようにquery-specific rubricを作るのが現実的か。
- Rubric4Setwiseの計算コストが通常のrerankingやagent searchに対してどれくらい重いのか。
- Conflictスコアが全体的に高く出ているので、矛盾検出が本当に難しい設定で評価すると結果が変わるか。
- 「coverageが高い文書集合」と「最終回答が良い文書集合」の相関が、より大規模・異種な生成モデルでも維持されるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
