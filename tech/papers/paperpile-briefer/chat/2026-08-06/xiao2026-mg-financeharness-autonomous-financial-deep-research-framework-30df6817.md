# Chat Prompt 2026-08-06

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {FinanceHarness}: Autonomous financial deep research framework

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-06 - FinanceHarness: Autonomous financial deep research framework

## 基本情報

- **タイトル**: FinanceHarness: Autonomous financial deep research framework
- **著者**: Yijia Xiao, Rujun Han, Yanfei Chen, Zifeng Wang, Ke Jiang, Zhongying CuiZhu, Vishy Tirumalashetty, Wei Wang, Burak Gokturk, Tomas Pfister, Chen-Yu Lee
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.27853 / PDF: https://arxiv.org/pdf/2607.27853.pdf / arXiv:2607.27853

## 落合陽一フォーマット

- **ひとことでいうと**: 金融分野のdeep research agentを、未来情報の混入を防ぐPoint-in-Time検索環境で評価・実行・最適化するためのフレームワークとベンチマークを作った論文。
- **先行研究と比べてどこがすごい？**: 既存のdeep research benchmarkは汎用ドメインやlive web依存が多く、金融の「過去時点の情報だけで将来を見立てる」性質を十分に測れない。この論文はFinanceGymとして400問・2,464 rubric itemsの専門家検証済みベンチマークを作り、pre-cutoffの証拠取得とpost-cutoffの将来結果予測を分けて評価する。全システムが40%未満にとどまり、難しさも示している。
- **技術や手法の肝はどこ？**: 100M超の記事から出版日を抽出し、Qwen3-Embedding-4BとFAISSでPIT検索サンドボックスを構築する。そこから金融entity graphを作り、linkage、temporal narrative、divergenceといった状況を採掘し、cutoff date付きの投資 thesis・質問・pre/post rubricを生成する。FinanceHarness側は金融向けtool、API、agent loop、reward modelingを同じPIT契約の上で動かす。
- **どうやって有効だと検証した？**: PDF本文によれば、FinanceGymで17 baselineとFinanceHarnessを比較し、leading LLM/agentでもoverall rubric scoreは40%未満。固定backboneの比較では、Qwen3.6-27B search-tool modelが25.3%、full FinanceHarnessが32.4%まで改善し、GRPOによるRFTはさらに0.4 point程度の追加改善。専門家validationは82% pass rate。別途、3 backboneでcoverage suiteを走らせ、tool routingやgroundingも評価している。
- **議論はある？**: PIT環境は強いが、corpusは2025年の英語web corpus中心で、非英語、paywall、構造化filingのcoverageは限定的。live web用に訓練されたagentをPIT retrieverで評価しているため、tool-distribution shiftの影響が大きい。post-cutoff reasoningは依然として低く、検索性能だけでは金融リサーチの将来判断は解けない。
- **次に読む/試すなら**: FinanceHarnessのGitHub実装を確認する。FinanceGymのrubric形式を自分の金融/企業調査agent評価に流用できるか見る。PIT検索環境を小規模corpusで再現し、pre-cutoff evidenceとpost-cutoff outcomeを分けた評価を試す。
- **キーワード**: `financial deep research`, `agent harness`, `point-in-time evaluation`, `FinanceGym`, `FinanceHarness`, `rubric evaluation`, `retrieval-augmented generation`

## 気になったこと

- 100M超web corpusと公開benchmarkの関係がどこまで再現可能か。
- post-cutoff rubricを作る際、将来結果の「正解」をどの程度客観的に定義できるのか。
- 金融実務で重要なSEC filings、決算call transcript、有料データを入れた場合に性能差がどう変わるか。
- FinanceHarnessの改善がtool設計、workflow、prompt、reward modelingのどこに最も依存しているか。
- 投資助言・予測用途に近いagent評価として、リスク管理やcompliance面の設計が十分か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
