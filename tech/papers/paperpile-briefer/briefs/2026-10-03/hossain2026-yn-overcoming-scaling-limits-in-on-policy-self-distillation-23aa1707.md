# Paperpile Brief 2026-10-03 - Overcoming scaling limits in on-policy self-distillation for LLM reasoning

## 基本情報

- **タイトル**: Overcoming scaling limits in on-policy self-distillation for LLM reasoning
- **著者**: Md Ismail Hossain, Humaira Kousar, Isidora Chara Tourni
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2609.37915v1

## 落合陽一フォーマット

- **ひとことでいうと**: オンポリシー自己蒸留では、教師の参照解答よりも、正解ラベルで検証された学生自身の軌跡を使う方が、モデルの大規模化後も推論性能を伸ばせることを示し、OASISを提案した。
- **先行研究と比べてどこがすごい？**: 標準的なOPSDでは、未検証の学生ロールアウトに対して、参照解答などの特権的コンテキストを教師へ与える。著者らは、教師コンテキストの正しさよりも、学生の足場（scaffold）が正解かどうかの方が下流精度に強く影響すると分析した。Qwen3-1.7B、4B、8Bで、OASISはベースモデルから平均3.2〜3.8ポイント向上し、8BではOPSDを3.05ポイント上回った。
- **技術や手法の肝はどこ？**: OASISはOPSDの目的関数を維持しつつ、主に最終回答ラベルで検証されたオンポリシー軌跡を教師信号に使う。教師のコンテキストには、参照解答ではなく、モデルが生成した未検証の試行を与えるため、最終回答の正誤ラベルだけで学習できる。
- **どうやって有効だと検証した？**: AIME 2024、AIME 2025、HMMT 2025を用い、Qwen3の1.7B、4B、8Bモデルで比較した。OPSDの改善幅は1.7Bの3.05ポイントから8Bの0.14ポイントまで縮小した一方、OASISは各スケールで3.2〜3.8ポイント程度の改善を示した。詳細な実験条件や統計的検定は、今回取得できたメタデータからは不明。
- **議論はある？**: 今回はPDF本文が取得できず、abstractとメタデータに基づく要約である。検証済み軌跡の作成コスト、正誤ラベルの品質、数学以外のタスクへの一般化、推論長やサンプリング数への依存はメタデータからは不明。また、最終回答が正しくても途中の推論が妥当とは限らない点は、OASISの前提になりうる。
- **次に読む/試すなら**:
  1. 論文本文で、scaffold correctnessとcontext correctnessの因子実験の設計・結果を確認する。
  2. AIME形式の小規模データで、正解ラベル付きオンポリシー軌跡を使う最小再現実験を行う。
  3. 検証済み軌跡と未検証軌跡を混ぜた場合の性能・計算量のトレードオフを測る。
- **キーワード**: `on-policy self-distillation`, `LLM reasoning`, `verified scaffolds`, `outcome supervision`, `OASIS`

## 気になったこと

- 「検証済み」と判定する最終回答ラベルは、外部評価器・ルールベース判定・学習済み報酬モデルのどれで作るのか。
- 8BでOPSDがほぼ飽和する原因は、教師と学生の情報差なのか、未検証軌跡のノイズなのか。
- 参照解答を使わずに教師を成立させる場合、教師分布の品質をどのように保つのか。
- 数学推論以外のコード生成や知識タスクでも、検証済みオンポリシー軌跡が有効か確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [hossain2026-yn-overcoming-scaling-limits-in-on-policy-self-distillation-23aa1707.md](../../chat/2026-10-03/hossain2026-yn-overcoming-scaling-limits-in-on-policy-self-distillation-23aa1707.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
