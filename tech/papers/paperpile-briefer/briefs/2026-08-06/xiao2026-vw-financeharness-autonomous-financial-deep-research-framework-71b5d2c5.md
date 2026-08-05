# Paperpile Brief 2026-08-06 - FinanceHarness: Autonomous Financial Deep Research Framework

## 基本情報

- **タイトル**: FinanceHarness: Autonomous Financial Deep Research Framework
- **著者**: Yijia Xiao, Rujun Han, Yanfei Chen, Zifeng Wang, Ke Jiang, Zhongying CuiZhu, Vishy Tirumalashetty, Wei Wang, Burak Gokturk, Tomas Pfister, Chen-Yu Lee
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.27853 / arXiv:2607.27853

## 落合陽一フォーマット

- **ひとことでいうと**: 金融領域のdeep research agentを、point-in-time制約つき検索環境、専門家検証済みベンチマーク、実行ハーネス、報酬設計まで一体で構築した論文。
- **先行研究と比べてどこがすごい？**: 既存のdeep research benchmarkは汎用・live web・単一スナップショット中心で、金融レポートに必要な「ある時点までの情報だけで調べ、後日の結果で検証する」構造を十分に扱えない。本論文はFinanceGymとして400問・2,464 rubric itemの専門家検証済み金融deep research benchmarkを作り、pre-cutoff evidence retrievalとpost-cutoff outcome anticipationを分離して評価する点が新しい。
- **技術や手法の肝はどこ？**: 100M超の記事から出版日つき金融web corpusを作り、FAISSとQwen3-Embedding-4BでPIT検索sandboxを構築する。そこからGemini-3.5-Flashで金融entity-relation graphを作り、multihop linkage、temporal narrative、polar divergenceなどの「金融アナリストが問いを立てる状況」をmineする。各questionにはcutoff date、投資thesis、pre-cutoff/post-cutoff rubricを付け、FinanceHarnessがツール実行・ワークフロー・評価・RFTを同じ環境契約で回す。
- **どうやって有効だと検証した？**: FinanceGymで17種類のLLM/agent baselineとFinanceHarnessを比較。すべてのシステムがoverall 40%未満にとどまり、benchmarkの難しさを示した。同じopen-weight backboneでは、Qwen3.6-27Bのsearch-tool modelが25.3%、FinanceHarnessが32.4%まで改善し、GRPOによるRFTはさらに0.4 point程度の追加改善に留まった。専門家validationでは82% pass rateとされる。
- **議論はある？**: corpusは2025年の英語web corpus中心で、非英語情報、paywall付き専門データ、構造化filingのcoverageは限定的。live-web前提で訓練されたagentをPIT retrieverで評価しているため、tool-distribution shiftの影響がある。pre-cutoff性能は伸びやすい一方、post-cutoff reasoningは低く残り、検索性能だけでは金融予測的判断は解けないことを示している。
- **次に読む/試すなら**: FinanceHarnessのGitHub実装を確認する。FinanceGymのrubric設計を、自分の金融・市場調査タスクに流用できるか見る。PIT制約つきRAG評価を、金融以外の時系列ドメインにも移植できるか試す。
- **キーワード**: `financial deep research`, `agent harness`, `point-in-time evaluation`, `FinanceGym`, `RAG`, `rubric evaluation`, `financial NLP`

## 気になったこと

- PIT sandboxの元corpusが公開されない場合、FinanceGymの完全再現性はどこまで担保されるのか。
- post-cutoff rubricは「未来を当てる能力」と「妥当な投資仮説を構成する能力」をどの程度分離できているのか。
- 金融専門データ、SEC filings、earnings call transcript、価格時系列を入れた場合に、FinanceHarnessの改善幅が変わるか。
- GRPOの追加効果が小さい理由は、報酬設計の限界なのか、benchmarkの難しさなのか、backbone容量の問題なのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [xiao2026-vw-financeharness-autonomous-financial-deep-research-framework-71b5d2c5.md](../../chat/2026-08-06/xiao2026-vw-financeharness-autonomous-financial-deep-research-framework-71b5d2c5.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
