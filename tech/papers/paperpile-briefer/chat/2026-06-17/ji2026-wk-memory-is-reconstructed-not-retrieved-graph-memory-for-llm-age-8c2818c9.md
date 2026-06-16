# Chat Prompt 2026-06-17

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Memory is reconstructed, not retrieved: Graph memory for {LLM} agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-17 - Memory is reconstructed, not retrieved: Graph memory for {LLM} agents

## 基本情報

- **タイトル**: Memory is reconstructed, not retrieved: Graph memory for {LLM} agents
- **著者**: Shuo Ji, Yibo Li, Bryan Hooi
- **年 / venue**: 2026 / arXiv [cs.AI]。PDF本文では ICML 2026 Proceedings / PMLR 306 と記載
- **リンク**: https://arxiv.org/pdf/2606.06036 / code: https://github.com/Ji-shuo/MRAgent

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントの長期記憶を、固定的な検索ではなく、推論しながら手がかりを増やして再構成するグラフ記憶システム MRAgent を提案した論文。
- **先行研究と比べてどこがすごい？**: RAG、LangMem、A-Mem、MemoryOS、Mem0 などは、クエリから top-k 検索したり、事前定義された近傍を展開したりする受動的検索に寄っている。本論文は、検索途中で得た証拠を使って次の探索方針を変える「能動的再構成」にしている点が差分。LoCoMo と LongMemEval で強いベースラインを上回り、LoCoMo では Gemini backbone で overall judge score が 68.31 から 84.21、Claude backbone でも改善したと報告している。
- **技術や手法の肝はどこ？**: 記憶を Cue–Tag–Content グラフとして表す。Cue は人名・属性・時点などの細粒度手がかり、Tag は cue と記憶内容をつなぐ連想的な中間表現、Content はエピソード記憶・意味記憶・トピック抽象。LLMはまず cue から tag を選び、次に tag 経由で content を取るため、全文内容に飛び込む前に探索枝を絞れる。さらに Navigate / Answer の2モードで、探索ツールを逐次呼び出し、得た証拠に応じて次の探索を選ぶ。
- **どうやって有効だと検証した？**: LoCoMo と LongMemEval で評価。比較対象は RAG、LangMem、A-Mem、MemoryOS、Mem0。指標は F1、LLM-Judge、トークン消費、ランタイムなど。LongMemEval では Gemini backbone で MRAgent が 118k tokens とされ、A-Mem 632k、LangMem 3,268k などより少ない。ランタイムは最速ではないが、MemoryOS や LangMem より低く、Mem0 に近い水準と報告されている。アブレーションでは Cue→Episode、Cue–Tag–Episode、Cue–Tag–Content、reasoning 有無を比較し、tag と multi-turn reasoning の寄与を見ている。
- **議論はある？**: PDF本文によれば、探索深度が増えるクエリでは再構成コストとレイテンシが増える。また、記憶構築は静的で、更新・統合・忘却の仕組みは薄く、長期運用ではグラフが単調に大きくなる。LLMによる cue/tag 抽出の品質や、LLM-Judge 評価への依存も実装上のリスク。細かい数値はPDF抽出テキスト由来なので、表の完全性は要確認。
- **次に読む/試すなら**: MRAgent の GitHub 実装を確認し、Cue–Tag–Content のデータ構造と探索ツールの実装コストを見る。手元の対話ログで、top-k RAG と MRAgent 風の逐次探索を小さく比較する。A-Mem、Zep、Mem0 との違いを「記憶構築」と「検索時推論」に分けて整理する。
- **キーワード**: `LLM agent memory`, `active retrieval`, `memory reconstruction`, `Cue-Tag-Content graph`, `long-term memory`, `LoCoMo`, `LongMemEval`

## 気になったこと

- Cue / Tag / Content の抽出をLLMに任せる場合、抽出ミスや表記揺れがグラフ探索性能にどれくらい効くのか。
- 「能動的再構成」の利得が、単に追加のLLM推論ステップを使った効果とどこまで分離できているのか。
- 実サービスで必要になる記憶の更新、忘却、矛盾解消、プライバシー削除にどう接続するか。
- LongMemEval で MRAgent* が Claude retrieval を使う条件があり、バックボーン差と手法差の切り分けを追加確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
