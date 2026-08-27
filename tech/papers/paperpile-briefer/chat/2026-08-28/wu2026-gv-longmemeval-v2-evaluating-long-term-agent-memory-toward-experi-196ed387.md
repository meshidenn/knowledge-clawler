# Chat Prompt 2026-08-28

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {LongMemEval}-{V2}: Evaluating long-term agent memory toward experienced colleagues

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-28 - LongMemEval-V2: Evaluating Long-Term Agent Memory Toward Experienced Colleagues

## 基本情報

- **タイトル**: LongMemEval-V2: Evaluating Long-Term Agent Memory Toward Experienced Colleagues
- **著者**: Di Wu, Zixiang Ji, Asmi Kawatkar, Bryan Kwan, Jia-Chen Gu, Nanyun Peng, Kai-Wei Chang
- **年 / venue**: 2026 / arXiv [cs.CL]（Preprint）
- **リンク**: [arXiv:2605.12493](https://arxiv.org/abs/2605.12493)

## 落合陽一フォーマット

- **ひとことでいうと**: Webエージェントが長期の行動履歴から「その環境に詳しい同僚」レベルの経験を獲得できているかを測る、最大1.15億トークン級の長期メモリ評価ベンチマークと、その強力なベースラインを提案した論文。
- **先行研究と比べてどこがすごい？**: 会話履歴の想起や単一軌跡の理解ではなく、複数のWeb操作軌跡を通じた環境固有の知識を直接測る。451問で、静的状態・動的状態・ワークフロー・環境固有の罠・誤った前提の検知まで扱い、AgentRunbook-Cは平均72.5%で最強RAGベースラインの48.5%、素のCodexの69.3%を上回る。
- **技術や手法の肝はどこ？**: メモリを`Insert(軌跡)`と`Query(質問)`のAPIとして定式化し、下流LLMに渡す根拠だけを収集させる。AgentRunbook-Rは生の状態断片・状態遷移イベント・戦略ノートを別々に検索する構造化RAG、AgentRunbook-Cは軌跡をファイルとして保存し、ワークフロー指示・マニフェスト・調査用スクリプトを与えたcoding agentに根拠収集を担わせる。
- **どうやって有効だと検証した？**: WebArena、WorkArena、WorkArena++由来の1,540軌跡を使い、100軌跡のSmallと約500軌跡のMediumで評価した。固定のQwen3.5-9B readerに最大20万トークンの収集済みコンテキストを渡し、正答率とクエリ遅延を比較。AgentRunbook-CはSmallで74.9%、Mediumで70.1%を達成し、素のCodexより速い。
- **議論はある？**: coding agent型は高精度だが依然として遅く、AgentRunbook-Cでもクエリに約108〜140秒かかる。評価環境はカスタマイズ済みWebArena/WorkArena系列に集中しており、実運用の多様なUIや継続的に変化する環境への一般化は未検証。自由記述回答にはLLM judgeを使うため、評価器依存性も確認したい。
- **次に読む/試すなら**:
  1. 自分のエージェント履歴を「状態・遷移・手順・失敗事例」に分けて保存するRAGを最小実装する。
  2. ファイルベースの履歴検索をcoding agentに委任し、精度とレイテンシを通常RAGと比較する。
  3. LongMemEval-V1、MemoryArena、AMA-Benchと、評価対象の記憶能力・コンテキスト規模を比較する。
- **キーワード**: `agent memory`, `long-context evaluation`, `web agents`, `RAG`, `coding agents`, `trajectory memory`

## 気になったこと

- PDF本文に基づくと、AgentRunbook-Cの優位は専用スキャフォールドによるものだが、外部知識や検索へのアクセスをどこまで厳密に遮断できているかを確認したい。
- 451問の手動作成・人手検証の再現可能性、質問作成者と評価対象手法の設計者が近いことによるベンチマーク最適化の影響を確認したい。
- 「経験した同僚」という概念が、未知タスクの成功率や環境変更後の適応速度にどれだけ結び付くかは別途検証が必要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
