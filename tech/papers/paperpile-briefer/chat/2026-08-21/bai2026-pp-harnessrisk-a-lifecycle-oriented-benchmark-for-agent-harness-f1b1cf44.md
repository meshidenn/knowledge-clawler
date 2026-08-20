# Chat Prompt 2026-08-21

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {HarnessRisk}: A lifecycle-oriented benchmark for agent harness safety

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-21 - HarnessRisk: A Lifecycle-Oriented Benchmark for Agent Harness Safety

## 基本情報

- **タイトル**: HarnessRisk: A Lifecycle-Oriented Benchmark for Agent Harness Safety
- **著者**: Yajing Bai, Jinhao Duan, Jie Peng, Xianfeng Wu, Sijia Liu, Song Wang, Tianlong Chen
- **年 / venue**: 2026 / arXiv [cs.CR]（under review）
- **リンク**: [arXiv:2608.17597v1](https://arxiv.org/abs/2608.17597v1)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントの安全性を、モデル単体でなく「agent harness」のライフサイクル全体として測る128件のベンチマーク。
- **先行研究と比べてどこがすごい？**: prompt injectionや危険なtool useに偏りがちな既存評価に対し、設定・拡張機能・実行時・永続状態・行動制御・事故復旧の6段階を統一的に扱う。同一モデルでもharnessにより攻撃成功率が4倍超変わり、安全性はモデル固有ではないことを示した。
- **技術や手法の肝はどこ？**: 各ケースは正当な利用者タスクと、信頼できない成果物に埋め込まれた敵対的指示を組にする。Utility、Attack Success Rate（ASR）、Persistence、Detectionを独立に測り、「役に立ったが侵害された」実行を見逃さない設計である。
- **どうやって有効だと検証した？**: OpenClaw、Nanobot、Hermesの3 harnessと6モデル、計14構成を各3 seedで評価した。ASRは12.6–80.9%、Utilityは75.0–97.6%であり、高い有用性と高い攻撃成功が共存した。GPT-5.4による軌跡評価は、Utility/ASRで決定的判定と89.7–92.5%一致し、Persistence/Detectionでも人手注釈と84.3–85.7%一致した。
- **議論はある？**: 実験は合成資産・mock service・外部ネットワーク無効のsandboxに限られ、実運用の攻撃面を完全には再現しない。評価器も完全ではなく、特にPersistenceとDetectionは意味的判定を含む。また、harnessごとに設定条件が同一とは限らず、因果的にどの設計差が安全性を生むかは未検証である。
- **次に読む/試すなら**:
  1. 自分のagentで、設定変更・plugin導入・memory書込みを別々の承認境界として実装する。
  2. 「検知したのに実行した」軌跡を収集し、検知をaction blockingへ接続する。
  3. HarnessRiskのケースを自前のtool・権限・永続メモリ構成に移植して回帰テスト化する。
- **キーワード**: `agent harness`, `agent security`, `prompt injection`, `persistent memory`, `tool authorization`, `benchmark`

## 気になったこと

- Harness Configurationが全harnessで最も脆弱だったが、具体的にどの設定項目・権限モデルがASRを押し上げたのかをケース単位で確認したい。
- Detectionが高くてもASRが残るため、検知結果がpolicy enforcementやtool-call拒否へ確実に伝播する設計かを調べたい。
- sandbox外の実サービス、長期運用メモリ、複数エージェント連携で同じ傾向が維持されるかは未検証である。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
