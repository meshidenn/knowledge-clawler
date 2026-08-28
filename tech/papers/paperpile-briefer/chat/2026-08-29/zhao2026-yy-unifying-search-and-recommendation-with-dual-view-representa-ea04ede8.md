# Chat Prompt 2026-08-29

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Unifying search and recommendation with dual-view representation learning in a generative paradigm

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-29 - Unifying search and recommendation with dual-view representation learning in a generative paradigm

## 基本情報

- **タイトル**: Unifying search and recommendation with dual-view representation learning in a generative paradigm
- **著者**: Jujia Zhao, Wenjie Wang, Chen Xu, Xiuying Chen, Zhaochun Ren, Suzan Verberne
- **年 / venue**: 2026 / ACM Transactions on Information Systems
- **リンク**: メタデータからは不明（DOI、arXiv、URLの記載なし）

## 落合陽一フォーマット

- **ひとことでいうと**: 検索と推薦を、タスク別プロンプトを使う単一の生成モデルとして統合するGenSRを提案した論文。
- **先行研究と比べてどこがすごい？**: 共有encoder＋タスク別headの識別的設計ではなく、生成的パラダイムへ移行することで、勾配競合と手作業のアーキテクチャ設計を同時に緩和しようとしている。3ベンチマークで既存手法を上回ったと報告する。
- **技術や手法の肝はどこ？**: 協調情報と意味的な履歴情報を別々に扱うDual Representation Learningでアイテム表現を作り、contrastive learningとinstruction tuningを組み合わせて、検索・推薦それぞれに適した出力空間を形成する。
- **どうやって有効だと検証した？**: 3つのベンチマークで検索・推薦タスクを評価し、SOTA手法との比較で優位性を示したとされる。評価指標、データセット名、改善幅はPDF本文がないためメタデータからは不明。
- **議論はある？**: 本文未取得のため、計算コスト、プロンプト設計への感度、長期履歴への頑健性、タスク間の性能トレードオフ、再現条件は不明。相互情報量を高めるという説明が実証的にどこまで裏付けられているかも確認が必要。
- **次に読む/試すなら**:
  - GenSRの比較対象・各ベンチマーク・評価指標を本文で確認する。
  - Dual Representation Learningの各ビューを外すablationの効果を確認する。
  - 自サービスの検索ログと推薦ログで、instruction tuningによる共有モデル化を最小実験する。
- **キーワード**: `search and recommendation`, `generative recommendation`, `dual-view representation learning`, `instruction tuning`, `contrastive learning`

## 気になったこと

- 検索クエリが明示される場面と、推薦のようにクエリがない場面を、どのようなプロンプト形式で同一モデルに入力するのか。
- 「相互情報量の向上」が実際に測定・分析されているのか、それとも設計上の解釈にとどまるのか。
- 生成モデル化による推論遅延や候補数拡大への対応、実運用時のコストが知りたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
