# Paperpile Brief 2026-08-04 - $\Sigma$-Mem: An online reliability memory for {LLM}-based multi-agent systems

## 基本情報

- **タイトル**: $\Sigma$-Mem: An online reliability memory for {LLM}-based multi-agent systems
- **著者**: Peilin Feng, Suorong Yang, Soujanya Poria
- **年 / venue**: 2026 / arXiv [cs.MA]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMベースのmulti-agent systemで、各agentやagent間関係の信頼性をオンラインに記憶・更新し、協調判断に使うための$\Sigma$-Memを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のmemory systemが主に対話内容を保存するのに対し、この研究は「どのagentを、どの条件で信頼できるか」を明示的に記憶する点が差分。central modelがpeer responseを直接検証しにくいmulti-agent環境で、信頼性そのものを再利用可能なmemoryとして扱う。
- **技術や手法の肝はどこ？**: 個々のpeerのcompetence evidenceと、peer集合内のrelationship evidenceをreal symmetric stateとして保持し、post-decision correctness feedbackからイベント単位で更新する。Weyl's inequalityにより各更新によるspectral changeをboundedにし、基盤モデルを再学習せず安定にオンライン適応できる設計にしている。
- **どうやって有効だと検証した？**: abstractベースでは、5つのQwen-family modelsで評価し、counterfactual reliability shifts、unseen peers、unseen task domainsへの適応・汎化を検証している。direct memory readoutはmajority votingやbest fixed peerをOOD評価全体で上回ったとされる。PDF本文がないため、具体的なdataset、metric、数値差、baseline詳細はメタデータからは不明。
- **議論はある？**: correctness feedbackが得られることを前提にしており、そのfeedbackが遅延・ノイズ付き・部分観測の場合にどこまで頑健かはメタデータからは不明。real symmetric stateやspectral boundが実運用上の信頼性推定にどの程度効いているか、ablationの有無もPDFなしでは確認できない。
- **次に読む/試すなら**: $\Sigma$-Memのwrite/read interfaceの具体式を確認する。response-free peer routingとreliability-weighted votingを小さなmulti-agent QA環境で再現する。feedbackが誤っている場合の劣化を試す。
- **キーワード**: `LLM agents`, `multi-agent systems`, `reliability memory`, `online adaptation`, `peer routing`, `weighted voting`

## 気になったこと

- correctness feedbackを誰が、どのタイミングで、どれくらい信頼できる形で与える想定なのか。
- peer relationship evidenceが「相関した間違い」や「同じ情報源への依存」をどの程度捉えられるのか。
- majority votingを上回る条件と、逆に単純なvotingで十分な条件の境界。
- unseen peersへのgeneralizationが、モデルfamily内の近さに依存していないか。
- 実装時には、memory stateのサイズ、更新コスト、長期運用でのforgetting設計を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [feng2026-us-sigma-mem-an-online-reliability-memory-for-llm-based-multi-a-65d21066.md](../../chat/2026-08-04/feng2026-us-sigma-mem-an-online-reliability-memory-for-llm-based-multi-a-65d21066.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
