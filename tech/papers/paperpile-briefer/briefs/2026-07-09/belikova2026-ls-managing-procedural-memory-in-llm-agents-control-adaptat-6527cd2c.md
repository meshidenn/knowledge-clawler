# Paperpile Brief 2026-07-09 - Managing procedural memory in LLM agents: Control, adaptation, and evaluation

## 基本情報

- **タイトル**: Managing procedural memory in LLM agents: Control, adaptation, and evaluation
- **著者**: Julia Belikova, Rauf Parchiev, Evgeny Egorov, Grigorii Davydenko, Gleb Gusev, Andrey Savchenko, Maksim Makarenko
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2606.23127 / PDF: https://arxiv.org/pdf/2606.23127.pdf / arXiv: 2606.23127

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agentのprocedural memoryが、特定タスク内の改善だけでなく、タスク・職種・モデルをまたいで再利用可能な「スキル」になるかを測るため、AFTERという企業実務タスクベンチマークと評価プロトコルを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のagent benchmarkはタスク成功率中心で、memoryが別文脈へtransferするかを分離して測りにくい。本論文は382個の実務タスク、6職種、22 procedural skills、cross-task / cross-role / cross-model splitを用意し、local improvementとgeneralizationを明示的に分けて評価している。
- **技術や手法の肝はどこ？**: procedural memoryを`SKILL.md`のようなversionable artifactとして扱い、実行traceからCOLLECT–DIAGNOSE–REVISE–PROMOTEの流れで更新する。評価ではsource contextでのspecificity gainと、held-out task・role・modelでのgenerality gainを分け、狭い経験からの過適応と、多様な経験からの汎化を比較する。
- **どうやって有効だと検証した？**: AFTER上で、no skill、handcrafted skill、LLM-generated skill、さらに1回のrefinementやtrace-based evolutionを比較。PDF本文によれば、static skillは平均でfull-pass accuracyを約+2.8ポイント改善し、1回のrefinementでさらに平均+5.2ポイント程度改善。多様なmulti-model traceから進化したskillはcross-model test accuracy 73.1%を達成し、単一モデルtrace由来のskillを上回った。
- **議論はある？**: skillは広く汎化するものと、職種固有workflowに特化してtransferで効かなくなるものがある。タスクの多くは著者作成またはLLM生成であり、実企業環境での外的妥当性は追加確認が必要。PDF抽出上、細かな表の数値やモデル名には崩れがあるため、定量値は原PDFで再確認したい。
- **次に読む/試すなら**: AFTER datasetを確認して、自分のagent環境で`SKILL.md`形式のmemory評価を再現する。狭いtraceだけでskill更新した場合と、多様なモデル・タスクtraceを混ぜた場合の差を小規模に検証する。role-specific adapterとshared skill bodyを分ける設計を試す。
- **キーワード**: `procedural memory`, `LLM agents`, `skill transfer`, `AFTER benchmark`, `agent evaluation`, `cross-model generalization`

## 気になったこと

- AFTERの382タスクがどの程度、本物の企業内workflowを代表しているか。
- skill annotationを固定しているため、retrieval失敗を切り離せる一方、実運用の「どのskillを呼ぶか」問題は別途評価が必要。
- cross-role transferで失敗するskillは、bodyを汎用化すべきか、role adapterで分けるべきか。
- 多様なtraceが効く理由が、単にcoverage増加なのか、model固有の癖を平均化できるからなのかを切り分けたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [belikova2026-ls-managing-procedural-memory-in-llm-agents-control-adaptat-6527cd2c.md](../../chat/2026-07-09/belikova2026-ls-managing-procedural-memory-in-llm-agents-control-adaptat-6527cd2c.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
