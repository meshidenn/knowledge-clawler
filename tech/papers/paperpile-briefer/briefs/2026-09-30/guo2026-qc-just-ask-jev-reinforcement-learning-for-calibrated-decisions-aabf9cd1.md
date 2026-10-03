# Paperpile Brief 2026-09-30 - Just ask Jev: Reinforcement learning for calibrated decisions as a zero-shot detector of AI alignment failures

## 基本情報

- **タイトル**: Just ask Jev: Reinforcement learning for calibrated decisions as a zero-shot detector of AI alignment failures
- **著者**: Ruoqi Guo, Yi Liu, Gelei Deng, Yuekang Li, Lida Zhao, Yutao Wu, Simin Chen, Ying Zhang, Leo Yu Zhang
- **年 / venue**: 2026 / arXiv [cs.AI]（ICLR 2027投稿中）
- **リンク**: https://arxiv.org/abs/2609.29429

## 落合陽一フォーマット

- **ひとことでいうと**: RLCDモデルJevに、1回の呼び出しで複数の質問へ確率的に回答させ、10種類のAIアラインメント失敗をゼロショット検出できるか検証した論文。
- **先行研究と比べてどこがすごい？**: 従来のLLM judgeや安全分類器が評価基準ごとに個別推論を必要とするのに対し、Jevは1回の呼び出しで複数のtyped questionを処理できる。44ベンチマーク・7,193件で、汎用質問の中央値AUROC 0.886を達成し、LLM judgeより約63倍安価だった。
- **技術や手法の肝はどこ？**: 「何を質問するか」と「何を入力状態として見せるか」を分離して評価する設計。NOUL、CHOICE、SCORE形式の確率出力を使い、質問文・回答形式・入力フィールドを変えながら、単なるargmaxではなく確率そのものを検出スコアに利用する。
- **どうやって有効だと検証した？**: sycophancy、jailbreak、deception、prompt injection、hallucination、privacy violationなど10種類を対象に、5つのオープンモデルの出力を評価。既存ベンチマークのreference scorer、StrongREJECTとHarmBenchの人手ラベル、教師ありTF-IDF・長さベースラインと比較した。StrongREJECTでは人手ラベルとのκがJev 0.809、reference scorer 0.811だった。
- **議論はある？**: 検出順位は良好でも、ベンチマーク単位の確率校正は弱く、中央値ECEは0.168だった。閾値はデータセットごとに少数ラベルで調整する必要がある。また、Jev-1.13.0という1モデル、英語、2〜7B規模の対象モデル、主に既存scorerラベルに限定されており、より大きなモデル・他言語・他の検出器への一般化は未検証。さらに、既存ベンチマークのラベル自体に欠陥や、入力状態から観測できない情報への依存が見つかった。
- **次に読む/試すなら**:
  1. RLCDAlignBenchのコードとキャッシュ済み出力を使い、手元のモデルで最小検出実験を再現する。
  2. 10件程度のラベルで閾値を調整し、AUROCだけでなくF1・ECE・選択的予測精度を測る。
  3. 自分の評価データで、ラベル定義に必要な参照情報が入力状態に含まれているか監査する。
- **キーワード**: `RLCD`, `Jev`, `alignment failure detection`, `calibration`, `LLM judge`, `benchmark label audit`

## 気になったこと

- 汎用質問で高いAUROCが出るのは、Jevが本当に失敗概念を理解しているためか、入力状態にラベルの手がかりが含まれているためか。
- 既存ラベルの欠陥を検出できる一方、Jev自身の誤検出をどの程度効率的に人手確認できるか。
- 監視対象モデルがJevの検出傾向を学習した場合、検出回避や分布外失敗に弱くならないか。
- PDF本文に基づく要約であり、論文は2026年時点でICLR 2027投稿中のプレプリント。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは?
---

## 追加で聞く

- Chat prompt: [guo2026-qc-just-ask-jev-reinforcement-learning-for-calibrated-decisions-aabf9cd1.md](../../chat/2026-09-30/guo2026-qc-just-ask-jev-reinforcement-learning-for-calibrated-decisions-aabf9cd1.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
