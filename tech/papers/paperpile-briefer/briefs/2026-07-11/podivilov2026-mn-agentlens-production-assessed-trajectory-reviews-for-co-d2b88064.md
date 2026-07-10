# Paperpile Brief 2026-07-11 - AgentLens: Production-assessed trajectory reviews for coding agent evaluation

## 基本情報

- **タイトル**: AgentLens: Production-assessed trajectory reviews for coding agent evaluation
- **著者**: Andrey Podivilov, Vadim Lomshakov, Sergey Savin, Matvei Startsev, Roman Pozharskiy, Maksim Parshin, Sergey Nikolenko
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.06624 / PDF: https://arxiv.org/pdf/2607.06624.pdf / code: https://github.com/agent-lens/agent-lens-bench

## 落合陽一フォーマット

- **ひとことでいうと**: Coding agentを最終的なpass/failだけでなく、ユーザーとの対話、tool call、編集、検証、失敗回復、最終回答まで含む「trajectory」全体で評価するベンチマーク AgentLens を提案した論文。
- **先行研究と比べてどこがすごい？**: SWE-benchやTerminal-Benchのような最終状態・テスト通過中心の評価に対し、AgentLensは実運用で見える品質を評価対象にする。形式検証に加えて、LLM judgeによる文章レビュー、side-by-side比較、nightly regression検出まで含め、ランキングだけでなく「なぜ悪い/良いのか」の診断に寄せている。
- **技術や手法の肝はどこ？**: trajectoryを主評価単位にし、ENDRESULT、INSTRUCTIONCOMPLIANCE、PITFALLS、PLEASANTNESS、TOOLCALLSの5軸でLLM judgeがスコアと根拠付きレビューを生成する点。さらに、テスト実行、regex、repository state、static analysisなどのformal verifierを組み合わせ、客観チェックと人間が体験する品質の両方を見る。
- **どうやって有効だと検証した？**: 初期foldは16のcoding agent scenarioをdefault/toxicの2 personaで走らせ、各agentあたり32 trajectoriesを評価する。実験では複数モデルのleaderboard、Gemini 3.1 Pro Previewの詳細レポート、Kimi K2.6のOpenRouter tool parser問題、parallel tool calling regressionの検出例、Artificial Analysis系ベンチマークとのSpearman相関を示している。QIはAPEX-Agents-AAとは高相関だが、IFBenchやτ2-Bench Telecomとは負相関で、既存指標と異なる軸を測っていると主張している。
- **議論はある？**: 現在の公開releaseはJava-onlyで、一般知能ではなく特定のcoding-agent作業を測る。LLM judgeの妥当性は内部の小規模な非公式annotation経験に依存しており、正式なhuman agreement studyは未実施。OpenRouterなど第三者provider経由のモデルではlatency、routing、versioningが混入し、1 runが高コストになる場合もある。自社coding assistant向けに作られたため、中立性にも追加検証が必要。
- **次に読む/試すなら**: 1. GitHub repoでtask/verifier/agent interfaceの実装を見る。 2. 自分のcoding agentに対して最小のtrajectory loggingを作り、ENDRESULTとTOOLCALLSだけで小さく再現する。 3. LLM judgeのhuman agreementを測る小規模annotation実験を設計する。
- **キーワード**: `coding agent evaluation`, `trajectory review`, `LLM-as-judge`, `formal verification`, `agent benchmark`, `regression testing`

## 気になったこと

- LLM judgeのrubricとpromptが、モデル間比較でどれくらいjudge biasを持つのか。
- 32 trajectoriesという小さめのfoldで、どの程度まで安定したプロダクト判断ができるのか。
- Java以外、特にPython/TypeScript/CLI-heavy taskに移したとき、verifier設計がどれくらい再利用できるのか。
- AgentLensのQIが「良いcoding assistant体験」を測るとして、ユーザー満足度や実タスク完了時間との外的妥当性はまだ確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [podivilov2026-mn-agentlens-production-assessed-trajectory-reviews-for-co-d2b88064.md](../../chat/2026-07-11/podivilov2026-mn-agentlens-production-assessed-trajectory-reviews-for-co-d2b88064.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
