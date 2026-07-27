# Chat Prompt 2026-07-28

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {FinanceComplexQA}: Benchmarking agentic reasoning on industrial-grade financial documents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-28 - FinanceComplexQA: Benchmarking Agentic Reasoning on Industrial-grade Financial Documents

## 基本情報

- **タイトル**: FinanceComplexQA: Benchmarking agentic reasoning on industrial-grade financial documents
- **著者**: Xianfu Cheng, Shiwei Zhang, Jiyu Zhao, Jian Yang, Xinyuan Wang, Ming Zhou, Weixiao Zhou, Xiangyuan Guan, Xiang Li, Zhenhe Wu, Ziyi Ni, Zhoujun Li, Bingjing Xu
- **年 / venue**: 2026 / arXiv [cs.CE]
- **リンク**: https://arxiv.org/pdf/2607.19238

## 落合陽一フォーマット

- **ひとことでいうと**: 金融文書に対するAgentic Reasoning能力を、長文・表・レイアウト・数値計算・専門知識を含む実務寄りQAで測るベンチマーク FinanceComplexQA を提案した論文。
- **先行研究と比べてどこがすごい？**: FinQAやFinanceBenchなど既存ベンチマークが短文、表QA、単一文書、限定タスクに寄りがちな一方、本研究は1,009文書・2,026 deep research tasksで、英中バイリンガル、cross-layout reasoning、open-ended回答、Agent-as-a-Judge評価をまとめて扱う点が新しい。
- **技術や手法の肝はどこ？**: Finance-LaTeX SKILLにより、専門知識・証拠計画・LaTeXレイアウト生成・QA生成・多段検証を組み合わせ、金融文書とQAをスケール生成する。評価側では、明示的な文書証拠と暗黙の金融ドメイン知識を統合する「dual-context reasoning」と、段落・表・注記・レイアウトをまたぐ証拠統合を重視している。
- **どうやって有効だと検証した？**: 主要なRAG/MCP系システム2種とagentic reasoning系システム2種をFinanceComplexQAで評価し、ACC、ROU、Faithfulness、Coverageなど複数指標で比較した。結果として、現在のシステムは数値の期間・単位・符号の取り違え、証拠の取りこぼし、表ヘッダや注記の誤解、過剰な業界推論、計画の弱さに苦戦することを示した。
- **議論はある？**: ライブ取引、リアルタイム市場予測、個別投資助言は対象外。対応言語は中国語と英語中心。Agent-as-a-Judgeはスケールするが評価器バイアスを含み得るため、人手較正やadversarial judge checksが今後必要。PDF抽出テキスト上では細かな表の数値は崩れている可能性があるため、数値結果の厳密比較は原PDF確認が必要。
- **次に読む/試すなら**: FinanceComplexQAのデータ公開状況を確認する。自前RAGで表ヘッダ・caption・footnoteを保持するindexingを試す。数値QAに対して「証拠抽出→計算検証→回答生成」の最小agent loopを組む。
- **キーワード**: `FinanceComplexQA`, `financial QA`, `agentic reasoning`, `RAG`, `cross-layout reasoning`, `Agent-as-a-Judge`

## 気になったこと

- Finance-LaTeX SKILLで生成した2,000文書・6,000 QAは開発用で、held-out benchmarkには混ぜない設計だが、合成データと実文書評価の分布差がどの程度あるか確認したい。
- Agent-as-a-Judgeの評価プロンプト、judge model、human calibrationの詳細を見ないと、ACCやFaithfulnessの信頼性は判断しきれない。
- PageIndex系が強い場面とagentic systemが強い場面の分岐条件を、コスト-aware routingとして実装できそう。
- 関連して、FinanceBench、TAT-QA、DocFinQA、BizFinBench v2とのタスク設計差分を表単位で比較したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
