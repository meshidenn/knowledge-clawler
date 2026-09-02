# Paperpile Brief 2026-09-03 - Knowledge distillation during mid-training favors reasoning over factual recall

## 基本情報

- **タイトル**: Knowledge distillation during mid-training favors reasoning over factual recall
- **著者**: Jacqueline He, Howard Yen, Shuyue Stella Li, Margaret Li, Hanqing Zeng, Yinglong Xia, Benyu Zhang, Zhuokai Zhao, Qiang Zhang, Pang Wei Koh, Luke Zettlemoyer, Wen-Tau Yih
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2609.01532v1](https://arxiv.org/abs/2609.01532v1)、[コード](https://github.com/facebookresearch/midtraining-distillation)

## 落合陽一フォーマット

- **ひとことでいうと**: Mid-training中の通常の知識蒸留は「推論力を伸ばす代わりに未獲得の事実想起を遅らせる」ことを示し、教師の予測エントロピーでKDと通常の次トークン予測をトークン単位で切り替えるSwitch Distillationを提案した論文。
- **先行研究と比べてどこがすごい？**: KDをpre-training／post-trainingだけでなくmid-training固有の問題として分析した点が新しい。標準KDが推論・事実想起の両方を改善し得るpre-trainingと異なり、mid-trainingではトレードオフになることを示した。Switch Distillationは7B・13B教師で既存KDを上回り、NTP比で推論1.61–1.71倍、知識・常識1.13–1.19倍を達成しつつ、事実想起の96.7–96.8%を維持したと報告する。
- **技術や手法の肝はどこ？**: 教師が確信している低エントロピーのトークンだけにreverse-KL蒸留を適用し、残りの高エントロピーなトークンではコーパスの正解トークンに対するcross-entropyを使う。教師エントロピーの低い領域は数学・指示追従などの手続き的データに多く、教師の正解率も高い。一方、mid-training時点で未獲得の事実は高エントロピー領域に偏り、KDでは正解トークンへの勾配が弱まるため、通常学習へ戻す設計である。
- **どうやって有効だと検証した？**: OLMo-2の1B学生モデルを用い、4Tトークン学習済みチェックポイントから60Bトークンのmid-trainingを実施。1B／7B／13B Instruct教師、forward／reverse KL、蒸留強度を比較し、OLMESでReasoning、Factual Recall、Knowledge & Commonsenseを評価した。さらにSFT、DPO、RLVR 2段階を含むpost-training後も評価し、効果の持続を検証した。
- **議論はある？**: 実験の中心はOLMo-2の1B学生と特定のデータ混合であり、より大きな学生、異なるmid-trainingデータ、継続学習での一般化は追加検証が必要。ルーティング率は$q=20\%$に調整されており、最適値がデータ・モデル規模ごとにどれほど移るかは未解明。教師エントロピーは教師の正しさの有力な代理指標だが、事実の網羅性やデータ自体の誤りは保証しない。
- **次に読む/試すなら**:
  1. 公開コードで、対象コーパスにおける教師エントロピーと正解率の相関を再現する。
  2. $q$、教師サイズ、KL方向を振り、推論・事実想起のPareto frontierを確認する。
  3. 異なる学生規模・ドメイン特化mid-trainingで、同じトレードオフが出るか検証する。
- **キーワード**: `knowledge distillation`, `mid-training`, `teacher entropy`, `reverse KL`, `factual recall`, `reasoning`

## 気になったこと

- 低エントロピー＝高品質な教師信号という関係が、専門知識・多言語・コード生成でも安定するか。
- 7B教師が13B教師を上回る結果は、教師・学生のcapacity gap以外に、教師の校正やデータ分布の差で説明できるか。
- 高エントロピー領域を常にcross-entropyへ戻す二値切替ではなく、教師信頼度に応じた連続的な重み付けが有効か。
- 事実想起の評価が生成型ベンチマーク中心であり、長文文脈内の知識利用や幻覚率への影響も確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [he2026-ye-knowledge-distillation-during-mid-training-favors-reasoning-ov-9c43a710.md](../../chat/2026-09-03/he2026-ye-knowledge-distillation-during-mid-training-favors-reasoning-ov-9c43a710.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
