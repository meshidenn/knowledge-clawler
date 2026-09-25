# Paperpile Brief 2026-09-02 - Knowledge distillation during mid-training favors reasoning over factual recall

## 基本情報

- **タイトル**: Knowledge distillation during mid-training favors reasoning over factual recall
- **著者**: Jacqueline He, Howard Yen, Shuyue Stella Li, Margaret Li, Hanqing Zeng, Yinglong Xia, Benyu Zhang, Zhuokai Zhao, Qiang Zhang, Pang Wei Koh, Luke Zettlemoyer, Wen-tau Yih
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2609.01532v1

## 落合陽一フォーマット

- **ひとことでいうと**: Mid-training中の通常のKnowledge Distillation（KD）は推論力を伸ばす一方で事実想起を遅らせる。そこで教師の予測エントロピーが低いトークンだけKDし、残りは通常の次トークン予測（NTP）で学習するSwitch Distillationを提案した。
- **先行研究と比べてどこがすごい？**: KDを学習段階に依存しない手法とみなさず、pre-trainingとmid-trainingで効果が質的に変わることを示した点が新しい。教師の大きさ・KL方向を変えても生じる「推論–事実想起のトレードオフ」を、トークン単位のルーティングで緩和する。
- **技術や手法の肝はどこ？**: 各トークンで教師分布の予測エントロピーを計算し、バッチ内で低エントロピーな上位20%だけをreverse KLによる蒸留へ送る。高エントロピーな残りはCross-Entropyで正解コーパストークンを学習する。教師logitは通常のKDでも必要なため、追加計算は軽微とされる。
- **どうやって有効だと検証した？**: OLMo-2の1B学生モデルを用い、7B/13B Instruct教師、60Bトークンのmid-trainingで評価した。OLMESにより推論、事実想起、知識・常識を測定し、NTP、forward/reverse KD、TRKDと比較。Switch DistillationはNTP比で推論を1.61–1.71倍、知識・常識を1.13–1.19倍にしつつ、事実想起を96.7–96.8%保持した。さらにSFT・DPO・RLVRを含むpost-training後も、推論・知識の優位性と事実想起の回復を報告している。
- **議論はある？**: 実験の主軸はOLMo-2の1B学生と特定のデータ混合・評価群であり、より大きな学生、別アーキテクチャ、実運用データで同じ最適ルーティング率になるかは未検証である。教師サイズは大きければよいわけではなく、13B教師より7B教師が良い場合もあり、capacity gapへの依存がある。エントロピーは教師の正確さの代理指標であり、未知領域・分布外データでの頑健性は追加検証が必要。
- **次に読む/試すなら**:
  1. 公開コード https://github.com/facebookresearch/midtraining-distillation で、低エントロピー20%・reverse KLの最小再現を行う。
  2. 自分のmid-trainingデータで、教師エントロピーと正解トークン一致率・事実想起の相関を測る。
  3. 教師–学生のサイズ比とルーティング率を掃引し、capacity gapと最適閾値の関係を確認する。
- **キーワード**: `knowledge distillation`, `mid-training`, `teacher entropy`, `reverse KL`, `factual recall`, `reasoning`

## 気になったこと

- 「低エントロピー＝信頼できる教師」という基準は、教師が自信を持って誤るケースをどこまで排除できるか。
- q=20%の閾値はデータ混合・学生規模・教師モデルごとに再調整が必要か。
- 事実想起の評価がTriviaQA、Natural Questions、SimpleQA中心であり、長尾知識や最新知識への効果は不明。
- post-trainingによって事実想起ギャップが閉じる機構と、その際に失われる知識の内訳を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [he2026-ye-knowledge-distillation-during-mid-training-favors-reasoning-ov-9c43a710.md](../../chat/2026-09-02/he2026-ye-knowledge-distillation-during-mid-training-favors-reasoning-ov-9c43a710.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
