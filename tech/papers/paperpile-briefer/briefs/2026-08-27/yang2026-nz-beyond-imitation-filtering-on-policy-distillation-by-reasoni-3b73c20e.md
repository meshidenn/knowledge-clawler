# Paperpile Brief 2026-08-27 - Beyond imitation: Filtering On-Policy Distillation by reasoning progress

## 基本情報

- **タイトル**: Beyond imitation: Filtering On-Policy Distillation by reasoning progress
- **著者**: Chen Yang, Haiyuan Wan, Rengrong Xiong, Yize Chen, Danny H. K. Tsang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.19408](https://arxiv.org/abs/2608.19408)

## 落合陽一フォーマット

- **ひとことでいうと**: 教師モデルへの模倣度と実際の推論進捗が食い違う箇所だけを検出し、On-Policy Distillation（OPD）の教師信号を選択的に無効化するR2-OPDを提案した。
- **先行研究と比べてどこがすごい？**: プロセス報酬を新たな最適化目的として足すのではなく、教師由来のKL報酬が信用できるかを判定するフィルタとして使う。DeepSeek-R1-Distill-Qwen-1.5Bでは標準OPDの平均性能をavg@4で32.55→35.06、pass@4で47.37→51.83へ改善した。
- **技術や手法の肝はどこ？**: 学生モデルの途中推論から短いrolloutを複数回生成し、解答可能性の増減をプロセス報酬として推定する。進捗の符号が同じ隣接区間を統合してノイズを下げ、統合区間ごとに「推論進捗」と「教師との逆KL乖離」の順位を比較する。進捗が大きいのにKL損失も大きい矛盾区間を、最大30%までマスクする。
- **どうやって有効だと検証した？**: DAPO-Math-17Kで1 epoch学習し、AIME 2024、AIME 2025、OlympiadBenchで評価した。DeepSeek系とQwen3/e3系の2構成で比較し、後者でもOPD比で平均pass@4を45.70→48.19へ改善した。符号一貫区間の統合を外すablationでは、特にAIMEで大幅に性能が下がった。
- **議論はある？**: 各境界で8回のrolloutが必要で計算コストとMonte Carlo分散がある。正解文字列を含む軌跡など、プロセス報酬を推定できる条件を満たさない場合はフィルタしない。数学推論・小規模モデル中心の検証であり、大規模モデルや他ドメインへの一般化は未検証である。
- **次に読む/試すなら**:
  1. rollout回数・マスク率・境界分割規則を変え、計算量と改善幅のトレードオフを測る。
  2. プロセス報酬の推定を、より安価なvalue modelやPRMに置き換えて比較する。
  3. コード生成・エージェント軌跡でも「教師への一致」と「実タスク進捗」が乖離するかを検証する。
- **キーワード**: `on-policy distillation`, `process reward`, `reasoning progress`, `knowledge distillation`, `LLM reasoning`

## 気になったこと

- 区間境界は自己修正表現などの固定語彙に依存しており、モデルや言語が変わった場合の頑健性を確認したい。
- 正解文字列を含まないが有望な途中軌跡をフィルタ対象外にする設計が、探索的な推論をどの程度取り逃がすか気になる。
- KL順位との衝突が「教師の誤り」ではなく、プロセス報酬推定の偶然の誤差で生じる場合への耐性を調べたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yang2026-nz-beyond-imitation-filtering-on-policy-distillation-by-reasoni-3b73c20e.md](../../chat/2026-08-27/yang2026-nz-beyond-imitation-filtering-on-policy-distillation-by-reasoni-3b73c20e.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
