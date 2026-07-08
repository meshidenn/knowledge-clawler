# Paperpile Brief 2026-07-09 - SkillHone: A harness for continual agent skill evolution through persistent decision history

## 基本情報

- **タイトル**: SkillHone: A Harness for Continual Agent Skill Evolution Through Persistent Decision History
- **著者**: Zhiwei Li, Yong Hu
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2606.08671

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agent の「skill」を単発で最適化して終わりにせず、診断・修正・評価証拠・採否判断を永続的に残しながら継続進化させるための harness「SkillHone」を提案した論文。
- **先行研究と比べてどこがすごい？**: Skill-Creator や Hermes-SE/GEPA 系のように最終成果物だけを残すのではなく、「なぜその修正をしたか」「何を試して捨てたか」「どの評価証拠で判断したか」を履歴として残す点が新規性。GAIA で平均 64.6、WebWalkerQA-EN で平均 66.4 を報告し、比較対象の Hermes-SE や商用 retrieval 付き deep-research agent を上回ったとしている。
- **技術や手法の肝はどこ？**: skill repository と skill-evaluation repository を分け、optimization 側 agent は redacted report と過去の decision history だけを見て修正し、evaluation 側 agent は probe・validator・trace を使って候補 skill を評価する。各ステップを `(diagnosis, revision, evidence, outcome)` の decision record として保存し、後続 agent が過去の失敗・却下案・根拠を再利用できるようにする。
- **どうやって有効だと検証した？**: deep-research 系の GAIA と WebWalkerQA-EN で、Existing-Skills、Skill-Creator、Hermes-SE、商用 retrieval 付き deep-research agent と比較。さらに別 backbone への transfer と、社内の tool-mediated analysis 7シナリオでの deployment study を実施し、平均 +18.8 points の改善を報告している。
- **議論はある？**: 現状は単一 skill の進化が対象で、複数 skill が相互依存する場合の共同進化は未解決。社内 deployment study は詳細データや再現環境が限定的で、評価セットや人手検証の妥当性は外部から確認しにくい。PDF抽出上、細かい数値や表の一部はレイアウト崩れの可能性があるため、厳密なスコア確認には原PDF参照が必要。
- **次に読む/試すなら**: SkillHone の GitHub 実装を確認する。自分の既存 skill に issue/PR/wiki 形式の decision history を導入してみる。Hermes-SE/GEPA との違いを、同じ小さな probe set で再現実験する。
- **キーワード**: `agent skills`, `continual skill evolution`, `persistent decision history`, `LLM agents`, `redacted evaluation`, `deep research`

## 気になったこと

- decision history の粒度をどこまで細かくすると、後続 agent にとって本当に有用になるのか。
- redacted report が薄すぎると修正不能、濃すぎると評価 leak になるが、その境界をどう運用するのか。
- GitHub issue/PR/wiki で実装する場合、履歴検索・重複診断・古い判断の失効をどう扱うのか。
- 複数 skill が共有 script や共通 reference に依存する場合、単一 skill 前提の設計をどう拡張するのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [li2026-ev-skillhone-a-harness-for-continual-agent-skill-evolution-throug-1abebb35.md](../../chat/2026-07-09/li2026-ev-skillhone-a-harness-for-continual-agent-skill-evolution-throug-1abebb35.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
