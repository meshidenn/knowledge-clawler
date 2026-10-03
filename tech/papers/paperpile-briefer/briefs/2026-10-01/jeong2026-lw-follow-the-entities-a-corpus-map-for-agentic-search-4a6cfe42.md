# Paperpile Brief 2026-10-01 - Follow the entities: A corpus map for agentic search

## 基本情報

- **タイトル**: Follow the entities: A corpus map for agentic search
- **著者**: Soyeong Jeong, Sujay Kumar Jauhar, Sung Ju Hwang, Andrew Joohun Nam
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2609.37226v1

## 落合陽一フォーマット

- **ひとことでいうと**: 文書を単純なファイル集合として検索させるのではなく、文書間で繰り返し登場する人物・プロジェクト・製品などのエンティティを軸にEntity Pageを作り、エージェントが関連文書を辿れるようにした。
- **先行研究と比べてどこがすごい？**: GraphRAGのように検索器内部でグラフを使うのではなく、エンティティを介した文書間リンクをエージェント自身に公開する点が新しい。3ベンチマーク・7モデルで、Raw Corpus比の品質を6.4〜11.7ポイント改善し、入力トークンも34〜57%削減した。
- **技術や手法の肝はどこ？**: コーパスからエンティティ種別を誘導し、文書内のメンション抽出、文書横断のエンティティ解決、Entity Pageの生成をオフラインで行う。複数文書に現れるエンティティだけを二部グラフのノードとして残し、Entity Pageから関連文書へ移動できるようにする。
- **どうやって有効だと検証した？**: EnterpriseRAG-Bench、WixQA、HERBのマルチドキュメント質問を使い、正確性・完全性・文書/コンテキスト再現率・入力トークンを評価した。GPT系4モデルに加え、DeepSeek、MAI、Qwenでも検証し、Document Page、Group Page、LLM Wiki、Corpus2Skill、BM25、Dense Retrieval、HippoRAG、GraphRAGなどと比較した。
- **議論はある？**: エンティティ抽出・同一性解決の誤りがリンク品質と回答品質に直結する。Entity Pageが機密情報を集約し、権限の異なる文書を意図せず接続するリスクもある。また、主な評価対象は複数文書にまたがる質問で、一般的な単一文書検索への効果は限定的かもしれない。構築コストはクエリ数が少ないと不利であり、論文自体もarXivプレプリントである。
- **次に読む/試すなら**:
  1. 手元の論文・メモ群から人物、プロジェクト、手法を抽出してEntity Pageを作る。
  2. Raw Corpus検索と、エンティティリンク付き検索で同じ質問の文書再現率とトークン数を比較する。
  3. GLinkerなどLLMなしの抽出・解決器で、構築コストとリンク誤りを測る。
- **キーワード**: `agentic search`, `entity resolution`, `corpus navigation`, `multi-document QA`, `RAG`

## 気になったこと

- エンティティ解決の誤リンク・リンク漏れが、最終回答にどの程度影響するか。
- Entity Pageの要約が原文にない誤った関係を作らないか。
- 権限管理をEntity Pageと文書リンクにどう適用するか。
- 自分の知識ベースでは、エンティティ中心とトピック中心のどちらが探索効率に効くか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [jeong2026-lw-follow-the-entities-a-corpus-map-for-agentic-search-4a6cfe42.md](../../chat/2026-10-01/jeong2026-lw-follow-the-entities-a-corpus-map-for-agentic-search-4a6cfe42.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
