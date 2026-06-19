# Chat Prompt 2026-06-20

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {REVES}: {REvision} and {VErification}--augmented training for test-time scaling

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-20 - REVES: REvision and VErification-augmented training for test-time scaling

## 基本情報

- **タイトル**: REVES: REvision and VErification-augmented training for test-time scaling
- **著者**: Yuanxin Liu, Ruida Zhou, Xinyan Zhao, Amr Sharaf, Hongzhou Lin, Arijit Biswas, Mohammad Ghavamzadeh, Zhaoran Wang, Mingyi Hong
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2606.18910 / PDF: https://arxiv.org/pdf/2606.18910.pdf / Code: https://github.com/yxliu02/REVES.git

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのテスト時逐次修正能力を、途中の「惜しい失敗」を revision / verification プロンプトに変換して強化する、test-time scaling 向けの訓練法 REVES を提案した論文。
- **先行研究と比べてどこがすごい？**: 通常のRLHF/RLVR/GRPOは単発回答の目的を最適化するため、複数ターンで修正しながら解く推論とズレる。従来のmulti-turn RLは軌跡全体に報酬を流すため、途中の誤答にも正の信用割当が入る。REVESは逐次修正目的を状態ごとの一歩回復確率に分解し、失敗中間状態からの回復だけを単一ターンRLとして学習する点が肝。
- **技術や手法の肝はどこ？**: 逐次修正ロールアウトを走らせ、最終的に成功した軌跡だけを保持し、その途中の誤答を「修正すべき状態」として再利用する。各状態から revision prompt と verification prompt を作り、元のRLプロンプト集合に混ぜて単一ターンRLで訓練する。これをエポックごとに更新することで、モデルの現在の失敗分布に合わせたデータ拡張を続ける。
- **どうやって有効だと検証した？**: Qwen2.5-7B/3B、Qwen3-4B、DeepSeek-R1-Distill-Qwen-7B系で評価。LiveCodeBenchではRL baseline比で+6.5点、標準multi-turn training比で+4.0点の改善を報告。MATH500、AIME24/25でもoracle停止・self-confidence停止の両方で逐次修正性能が改善。circle packingではQwen3-4Bで既報SOTA相当の結果に到達し、n_queensやmini_sudokuのOOD制約充足パズルにも汎化したとされる。
- **議論はある？**: REVESは訓練時にground-truth verifierを必要とするため、数学・コード・制約充足・最適化のような自動検証可能タスクに強く依存する。自由記述QAや創作、嗜好ベースのRLHFにはそのまま適用しにくい。また、PDF抽出本文上では有効性は広く示されているが、検証器の品質、公開テストケースへの過適合、自己confidence停止の信頼性は追加確認したい。
- **次に読む/試すなら**: 1. GitHub実装でデータ拡張ループとprompt templateを確認する。 2. 自分のコード生成タスクで「失敗→公開テスト feedback→修正」の最小実験を組む。 3. verifierが弱いタスクで verification prompt がどこまで代替になるか試す。
- **キーワード**: `test-time scaling`, `sequential revision`, `RLVR`, `multi-turn RL`, `self-correction`, `verification`, `LLM reasoning`

## 気になったこと

- 成功軌跡だけを使うフィルタリングが、難問や探索初期でどれくらいデータ偏りを生むのか。
- 公開テストケースを停止規則に使うコード評価で、private testへの汎化をどこまで保てるのか。
- verification promptは校正を改善するが、誤った自己検証を強化するケースはないのか。
- PDE、定理証明、symbolic regressionなど、自動検証器を持つ科学タスクへの応用がかなり相性良さそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
