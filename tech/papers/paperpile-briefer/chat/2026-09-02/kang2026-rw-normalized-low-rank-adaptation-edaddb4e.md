# Chat Prompt 2026-09-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Normalized Low-Rank Adaptation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-02 - Normalized Low-Rank Adaptation

## 基本情報

- **タイトル**: Normalized Low-Rank Adaptation
- **著者**: Jiale Kang, Ziyin Yue, Zheng Zhan, Yangyi Huang, Weiyang Liu
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2608.31036v1

## 落合陽一フォーマット

- **ひとことでいうと**: LoRAのdown-projection行列 \(A\) をrank次元で列ごとに正規化し、低ランク適応の初期勾配スケールを整えることで、収束・安定性・性能を改善するNoRAを提案した。
- **先行研究と比べてどこがすごい？**: PiSSAやMiLoRAのようなSVDベース初期化と異なり、追加データ・追加学習パラメータ・推論時計算を要さず、LoRAの重みマージ可能性を維持する。SFTではLoRAの平均37.93に対しNoRAは43.37、RLVRではLoRAの42.8に対し44.4を報告している。
- **技術や手法の肝はどこ？**: 通常のLoRA更新 \(\Delta W=\alpha BA\) に対し、\(A\) の各入力座標に対応する列をL2正規化して \(B\,\mathrm{Norm}(A)x\) とする。これにより、各入力座標の暗黙的な学習率に当たる列ノルムを揃え、低ランクボトルネック由来の悪いconditioningを抑える。毎ステップ正規化するNoRAに加え、初期化時だけ正規化するNoRA-init、およびblock identityで初期化するBIMIも示す。
- **どうやって有効だと検証した？**: PDF本文に基づく。340M規模の事前学習、Llama-3.2-3Bの数学・コードSFT、DeepSeek-R1-Distill-Qwen-1.5Bの数学RLVRで評価した。LoRA、PiSSA、OFT、rsLoRA、MiSS、DoRA等と比較し、正規化方向のアブレーションも実施。列方向（rank次元）の正規化は有効だが、行方向正規化はほぼ効かないと報告する。
- **議論はある？**: 効果は主に初期最適化の改善という説明だが、より大規模なモデル・多様なアーキテクチャ・複数seedでの統計的頑健性はPDF本文から十分には確認できない。列ノルムを1に揃える設計が常に最適か、rank・scale \(\alpha\)・データ分布との相互作用も未解決。SFTではNoRAの知識保持は良好だが、評価ベンチマーク範囲には限りがある。
- **次に読む/試すなら**:
  - 既存LoRA実装で、初期化直後の \(A\) を列ごとにL2正規化するNoRA-initをまず比較する。
  - rank・\(\alpha\)・対象層ごとに、勾配ノルムとforgetting指標をLoRAと並べて計測する。
  - PiSSA／MiLoRAが不安定になり得るRL設定で、NoRAの再現性を複数seedで検証する。
- **キーワード**: `LoRA`, `PEFT`, `normalization`, `low-rank adaptation`, `initialization`, `RLVR`

## 気になったこと

- NoRAの改善が「列ノルムの均一化」そのものによるのか、列間相関（crosstalk）の変化にも依存するのかを切り分けたい。
- NoRA-initがNoRAの大部分の効果を得るなら、継続的な正規化が効く条件を明確にしたい。
- \(\alpha=r\) を推奨しているが、量子化LoRA、極小rank、MoE、非Pre-Norm構造でも同じ設定が妥当かは要検証。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
