# Paperpile Brief 2026-08-02 - Where teams and agents work together

## 基本情報

- **タイトル**: Where teams and agents work together
- **著者**: メタデータからは不明
- **年 / venue**: 年はメタデータからは不明 / Notion
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: Notion上で、会社の文脈を使いながらチームとAI agentが同じ作業空間で協働する、collaborative AI workspaceを紹介する資料。
- **先行研究と比べてどこがすごい？**: メタデータ上は研究論文ではなくNotionの紹介文に見えるため、先行研究との差分や定量的な新規性は不明。強調点は、agentをプロジェクト、会議、connected appsの近くで構築・オーケストレーションできる設計にある。
- **技術や手法の肝はどこ？**: 会社固有のcontextをAI agentに接続し、チームの作業空間内でagentを構築・運用する点。ただし、具体的なアーキテクチャ、RAG設計、権限管理、agent orchestrationの実装方式はメタデータからは不明。
- **どうやって有効だと検証した？**: PDF本文がなく、abstract相当の短い説明のみのため、実験・評価・比較対象はメタデータからは不明。
- **議論はある？**: 実運用では、社内データへのアクセス制御、agentの誤作動、情報漏洩、監査ログ、connected apps連携時の権限継承が論点になりそう。ただし本文がないため、資料内で議論されているかは不明。
- **次に読む/試すなら**: Notion AI / Notion Agentsの公式ドキュメントを確認する。社内contextを使うagentでどの粒度の権限管理が可能か調べる。既存のNotion workspaceで、会議メモやプロジェクトDBを使った最小agent workflowを試す。
- **キーワード**: `AI workspace`, `agent orchestration`, `company context`, `Notion`, `connected apps`

## 気になったこと

- これは論文というよりNotionのプロダクト紹介ページに見えるため、学術的な主張・検証・関連研究の有無を確認したい。
- 「company context」が具体的に何を指すのか、Notion内データだけか、外部SaaS連携も含むのかを確認したい。
- agentの権限、監査、失敗時のrollback、人間の承認フローがどう設計されているかを調べたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [noauthor-undated-ic-where-teams-and-agents-work-together-f6bfcadc.md](../../chat/2026-08-02/noauthor-undated-ic-where-teams-and-agents-work-together-f6bfcadc.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
