# Paperpile Brief 2026-07-30 - TRACE: Business rule-grounded reasoning curriculum for knowledge-preserving parametric Tool Retrieval in enterprise LLMs

## 基本情報

- **タイトル**: TRACE: Business rule-grounded reasoning curriculum for knowledge-preserving parametric Tool Retrieval in enterprise LLMs
- **著者**: Sai Shruthi Sistla, Ashutosh Hathidara, Christopher Toukmaji, Mayank Shrivastava, Karthikeyan Asokkumar
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.22639 / PDF: https://arxiv.org/pdf/2607.22639.pdf / arXiv: 2607.22639

## 落合陽一フォーマット

- **ひとことでいうと**: 企業内LLMが大量のAPI/tool catalogから正しいtoolを選ぶために、tool tokenの記憶を壊さず、business ruleに基づいて推論してretrieveする2段階学習カリキュラム TRACE を提案した論文。
- **先行研究と比べてどこがすごい？**: ToolGen/ToolSense系のparametric tool retrievalは、toolをvirtual tokenとして生成できる一方で、retrieval訓練によりtool知識が壊れることと、constrained beam searchが遅いことが問題だった。TRACEはStage 1でtool知識をLoRA SFTで埋め込み、Stage 2でreasoning trace付きretrievalを学習することで、知識保持とsingle-beam greedy decodingによる低遅延を両立しようとしている。
- **技術や手法の肝はどこ？**: Stage 2で、回答としてtool tokenのJSON listを出す前に、候補tool、権限、API/endpointの違い、business ruleを辿るthinking traceを出させる点が中心。さらに、domain expertが作った123件のbusiness ruleを使い、明示的・暗黙的・例外ケースのqueryを合成し、trace内のtool名をvirtual tokenに置換して、tool説明とtokenの結びつきを再強化している。
- **どうやって有効だと検証した？**: 2つのenterprise domainにまたがる8,283個のtool catalogで評価。Production Retrieval Benchmark、ToolSense由来のMCQ/QA probing、domain expert作成のMCQ expertで比較している。本文では、TRACEがDomain Aで約86%、Domain Bで約60%のretrieval recallを出し、embedding baselineの約27%/52%を上回ると報告している。またStage 2後もMCQ accuracyがStage 1比で+3.2 pp、QA probingが+9 pp改善したとされる。
- **議論はある？**: business ruleはdomain expert curatedであり、rule作成コストと更新運用が大きな前提。評価対象もproprietary enterprise tool catalogなので、外部再現性は限定的。rule-grounded dataを増やすとretrievalは改善する一方、held-out MCQ expertが下がる傾向もあり、rule特化と汎用tool理解のトレードオフがある。数値はPDF抽出テキストに基づくが、表の細部は抽出崩れがあり得るため断定しすぎない。
- **次に読む/試すなら**: ToolGenとToolSenseを読んでparametric tool retrievalの前提を確認する。小さな社内API catalogでvirtual token + trace付きSFTの最小実験を作る。business rule catalogをどう継続更新するか、RAG/metadata filterとのhybrid設計を検討する。
- **キーワード**: `parametric retrieval`, `tool retrieval`, `enterprise LLM`, `business rules`, `reasoning trace`, `LoRA`, `constrained decoding`, `catastrophic forgetting`

## 気になったこと

- business ruleを人手で123件作る前提は強く、rule driftやAPI deprecationへの追従をどう自動化するか。
- thinking traceを生成する方式はproduction latencyを満たすとされるが、trace長とtool数増加に対する実測latencyの詳細を確認したい。
- 「知識保持」の評価がMCQ/QA probing中心なので、実際のmulti-step agent workflowで下流性能がどれだけ改善するかを見たい。
- proprietary catalog評価のため、公開benchmarkでどこまで再現できるかが不明。
- traceにbusiness ruleを引用させる設計は有効そうだが、誤ったrule引用や古いruleの混入時のfailure modeが気になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [sistla2026-hl-trace-business-rule-grounded-reasoning-curriculum-for-know-53edece9.md](../../chat/2026-07-30/sistla2026-hl-trace-business-rule-grounded-reasoning-curriculum-for-know-53edece9.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
