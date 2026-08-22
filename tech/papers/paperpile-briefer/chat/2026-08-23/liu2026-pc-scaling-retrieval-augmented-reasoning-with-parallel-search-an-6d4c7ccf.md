# Chat Prompt 2026-08-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Scaling retrieval-augmented reasoning with parallel search and explicit merging

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-23 - Scaling retrieval-augmented reasoning with parallel search and explicit merging

## 基本情報

- **タイトル**: Scaling retrieval-augmented reasoning with parallel search and explicit merging
- **著者**: Jiabei Liu, Wenyu Mao, Junfei Tan, Chunxu Shen, Lingling Yi, Jiancan Wu, Xiang Wang
- **年 / venue**: 2026 / arXiv [cs.AI]（v1, 2026-05-13）
- **リンク**: [arXiv:2605.13534v1](https://arxiv.org/abs/2605.13534v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 深い検索型RAGエージェントで、各推論ステップに複数クエリを並列発行し、取得結果を明示的に統合するようRLで学習させ、検索ノイズを減らす手法「MultiSearch」。
- **先行研究と比べてどこがすごい？**: 逐次・単一クエリに依存するSearch-R1系に対し、検索の網羅性と統合品質を中間報酬で直接最適化する。7つのQAベンチマークで、3B Baseモデルの平均EMは0.422で、Search-R1の0.312、AutoRefineの0.405を上回った。
- **技術や手法の肝はどこ？**: 各ステップで言い換え・概念拡張・質問分解などから3本のクエリを生成して並列検索し、重複・不要文書を除いた上で`<merge>`内に根拠を集約する。最終回答F1に加え、平均クエリ数が2超で得られる報酬と、統合文に正解が含まれる場合の報酬を用いる。異種報酬はGDPOで個別正規化してから統合する。
- **どうやって有効だと検証した？**: NQ、TriviaQA、PopQA、HotpotQA、2WikiMultiHopQA、Musique、BamboogleでEMを評価し、Qwen2.5の3B/7B・Base/Instructを比較した。アブレーションで複数クエリ、明示的マージ、各報酬の寄与を検証し、GDPOはGRPOより高い平均EMを示した。
- **議論はある？**: マージ報酬は「統合文に正解文字列があるか」で評価するため、根拠の忠実性や因果的な統合品質までは測れない。複数クエリは検索コスト・レイテンシを増やしうるが、実運用での費用対効果はPDF本文からは十分に検証されているとは言い切れない。また、評価は主に英語QAベンチマークであり、Webの変動情報や長文調査への一般化は未検証である。
- **次に読む/試すなら**:
  1. Search-R1、AutoRefine、GDPOを読み、比較条件と報酬設計の差を確認する。
  2. 自前のRAGで「単一検索」「3並列検索＋マージ」を同じ検索予算で比較する。
  3. 正解文字列一致ではなく、引用根拠の支持性・矛盾除去を採点するマージ報酬を試す。
- **キーワード**: `agentic RAG`, `deep search`, `multi-query retrieval`, `reinforcement learning`, `GDPO`

## 気になったこと

- 3クエリ固定が最適なのか、質問難度・検索コストに応じてクエリ数を適応的に止められるか。
- マージ内容が最終回答に本当に寄与したかを、引用単位でどう検証するか。
- 検索結果の多様性向上と、並列検索によるノイズ増加のトレードオフを測りたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
