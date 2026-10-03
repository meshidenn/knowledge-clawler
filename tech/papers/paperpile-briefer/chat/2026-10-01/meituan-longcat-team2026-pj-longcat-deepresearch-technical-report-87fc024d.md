# Chat Prompt 2026-10-01

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {LongCat}-{DeepResearch} Technical Report

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-10-01 - LongCat-DeepResearch Technical Report

## 基本情報

- **タイトル**: LongCat-DeepResearch Technical Report
- **著者**: Meituan LongCat Team, He Zhu, Yue Xu, Wanli Wu ほか
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2609.36071v1

## 落合陽一フォーマット

- **ひとことでいうと**: 深い調査を「計画」「独立した章ごとの調査・執筆」「全体編集・局所修正」に分割し、ResearchSpecを共有するマルチエージェント型の調査システム。
- **先行研究と比べてどこがすごい？**: 調査途中で全文を何度も書き直す代わりに、初期段階では調査要件を表すコンパクトなResearchSpecだけを改善する。各章の完全な草稿を保持したまま、Global Editorが重複や担当範囲を整理し、Local Editorが該当箇所だけを修正する設計が特徴。
- **技術や手法の肝はどこ？**: 複数のPlannerが外部情報を調べて候補計画を作り、Judge・Critic・Reviserが統合・欠落検出・修正を行う。ResearchSpecには章の範囲、研究質問、必要な対象、情報源候補を記録し、Researcherは担当章を独立コンテキストで調査・執筆する。最後に章を機械的に結合し、Global Editorの編集指示をLocal Editorへ渡す。
- **どうやって有効だと検証した？**: PDF本文の評価では、DeepResearchBench 55.25、DeepResearchBench II 51.35、ResearchRubrics 79.83を達成した。比較対象中、既存3システムの最高値をそれぞれ0.30、3.17、5.62ポイント上回ったと報告している。独自ベンチマークでは76.04で4システム中2位となり、ChatGPT-DeepResearchの76.59に次いだ。計画視点の追加、計画 refinement、編集ラウンドの効果も開発セットで分析した。
- **議論はある？**: 計画を改善するほど性能が上がるわけではなく、カテゴリによって効果が混在する。ResearchSpecは章調査開始後に固定されるため、調査中に発見した新しい大域的論点を計画へ戻す処理は未実装。また、開発セットの一部は事前評価をもとに選ばれており、反復試行・計算資源・取得情報の変動も十分に切り分けられていない。ケーススタディでもTreynorやCPPIの欠落、内部章番号の残存があり、計画と編集だけでは網羅性や事実性を保証できない。
- **次に読む/試すなら**:
  1. ResearchSpecをJSONスキーマ化し、Planner・Researcher・Editorを分離した最小構成を実装する。
  2. 単一エージェントの全文反復と、章分割＋局所編集を同一モデル・同一検索予算で比較する。
  3. 章ごとの引用被覆率と、編集後に失われた主張を自動評価する。
- **キーワード**: `deep research`, `multi-agent workflow`, `ResearchSpec`, `section-level editing`, `evidence-grounded report`

## 気になったこと

- ResearchSpecを固定する設計は、調査中に見つかった重要な新規論点を取りこぼさないか。
- 評価値の改善が、モデル能力・検索予算・編集回数・訓練データのどれによるものか、本文だけでは完全には分離できない。
- Global Editorが章間の重複を整理する際、引用の所有権や根拠の対応関係をどこまで保持できるか。
- 長い章を全体コンテキストへ戻す編集段階で、Long Context由来の情報利用低下が起きないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは?
