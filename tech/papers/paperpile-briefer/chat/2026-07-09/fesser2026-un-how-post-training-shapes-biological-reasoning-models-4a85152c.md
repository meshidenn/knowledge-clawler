# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- How post-training shapes biological reasoning models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - How post-training shapes biological reasoning models

## 基本情報

- **タイトル**: How post-training shapes biological reasoning models
- **著者**: Lukas Fesser, Hanlin Zhang, Michelle M. Li, Eric Wang, Bryan Perozzi, Shekoofeh Azizi, Sham M. Kakade, Marinka Zitnik
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: メタデータに DOI / arXiv ID / URL なし

## 落合陽一フォーマット

- **ひとことでいうと**: 生物学向け reasoning model において、CPT・SFT・RL という post-training の各段階が ID/OOD 汎化をどう変えるかを、100以上のモデルで比較した論文。
- **先行研究と比べてどこがすごい？**: 生物学 foundation model を使った reasoning model は増えているが、post-training の各段階が性能向上と過適応にどう効くかは未整理だった。この論文は genomics・transcriptomics・proteins をまたいで、backbone、CPT、SFT、RL を制御しながら ID/OOD の差分を見る点が新しい。
- **技術や手法の肝はどこ？**: post-training を単なる性能改善の積み上げとして見ず、CPT は生物学的言語への alignment、SFT はID性能向上とOOD劣化、RL は強いSFT checkpointと適切な reward のもとでOOD回復、という役割分担として分析している点。
- **どうやって有効だと検証した？**: abstract/metadataベースでは、genomics・transcriptomics・proteins の複数領域で、100以上の biological reasoning models を訓練・評価し、ID性能とOOD性能を比較したとされる。具体的なベンチマーク名、データセット、数値、統計的有意性はメタデータからは不明。
- **議論はある？**: PDF本文がないため詳細な限界は不明。ただし abstract からは、追加の supervision や compute が単調に性能を上げるわけではなく、SFT の過適応、reward alignment 依存、post-training budget 配分が重要な制約として読める。
- **次に読む/試すなら**: 
  - PDF本文を取得して、使われた生物学タスク・OOD分割・reward設計を確認する。
  - SFTを短く止めてRL配分を増やす設計が、自分の対象タスクでも再現するか小規模実験する。
  - CPT/SFT/RL の各段階で表現や回答傾向がどう変わるか、失敗例ベースで見る。
- **キーワード**: `biological reasoning models`, `post-training`, `continued pre-training`, `supervised fine-tuning`, `reinforcement learning`, `OOD generalization`

## 気になったこと

- OODの定義が biological domain shift なのか、タスク形式の違いなのか、データセット分布の違いなのかを確認したい。
- RL の reward が何に基づくのか。正解ラベル、LLM judge、専門モデル、ルールベース評価のどれかで解釈が大きく変わる。
- 「asymmetric adaptation capacity across stages」が具体的に何を指すのか。LoRA rank、更新パラメータ量、学習ステップ数、モデル部位の違いなのか本文で確認したい。
- SFTでOODが早期ピーク後に落ちるなら、early stopping指標をID validationではなくOOD proxyで設計できるかが実装上の焦点になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
