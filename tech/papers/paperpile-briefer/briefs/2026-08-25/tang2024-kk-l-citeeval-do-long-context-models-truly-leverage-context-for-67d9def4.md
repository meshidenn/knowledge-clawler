# Paperpile Brief 2026-08-25 - L-CiteEval: Do Long-Context Models Truly Leverage Context for Responding?

## 基本情報

- **タイトル**: L-CiteEval: Do Long-Context Models Truly Leverage Context for Responding?
- **著者**: Zecheng Tang, Keyan Zhou, Juntao Li, Baibei Ji, Jianye Hou, Min Zhang
- **年 / venue**: 2024 / メタデータからは不明
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: 長文コンテキストモデルが回答を本当に入力文脈に基づけているかを、引用付きで自動評価するベンチマーク「L-CiteEval」を提案した論文。
- **先行研究と比べてどこがすごい？**: 特定タスクやGPT-4のような外部評価器に依存しがちな従来評価に対し、11タスク・8K〜48Kトークン規模を横断し、回答品質だけでなく引用の正確性・再現率からfaithfulnessを評価できる点。
- **技術や手法の肝はどこ？**: モデルに根拠箇所の引用を伴う回答を要求し、その引用が文脈中の正しい根拠を指すかを自動評価する設計。生成内容の正しさと「与えた文脈を使ったか」を切り分ける。
- **どうやって有効だと検証した？**: 11の先端的なクローズド／オープンソース長文モデルを、11タスク・複数ドメインで比較した。要約結果の差が小さくても、オープンモデルは引用精度・再現率でクローズドモデルに大きく劣る傾向を報告している。またRAGも評価し、faithfulnessは改善する一方で生成品質はわずかに下がるとしている。※PDF本文がないため、abstractに基づく要約。
- **議論はある？**: 引用指標が実際のfaithfulnessをどの程度完全に代理できるか、11タスクの具体的内訳、各モデルの設定・統計的有意性はメタデータからは不明。RAGによる品質低下の程度や、attentionと引用生成の相関が因果関係を意味するかも追加検証が必要。
- **次に読む/試すなら**: 1. L-CiteEvalのデータセットと自動評価器の公開状況を確認する。2. 自分の長文QA/RAGパイプラインで引用精度・再現率を計測する。3. オープンモデルで「正答だが根拠なし」の回答を抽出し、検索・プロンプト・学習のどこで改善できるか比較する。
- **キーワード**: `long-context models`, `faithfulness`, `citation evaluation`, `RAG`, `benchmark`

## 気になったこと

- 引用の「正確性」「再現率」が、文単位・段落単位・スパン単位のどれで算出されるのか。
- 回答内容が正しくても、モデル内知識に依存した場合をどこまで確実に検出できるのか。
- RAGの検索失敗と生成モデルの文脈未利用を、評価上どのように分離しているのか。
- attentionと引用生成の相関について、層・ヘッド・モデル規模をまたいで再現するのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [tang2024-kk-l-citeeval-do-long-context-models-truly-leverage-context-for-67d9def4.md](../../chat/2026-08-25/tang2024-kk-l-citeeval-do-long-context-models-truly-leverage-context-for-67d9def4.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
