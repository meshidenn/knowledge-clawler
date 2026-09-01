# Paperpile Brief 2026-09-02 - {SKILL}.State: Scalable long-horizon agent skills

## 基本情報

- **タイトル**: {SKILL}.State: Scalable long-horizon agent skills
- **著者**: Sanket Badhe, Priyanka Tiwari, Jonghyun Chung
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: メタデータに DOI・arXiv ID・URL の記載なし

## 落合陽一フォーマット

- **ひとことでいうと**: 長期実行エージェントの会話履歴を伸ばし続ける代わりに、明示的で更新可能な実行状態を使うランタイム設計を提案した論文。
- **先行研究と比べてどこがすごい？**: append-only な会話履歴によるコンテキスト肥大化、遅延、過去文脈による誤動作を避ける。モデルや実行環境に依存しない抽象化として、精度向上と累積トークン消費の削減を主張する。
- **技術や手法の肝はどこ？**: 各ステップでモデルに渡すのを「不変なスキル仕様」「現在の構造化実行状態」「最新の観測」のみに限定する。中間推論は状態更新を生成・検証した直後に破棄し、履歴長に比例してプロンプトが増えないようにする。
- **どうやって有効だと検証した？**: 多様なデータセット、モデル、実行環境で、タスク精度と累積トークン消費を比較したとabstractは述べる。具体的なベンチマーク、比較手法、数値はメタデータからは不明。
- **議論はある？**: PDF本文が取得できておらず、要約はabstractベースである。状態表現の設計・検証器の信頼性、破棄した中間推論が必要になる失敗例、複雑な分岐や長期記憶との両立はメタデータからは不明。
- **次に読む/試すなら**: 1. 状態スキーマと更新検証の具体例を本文で確認する。 2. 履歴保持型エージェントとの精度・レイテンシ・コスト比較を最小実験で再現する。 3. structured state と長期記憶・ツール実行ログの役割分担を検討する。
- **キーワード**: `LLM agents`, `long-horizon execution`, `structured state`, `context management`, `token efficiency`

## 気になったこと

- 状態更新の「validated」が、型検査・ルール検証・別モデルによる検証のどれを指すのか。
- 中間推論を破棄しても、デバッグ・監査・失敗回復に必要な情報をどう保持するのか。
- 状態そのものが肥大化するタスクに対し、圧縮・要約・永続化をどう設計するのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [badhe2026-un-skill-state-scalable-long-horizon-agent-skills-491ddc20.md](../../chat/2026-09-02/badhe2026-un-skill-state-scalable-long-horizon-agent-skills-491ddc20.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
