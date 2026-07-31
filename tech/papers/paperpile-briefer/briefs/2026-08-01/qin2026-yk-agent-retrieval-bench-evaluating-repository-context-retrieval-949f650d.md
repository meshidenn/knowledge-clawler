# Paperpile Brief 2026-08-01 - Agent Retrieval Bench: Evaluating repository context retrieval for coding agents

## 基本情報

- **タイトル**: Agent Retrieval Bench: Evaluating repository context retrieval for coding agents
- **著者**: Bowen Qin, Yi Xie
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: https://arxiv.org/abs/2607.24882v1 / arXiv:2607.24882v1

## 落合陽一フォーマット

- **ひとことでいうと**: coding agentがパッチを書く前に「どのrepository fileを読むべきか」を評価するための、file-level retrieval benchmarkを提案した論文。
- **先行研究と比べてどこがすごい？**: SWE-benchのようなend-to-end patch成功率ではなく、その前段のcontext acquisitionを切り出して評価する点が新しい。CodeSearchNet的なsemantic code searchではなく、PR、review comment、failure trace、anchored editなど実際の開発workflow由来のqueryから「次に読むべきfile」を測る。base commit固定、gold pathやpatchなどのleakage除去、no-gold/abstention評価も含めている。
- **技術や手法の肝はどこ？**: relevanceを「queryとfileの意味的類似」ではなく「agentが次の正しい作業に進むために読むべきrepository context」と定義している。taskは `code2test`, `comment2context`, `trace2code`, `edit2ripple` の4種類に分け、さらに自然なno-gold caseとwrong-repository controlでselective retrievalも評価する。
- **どうやって有効だと検証した？**: 25 repositories、427 samples、308 base-commit snapshots、約392K files、7.9M chunksのbenchmarkを構築。lexical retrieval、RepoMap、open-source embeddings、RRF hybrid、logged agent trajectory、closed-tool seed interventionを比較した。Qwen3-Embedding-4Bはpositive samplesのsample-weighted MRRで強く、Qwen3-Embedding-8BはRecall@20で強く、RepoMapは8K token budgetでのBCYが強い。一方でtaskごとに勝者が変わり、単一手法の優位はない。
- **議論はある？**: file-level hitは「そのfileに到達した」ことしか示さず、file内の正しいspan localizationまでは解けていない。selective abstentionでは、counterfactual controlを混ぜると良く見えるが、自然なno-gold caseではthreshold calibrationが崩れる。seed interventionもsingle-run pilotであり、patch successやrepair successを直接測ったものではない。
- **次に読む/試すなら**: 1. Agent Retrieval Benchのartifactとevaluation repositoryを確認する。2. 自分のcoding agentにRRF(Qwen3-8B + RepoMap)のようなsemantic + structural hybrid retrievalを試す。3. file-level retrieval後にspan-level localizationを改善するrerankerやchunk selectionを追加評価する。
- **キーワード**: `coding agents`, `repository retrieval`, `context acquisition`, `code search`, `benchmark`, `RepoMap`, `Qwen3-Embedding`, `selective retrieval`

## 気になったこと

- retrieval-derived seedがFile F1を改善しているが、実際のpatch successにどれだけ効くかは未検証。
- natural no-gold caseでabstention calibrationが失敗するなら、top score以外の不確実性推定やrepository-query compatibility modelが必要そう。
- file-level benchmarkとしては有用だが、実装支援に使うならspan-level evidence extractionと組み合わせないとcontext budgetを浪費しやすい。
- logged trajectoryでgold fileを一度も読まないsampleが27-35%ある点は、agentの探索戦略そのものの改善余地を示している。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [qin2026-yk-agent-retrieval-bench-evaluating-repository-context-retrieval-949f650d.md](../../chat/2026-08-01/qin2026-yk-agent-retrieval-bench-evaluating-repository-context-retrieval-949f650d.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
