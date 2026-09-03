# Chat Prompt 2026-09-04

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {WHALE}: A simple recipe for joint harness-weight optimization

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-04 - WHALE: A simple recipe for joint harness-weight optimization

## 基本情報

- **タイトル**: WHALE: A simple recipe for joint harness-weight optimization
- **著者**: Haechan Kim, Yoonho Lee, Gisang Lee, Chelsea Finn, Kangwook Lee
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2609.00196](https://arxiv.org/abs/2609.00196) / [PDF](https://arxiv.org/pdf/2609.00196.pdf) / [コード](https://github.com/krafton-ai/WHALE)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントの「モデル重み」と「ツール利用・文脈管理を担う実行ハーネス」を交互に最適化し、両者を共進化させるWHALEを提案した論文。
- **先行研究と比べてどこがすごい？**: 重み更新とプロンプト最適化だけでなく、ツール仕様、検索、コード実行、エラー処理、終了条件を含む実行可能なハーネス全体を探索対象にした。重みのみ・ハーネスのみ・prompt+weightのFast-Slow Trainingを上回り、best mean@8精度で4.15〜24.38ポイント改善したと報告する。
- **技術や手法の肝はどこ？**: 各サイクルで、(1) 現在のハーネスを固定して、検証器に通った自己生成軌跡だけでonline rejection-sampling fine-tuning（RSFT）を行い、(2) 更新済みモデルを固定してMeta-Harnessで候補ハーネスを提案・評価・選択する。片方を固定することで、相手も変化することによる評価の混線を抑える。
- **どうやって有効だと検証した？**: Qwen3.5-2B/4Bを用い、SearchQA、Python実行を伴う数学推論、チェスパズルの3領域で比較した。WHALEは全ベンチマーク群で最良の平均精度を示し、細かい交互更新は「重みを最後まで更新してからハーネスを一度探索する」段階的手法より、精度・ロールアウト効率の両面で優位だった。適応的なpatienceベースの切替も固定スケジュールを上回った。
- **議論はある？**: 検証は比較的小規模なQwenモデルと3領域に限られ、大規模モデルや実運用エージェントへの一般化は未検証。SearchQAの評価にはLLM-as-a-judgeを使うため、判定器の偏りもあり得る。探索・学習ともロールアウトを多く要し、ハーネス探索の提案品質や安全性への依存も大きい。最良点をtest accuracyで報告する設計は、モデル選択と評価の分離という観点で追加確認したい。
- **次に読む/試すなら**:
  - 既存エージェントで、プロンプトだけでなく終了条件・リトライ・検索クエリ整形を探索変数にして再現する。
  - 重み更新前後で「どのハーネス変更が効くか」を比較し、ボトルネックがモデル側か制御側かを診断する。
  - Meta-HarnessとFast-Slow Training、および自動エージェント最適化研究を追う。
- **キーワード**: `LLM agents`, `harness optimization`, `alternating optimization`, `rejection-sampling fine-tuning`, `tool use`

## 気になったこと

- ハーネス候補の生成器がClaude Opus 4.7であるため、提案モデルの能力・コストが結果にどれほど寄与するか。
- ハーネス探索の評価は候補ごとに訓練例あたり1ロールアウトであり、偶然の高スコアをどの程度選びやすいか。
- 実運用で重要な安全制約、ツール呼び出しコスト、レイテンシを目的関数に入れても優位性が維持されるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
