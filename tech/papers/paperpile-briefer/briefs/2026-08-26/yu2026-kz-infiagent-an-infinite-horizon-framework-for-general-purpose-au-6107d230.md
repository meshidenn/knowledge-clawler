# Paperpile Brief 2026-08-26 - InfiAgent: An Infinite-Horizon Framework for General-Purpose Autonomous Agents

## 基本情報

- **タイトル**: InfiAgent: An Infinite-Horizon Framework for General-Purpose Autonomous Agents
- **著者**: Chenglin Yu, Yuchen Wang, Songmiao Wang, Hongxia Yang, Ming Li
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2601.03204](https://arxiv.org/abs/2601.03204) / [GitHub](https://github.com/ChenglinPoly/infiAgent)

## 落合陽一フォーマット

- **ひとことでいうと**: 長期タスクで肥大化するLLMエージェントの文脈を、ファイルシステムに状態を退避して常に一定サイズに保つフレームワーク。
- **先行研究と比べてどこがすごい？**: 要約・切り詰め・RAGで履歴を再注入する代わりに、状態そのものをファイル中心に外部化する。20BのOSSモデルでDeepResearch総合41.45を報告し、80本の文献レビューでは長文脈圧縮型のアブレーションより高い処理カバレッジを示した。
- **技術や手法の肝はどこ？**: ワークスペース内の計画・中間成果物・ログを永続状態とし、各ステップではそのスナップショットと直近約10アクションだけから推論文脈を再構成する。加えて、階層型エージェントと、文書を別プロセスで読んで必要な回答だけ返すExternal Attention Pipelineを組み合わせる。
- **どうやって有効だと検証した？**: DeepResearchベンチマークと、80論文を読み要約・関連度付けする長期文献レビュー課題で評価した。後者では、ファイル状態を除去して圧縮長文脈に置換すると平均カバレッジが大きく低下することを報告している。
- **議論はある？**: 状態外部化は基盤モデルの誤推論を直さず、誤った成果物が永続化・伝播する危険は残る。階層化・逐次実行・状態統合にはレイテンシがあり、並列処理は未対応。比較対象の商用エージェントには非公開の最適化があり、絶対的優位を示す比較ではない。
- **次に読む/試すなら**:
  1. GitHub実装でワークスペースの状態スキーマと再構成プロンプトを確認する。
  2. 自分の長期エージェントに「成果物ファイル＋直近行動のみ」の状態管理を導入し、完了率を比較する。
  3. 永続状態への誤り混入を防ぐ検証・ロールバック機構を追加する。
- **キーワード**: `LLM agents`, `long-horizon reasoning`, `file-centric state`, `persistent memory`, `multi-agent systems`

## 気になったこと

- ファイル状態のスナップショットをどの粒度・形式で作るか、また膨大なファイル群から何を文脈へ選ぶかが性能を左右しそう。
- 「内容に基づく非空要約」で測るカバレッジは完了率には有用だが、要約の正確性・引用の妥当性・誤情報率も別途必要。
- External Attention用の一時LLMがどのモデル・コスト・精度で動くか、実運用時の総コストは本文からは不明。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yu2026-kz-infiagent-an-infinite-horizon-framework-for-general-purpose-au-6107d230.md](../../chat/2026-08-26/yu2026-kz-infiagent-an-infinite-horizon-framework-for-general-purpose-au-6107d230.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
