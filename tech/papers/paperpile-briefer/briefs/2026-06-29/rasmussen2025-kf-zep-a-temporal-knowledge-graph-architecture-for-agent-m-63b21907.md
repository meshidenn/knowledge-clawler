# Paperpile Brief 2026-06-29 - Zep: A temporal knowledge graph architecture for agent memory

## 基本情報

- **タイトル**: Zep: A temporal knowledge graph architecture for agent memory
- **著者**: Preston Rasmussen, Pavlo Paliychuk, Travis Beauvais, Jack Ryan, Daniel Chalef
- **年 / venue**: 2025 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2501.13956 / arXiv:2501.13956

## 落合陽一フォーマット

- **ひとことでいうと**: AIエージェントの長期記憶を、時間情報つき知識グラフとして構築・検索するメモリレイヤー「Zep」と、その中核エンジン「Graphiti」を提案した論文。
- **先行研究と比べてどこがすごい？**: 静的文書RAGではなく、会話や業務データのように変化し続ける情報を、エピソード記憶・意味記憶・コミュニティ要約の階層グラフで扱う点が差分。MemGPTのDeep Memory Retrievalでは94.8%対93.4%でわずかに上回り、LongMemEvalではfull-context baselineより最大18.5%精度改善、応答遅延を約90%削減したと報告している。
- **技術や手法の肝はどこ？**: Graphitiが、元メッセージを保持するEpisode Subgraph、抽出されたEntity/Factを持つSemantic Entity Subgraph、関連エンティティ群を要約するCommunity Subgraphを作る。さらに、事実の有効期間 `tvalid` / `tinvalid` と、システム上の作成・失効時刻 `t'created` / `t'expired` を分けるbi-temporal modelで、変化する関係や矛盾を履歴ごと管理する。
- **どうやって有効だと検証した？**: DMRとLongMemEvalで評価。DMRではMemGPT、full-conversation、session summaryと比較し、Zepがgpt-4-turboで94.8%、gpt-4o-miniで98.2%を達成。LongMemEvalでは平均約115k tokensの長い会話に対して、Zepは約1.6k tokensの検索コンテキストでgpt-4o 71.2%、gpt-4o-mini 63.8%を達成し、full-context baselineより精度とレイテンシを改善した。
- **議論はある？**: DMRは短い会話・単純な事実検索に偏っており、著者自身もベンチマークとして弱いと指摘している。MemGPTのLongMemEval比較は実装上うまく評価できておらず、直接比較は限定的。Zepは商用システムであり、運用条件、プロンプト、LLM依存、コスト、再現性には注意が必要。single-session-assistant系の質問ではZepがfull-contextより悪化するケースもある。
- **次に読む/試すなら**: GraphitiのGitHub実装を読んで、エンティティ抽出・fact invalidation・検索APIの実装を見る。LongMemEvalで自分のRAG/agent memory実装と比較する。bi-temporal knowledge graphが自分のエージェント用途で本当に必要か、簡易版で最小実験する。
- **キーワード**: `agent memory`, `temporal knowledge graph`, `Graphiti`, `Zep`, `RAG`, `LongMemEval`, `MemGPT`, `bi-temporal model`

## 気になったこと

- LLMによるentity/fact抽出と矛盾検出の誤りが、長期運用でどの程度グラフ汚染につながるか。
- structured business dataとconversation historyを同時に扱う評価は本文でも未十分とされており、実運用に近い検証が必要。
- full-contextより悪化したsingle-session-assistant質問では、検索で何を落としているのかをエラー分析したい。
- Graphitiの時間失効ロジックは強力だが、ドメイン固有ontologyなしでどこまで安定するかは追加確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [rasmussen2025-kf-zep-a-temporal-knowledge-graph-architecture-for-agent-m-63b21907.md](../../chat/2026-06-29/rasmussen2025-kf-zep-a-temporal-knowledge-graph-architecture-for-agent-m-63b21907.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
