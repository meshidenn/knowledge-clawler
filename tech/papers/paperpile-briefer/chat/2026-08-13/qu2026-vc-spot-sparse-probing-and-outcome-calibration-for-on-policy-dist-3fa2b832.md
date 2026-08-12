# Chat Prompt 2026-08-13

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {SPOT}: Sparse Probing and Outcome calibration for on-policy distillation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-13 - SPOT: Sparse Probing and Outcome calibration for on-policy distillation

## 基本情報

- **タイトル**: SPOT: Sparse Probing and Outcome calibration for on-policy distillation
- **著者**: Zikun Qu, Min Zhang, Mingze Kong, Zhiwei Shang, Yikun Ban, Shuang Qiu, Zhongxiang Dai
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2608.04419

## 落合陽一フォーマット

- **ひとことでいうと**: on-policy distillationで「どのtoken位置を追加調査するか」と「何を教師信号として蒸留するか」を分け、検証器で評価した分岐結果を使って教師分布を補正するSPOTを提案した論文。
- **先行研究と比べてどこがすごい？**: 通常のOPDはreverse KLで教師の最頻候補に寄りやすく、多様な正解経路を落としやすい。EOPDはteacher entropyで高不確実位置を拾うが、 uncertainty が少数候補に集中しているのか長いtailに散っているのか、またstudentが既に候補を表現できているのかを区別しない。SPOTはentropy、top-k質量、student-teacher mismatchを掛け合わせてprobe位置を選び、さらにdownstream outcomeでtargetを補正する点が差分。
- **技術や手法の肝はどこ？**: acquisition-exploration-exploitationの3段構成。まず位置スコア `s_t = normalized teacher entropy * top-k mass * student-teacher gap` で限られたprobe budgetを配分する。次に選ばれた位置でteacher top-k候補を1つずつ付け、frozen studentで続きをrolloutし、verifierで結果を採点する。最後に `teacher prior * exp(gamma * verified value)` というKL正則化付きのclosed-form targetを作り、OPD lossにbranch lossを足す。
- **どうやって有効だと検証した？**: PDF本文によれば、Qwen3-8Bをteacher、Qwen3-0.6B/1.7B/4Bをstudentとして、MATHやDAPO-Mathで訓練し、MATH-500、AMC 2023、Minerva Math、HMMT 2025、AIME 2024/2025などの数学推論benchmarkで評価。KD、GRPO、OPD、EOPDと比較し、3つのQwen設定すべてでmacro Pass@8が最高、macro Avg@8も最高または2位と報告している。out-of-domainではGPQA-DiamondのPass@8で大きく改善し、MMLU-ProではEOPDに僅差で次点。
- **議論はある？**: verifierに強く依存する。本文の設定ではbinary rule-based boxed-answer matchで、数学推論には合うが、自由記述・コード・長期対話などでは同じ設計がそのまま効くかは不明。probe rolloutは `M * k_p * N_p` の追加計算を要し、低予算ではvalue推定が粗い。PDF抽出上、細かい表の数値は一部崩れているため、個別benchmarkの数値は原PDFで再確認したい。
- **次に読む/試すなら**: 
  1. EOPDとSPOTの差分を、同じstudent/teacherで小規模MATH subset上に再現する。
  2. verifierをbinary正誤ではなくLLM-as-judgeやpartial creditにした場合のtarget安定性を見る。
  3. acquisition scoreの3要素をablationし、どれがprobe効率に効いているか確認する。
- **キーワード**: `on-policy distillation`, `SPOT`, `LLM distillation`, `reverse KL`, `outcome calibration`, `verifier`, `reasoning models`

## 気になったこと

- teacherのlocal probabilityとdownstream successがずれる具体例を、どの程度一般的な現象として観測しているか。
- binary verifierかつcandidateあたり1 rolloutで、branch value推定のvarianceがどの程度問題になるか。
- 数学以外の領域で「正解判定できるverifier」をどう用意するか。
- probe位置をtop-M固定にする設計が、長いreasoning traceや難問で十分か。
- reward-tilt係数 `gamma` とbranch-loss weight `beta` の感度。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
