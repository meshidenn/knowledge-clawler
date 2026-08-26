# Chat Prompt 2026-08-27

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {OPDSearch+}: On-policy distillation with {RL} refinement for search-augmented reasoning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-27 - OPDSearch+: On-policy distillation with RL refinement for search-augmented reasoning

## 基本情報

- **タイトル**: OPDSearch+: On-policy distillation with RL refinement for search-augmented reasoning
- **著者**: Qinglin Ye, Zhiyuan Gu, Jingjie Xia, Yiheng Zhang, Kaiyan Zhao, Shunchao Zheng, Yuhang Mu, Wenchao Du, Yiming Wang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.24310v1](https://arxiv.org/abs/2608.24310v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 検索を使う小型LLMを、タスク専用に訓練していない凍結済み教師モデルからオンポリシー蒸留し、その後RLで仕上げることで強化する手法。
- **先行研究と比べてどこがすごい？**: 動的な検索環境で教師専用の軌跡データ収集や教師のタスク別学習を不要にした点が新しい。3B学生モデルで平均EM 0.4402を達成し、既存3B RLベースラインの最高値0.421を上回った。特に多段検索のHotpotQAと2WikiMultihopQAで大きく改善したと報告している。
- **技術や手法の肝はどこ？**: 学生自身がライブ検索で生成した推論・検索・回答軌跡を、凍結したQwen2.5-14B-Instruct教師がトークン単位で評価する。位置ごとのforward KLをクリップ付き重要度重みで最小化し、検索クエリや根拠統合を暗黙に教師化する。蒸留後にGRPOによるRLを逐次適用する二段階構成である。
- **どうやって有効だと検証した？**: NQ、TriviaQA、PopQA、HotpotQA、2WikiMultihopQA、MuSiQue、Bamboogleの7ベンチマークでEMを評価した。Search-R1、AutoRefine、StepSearch、GiGPOなど3B手法と比較し、forward KLと複数のreverse-KL系目的も同条件で比較している。学生はQwen2.5-3B、検索は2018年12月Wikipediaに対するE5-base-v2のtop-3検索を用いた。
- **議論はある？**: 逆KL系の不安定性は同一ハイパーパラメータでの比較が中心で、目的関数ごとの十分なチューニング後にも優位かは未検証である。RL段階は「訓練崩壊を観測した時点」で停止しており、停止基準や最良チェックポイント選択が性能に影響しうる。Bamboogleは125サンプル評価であり、結果の分散も確認したい。
- **次に読む/試すなら**:
  - 3B学生・凍結14B教師でforward-KL OPDのみを最小再現し、検索クエリの変化を観察する。
  - offline SFT、OPDのみ、RLのみ、OPD→RLを同一検索器・同一予算で比較する。
  - 教師サイズ、検索コーパス更新、検索器変更に対する頑健性を評価する。
- **キーワード**: `on-policy distillation`, `search-augmented reasoning`, `forward KL`, `reinforcement learning`, `multi-hop QA`

## 気になったこと

- forward KLが検索クエリの質を改善する因果を、最終EM以外の検索再現率・根拠被覆率・クエリ多様性でも確認したい。
- 教師は学生の取得済み文脈上で確率を出すため、教師自身が実際に検索した場合との能力差がどの程度あるか気になる。
- 二段階最適化が有効な理由として主張する「方策分布の再形成」を、他モデル系列・異なる検索APIでも再現できるか確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
