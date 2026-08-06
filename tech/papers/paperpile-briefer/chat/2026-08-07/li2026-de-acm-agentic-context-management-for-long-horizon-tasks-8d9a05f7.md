# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {ACM}: Agentic Context Management for Long Horizon Tasks

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - ACM: Agentic Context Management for Long Horizon Tasks

## 基本情報

- **タイトル**: ACM: Agentic Context Management for Long Horizon Tasks
- **著者**: Xiaochuan Li, Ryan Ming, Meng Chu, Shuai Shao, Rong Jin, Chenyan Xiong
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.23809v1 / arXiv:2607.23809v1 / Code: https://github.com/lixiaochuan2020/agentic-context-management

## 落合陽一フォーマット

- **ひとことでいうと**: 長期タスクを解くLLM agentに、自分で文脈を圧縮・外部保存・再検索させる Agentic Context Management (ACM) を導入し、探索とcoding taskの性能を上げた論文。
- **先行研究と比べてどこがすごい？**: ReSumやACONのような固定閾値ベースの要約ではなく、agent自身が必要なタイミングで `manage_context` を呼ぶ。さらに、圧縮前の生ログを外部メモリに保存し、`query_memory` で後から取り戻せるため、単なる不可逆要約より情報損失が少ない設計になっている。
- **技術や手法の肝はどこ？**: working memoryとして短いin-context履歴を保ち、古い詳細はlong-term memoryとして外部ストレージに退避する。コアは2つのtoolで、`manage_context` が直前の未圧縮区間を要約してraw messageを保存し、`query_memory` がsummary idとqueryを使って保存済みraw messageから必要情報を抽出する。加えて、teacher-studentのdual-constraint data generationで「圧縮すべき場面」と「圧縮せず探索や回答に進むべき場面」の両方を学習させる。
- **どうやって有効だと検証した？**: BrowseComp-Plus、DeepSearchQA、SWE-Bench Verifiedで評価。Qwen3.5-9Bを主なstudentにし、ReAct、Summary Agent系、Memory Agent系と比較している。本文では、ACM post-trainingによりReAct baseline比でBrowseComp-Plusが27%、DeepSearchQAが16%、SWE-Bench Verifiedが8%改善したと報告。さらにpeak token usageが約20%下がり、tool call数と探索turnが増え、独立試行間の解の一貫性も改善したと分析している。
- **議論はある？**: ACMは、そもそも長期探索とtool useを維持できる強いbase modelを前提にする。弱いモデルでは数turnで破綻し、context managementを学ぶだけの有用なtrajectoryが得にくい。また、比較対象の一部は著者らによる再実装なので、元実装との差分が結果に影響している可能性がある。PDF抽出上、表の細かい数値は一部レイアウト崩れがあるため、厳密な数値確認は原PDFの表を直接見るべき。
- **次に読む/試すなら**: 1. GitHub実装で `manage_context` / `query_memory` のinterfaceを確認する。2. 自分のagent workflowで固定閾値要約とACM風agent-initiated圧縮をA/B testする。3. teacher annotationなしで既存agentにprompt/tool追加だけした場合の効果を試す。
- **キーワード**: `agentic context management`, `long-horizon agents`, `context compression`, `external memory`, `tool use`, `post-training`

## 気になったこと

- `query_memory` の検索・抽出精度が低い場合、lossless設計でも実用上は情報が戻らない可能性がある。
- `manage_context` を呼ぶ判断は、タスク難度・tool出力の長さ・モデルの自己認識に強く依存しそう。
- coding agentに入れるなら、圧縮対象を「ログ全文」ではなく、file diff、test output、探索済み仮説単位に構造化した方が効くかもしれない。
- token削減だけでなく、失敗探索や重複観測を消すことによるreasoning noise低減がどれくらい寄与しているかを分離して見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
