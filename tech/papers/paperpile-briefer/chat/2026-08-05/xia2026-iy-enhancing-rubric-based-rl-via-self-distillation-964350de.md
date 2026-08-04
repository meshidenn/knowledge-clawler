# Chat Prompt 2026-08-05

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Enhancing rubric-based {RL} via self-distillation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-05 - Enhancing rubric-based RL via self-distillation

## 基本情報

- **タイトル**: Enhancing rubric-based RL via self-distillation
- **著者**: Mingxuan Xia, Yuhang Yang, Chao Ye, Shuai Zhu, Shenzhi Yang, Guangcheng Zhu, Yuhang Zhang, Cheng Peng, Haobo Wang, Siqing Wang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.18082

## 落合陽一フォーマット

- **ひとことでいうと**: rubric-based RLで、評価基準ごとの学習信号が「未探索」または「抑圧」される問題を、on-policy self-distillationで補強するCriPOを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のrubric-guided rollout系手法は、学習時だけrubric情報を使うためtrain-inference mismatchが起きる。本論文はrollout生成自体はon-policyに保ち、自己教師によるtoken-level補助信号でUC/SCを扱う点が差分。特に、既に満たされた基準なのにscalar reward aggregationで負のadvantageに潰されるSuppressed Criteriaを明示的に定義・分析している。
- **技術や手法の肝はどこ？**: CriPOはGRPOを安定した主軸にしつつ、2つの補助機構を足す。Unexplored Criteriaにはcriterion-injection self-teacherを作り、localized forward-KLで足りない振る舞いをpolicyに注入する。Suppressed Criteriaにはcounterfactual self-teacherを使って基準関連tokenを特定し、負のadvantage rollout内の該当tokenだけadvantageを正に反転する。
- **どうやって有効だと検証した？**: Qwen3-1.7B/4Bを対象に、medicine/science系benchmarkでGRPO、HeRL、OPSDなどと比較。本文ではCriPOが平均性能でGRPOを上回り、Qwen3-1.7BでGRPO比+3.2程度、さらにGRPOの収束性能に約2倍少ないoptimization stepsで到達すると報告している。追加実験ではQwen3-32B judgeでも傾向が概ね維持される。
- **議論はある？**: PDF本文上、OPSD単体はrubric-based RLでは不安定で性能劣化するため、CriPOはGRPOとのhybrid設計にしている。限界として、rubric evaluatorやjudge modelの品質に依存する可能性、token localizationやadvantage flippingが本当に因果的な基準貢献を捉えているか、医療・科学以外の長文生成で同様に効くかは追加検証が必要。
- **次に読む/試すなら**: 1. CriPOのUC/SC判定式を自分のrubric RL実験ログに当てて頻度を見る。 2. GRPO実装にlocalized KLとadvantage flippingだけを最小追加してablationする。 3. HeRL/RuscaRLとのtrain-inference mismatchの実測比較を確認する。
- **キーワード**: `rubric-based RL`, `GRPO`, `self-distillation`, `on-policy distillation`, `Unexplored Criteria`, `Suppressed Criteria`, `CriPO`

## 気になったこと

- Suppressed Criteriaのtoken localizationは、LLMのcounterfactual分布差をどの程度信頼できるのか。
- advantage flippingが局所的には有効でも、全体応答のcoherenceや他criteriaとのtrade-offを壊さない条件は何か。
- rubric evaluatorが誤判定した場合、CriPOは誤ったcriterion-level signalを強く固定してしまう可能性がある。
- 医療・科学benchmark以外、例えばcreative writingやmulti-turn dialogueでもSCが同程度に出るのか。
- 実装上は、teacher distribution計算による追加computeが2倍短いstepsの利得を相殺しないか確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
