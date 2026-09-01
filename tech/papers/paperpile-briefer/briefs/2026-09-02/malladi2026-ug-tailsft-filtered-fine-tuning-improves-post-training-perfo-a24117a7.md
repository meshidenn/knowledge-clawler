# Paperpile Brief 2026-09-02 - TailSFT: Filtered Fine-Tuning Improves Post-Training Performance

## 基本情報

- **タイトル**: TailSFT: Filtered Fine-Tuning Improves Post-Training Performance
- **著者**: Sadhika Malladi, Samy Jelassi, Dylan J. Foster, Jordan T. Ash, Akshay Krishnamurthy
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2608.25756](https://arxiv.org/abs/2608.25756) / [PDF](https://arxiv.org/pdf/2608.25756)

## 落合陽一フォーマット

- **ひとことでいうと**: RL後学習の初期モデルとして強いSFTモデルを作るため、すでに学習済みの系列をSFT中に除外し、低確率な正答の裾野を残す「TailSFT」を提案した。
- **先行研究と比べてどこがすごい？**: 通常SFTが最小化するcross-entropyやpass@1ではなく、大きなKでのpass@K＝RLロールアウトで正答に到達できる確率を最適化対象として重視する。RL手法自体を変えず、SFTの勾配を受ける系列だけを変える軽量な介入で、後続GRPOの性能向上まで示した。
- **技術や手法の肝はどこ？**: 初期方策での各訓練系列の損失と、現在の損失との差を測る。損失が最も大きく減った系列、つまりすでに十分適合した系列を各バッチから一定割合フィルタし、残る「未モデル化の裾野」にのみ通常のtoken-level cross-entropyを適用する。絶対損失ではなく初期モデルからの改善量で判定する点が核である。
- **どうやって有効だと検証した？**: 制御可能なグラフ探索タスクで、TailSFT系のフィルタリングがcross-entropyとpass@1を悪化させ得る一方、pass@8を改善することを確認。OLMo-3 7Bを数学・コード向けデータでSFTし、18のデータセット・ベンチマーク組で評価した結果、15組でpass@16が向上した。最大ではBigCode→CruxEval-Oでpass@16が+16.79ポイント。さらに同一条件のGRPOでは、最終pass@1が+1.21〜+3.93ポイント向上した。
- **議論はある？**: 効果は一様ではなく、18組中3組ではpass@16が悪化またはほぼ不変である。評価は主にOLMo-3 7B、数学・コード、GRPOという範囲に限られ、大規模モデル・一般対話・別RL手法への一般化は未検証。フィルタ率の選択も実運用上の重要なハイパーパラメータである。著者のcoverage-ratio診断は有効条件であり、改善の必要条件ではない。
- **次に読む/試すなら**:
  1. 手元のSFTログで、初期モデル比の系列損失低下量を記録しTailSFTを実装する。
  2. pass@1だけでなく、実際のRL rollout数に対応したpass@KをSFTチェックポイント選択指標にする。
  3. coverage-ratioが1を超えるタスクを優先し、標準SFTとTailSFTを同一RL設定で比較する。
- **キーワード**: `supervised fine-tuning`, `RL post-training`, `coverage`, `pass@K`, `GRPO`, `data filtering`

## 気になったこと

- 初期方策の損失を全SFTデータに対して事前計算する際の、巨大データセットでの保存量・計算量はどの程度か。
- 「損失が大きく減った系列」が本当に冗長な正答だけを表すのか、短い定型回答やデータ品質の偏りを過剰に除外しないか。
- pass@16の改善が、長期のRL学習・別のrollout予算・報酬モデルを使うRLでも一貫して最終性能へ転移するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [malladi2026-ug-tailsft-filtered-fine-tuning-improves-post-training-perfo-a24117a7.md](../../chat/2026-09-02/malladi2026-ug-tailsft-filtered-fine-tuning-improves-post-training-perfo-a24117a7.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
