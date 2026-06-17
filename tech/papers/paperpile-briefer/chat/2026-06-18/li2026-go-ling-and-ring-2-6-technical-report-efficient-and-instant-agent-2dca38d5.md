# Chat Prompt 2026-06-18

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Ling and Ring 2.6 technical report: Efficient and instant agentic intelligence at trillion-parameter scale

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-18 - Ling and Ring 2.6 technical report: Efficient and instant agentic intelligence at trillion-parameter scale

## 基本情報

- **タイトル**: Ling and Ring 2.6 technical report: Efficient and instant agentic intelligence at trillion-parameter scale
- **著者**: Ling Team, Inclusion AI / Li, Ang ほか
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2606.15079 / PDF: https://arxiv.org/pdf/2606.15079.pdf / Code: https://github.com/inclusionAI/Ling-V2.5

## 落合陽一フォーマット

- **ひとことでいうと**: Ling-2.6とRing-2.6という、即応性・長文効率・エージェント実行能力を同時に狙った trillion-parameter 級オープンモデル群の技術報告。
- **先行研究と比べてどこがすごい？**: Ling-2.0をゼロから再学習せず、既存チェックポイントをハイブリッド線形注意へ移行し、長コンテキスト推論コストとKV cache圧を下げつつ性能を維持・向上させる点が主張。さらに、短いが高密度な出力を最適化するLing系と、深い推論・ツール利用・長期エージェント実行を強化するRing系を分けて設計している。
- **技術や手法の肝はどこ？**: Lightning AttentionとMLAを7:1で混ぜるハイブリッド注意、Ling-2.0からの段階的なアーキテクチャ移植、Evo-CoT・LPO・双方向preference alignment・shortest-correct-response distillationによる「能力/出力トークン」の最適化、そしてRing-2.6向けのKPop RL。KPopはIcePopの固定比率制約をbinary KL divergenceベースのマスクに置き換え、学習時と推論時のtoken probability mismatchをより細かく扱う。
- **どうやって有効だと検証した？**: 知識、推論、エージェント、命令追従、長文理解の各ベンチマークで評価。PDF本文ではLing-2.6-1TがAIME26、HMMT、IMO-AnswerBench、PinchBench、BFCL、τ2-benchなどで強い結果を示したと報告されている。Ring-2.6ではSWE-bench Verified、GAIA-2 Search、PinchBench、ClawEval、τ2-bench Telecomなどのエージェント系評価を用い、KPopによりSWE-bench Verifiedのsolve rateが改善したと述べている。ただし、抽出本文は表や数値の一部が崩れている可能性があるため、細かい順位・差分は原PDF確認が必要。
- **議論はある？**: 技術報告なので自己評価中心で、外部再現や独立評価はまだ限定的。データ汚染対策、エージェント環境の実在性、ベンチマーク設定、teacher model由来データの影響、オープンチェックポイントで同じ学習レシピを再現できるかが重要な未検証点。trillion-scaleのため、研究者がフル再現するコストも高い。
- **次に読む/試すなら**: Ling-2.6-flashとLing-2.6-1TのHugging Face checkpointを確認する。KPop/IcePopの詳細ブログとRing 2.0系報告を読む。自分のエージェント評価タスクで、短答効率とツール実行成功率を既存モデルと比較する。
- **キーワード**: `agentic intelligence`, `hybrid linear attention`, `Lightning Attention`, `MLA`, `KPop`, `token efficiency`, `MoE`, `long context`, `SWE-bench`

## 気になったこと

- 7:1のLightning Attention/MLA比率が他モデルサイズや別ドメインでも最適なのか。
- 「capability per output token」を実運用でどう測るべきか。短ければよい、になっていないか。
- KPopのbinary KL maskが、低確率だが重要な探索トークンをどの程度残せるのか。
- エージェント学習データに含まれるMCP環境、GitHub issue/PR、検索タスクの汚染・重複除去の詳細。
- open checkpointだけでなく、学習環境・評価ハーネス・データ生成手順がどこまで再現可能か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
