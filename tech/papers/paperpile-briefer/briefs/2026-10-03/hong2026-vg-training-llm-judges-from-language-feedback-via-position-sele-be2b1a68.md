# Paperpile Brief 2026-10-03 - Training LLM judges from language feedback via position-selective self-Distillation

## 基本情報

- **タイトル**: Training LLM judges from language feedback via position-selective self-Distillation
- **著者**: Ilgee Hong, Changlong Yu, Zhenghao Xu, Xin Liu, Yuwei Zhang, Qin Lu, Bing Yin, Tuo Zhao
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2609.38792v1

## 落合陽一フォーマット

- **ひとことでいうと**: 自然言語の評価理由を使ってLLM judgeを自己蒸留し、学習上重要なトークン位置だけを選ぶことで、主観的評価タスクのOOD性能を高めた論文。PDF本文は取得できておらず、以下はabstractベースの整理。
- **先行研究と比べてどこがすごい？**: GRPOなどの結果報酬型RLが最終判定に単一スカラー報酬を与えるのに対し、評価理由を用いた位置レベルの密な教師信号を導入した点。さらに、単純な自己蒸留ではなく、OOD汎化に有害になり得る位置をマスクする設計を提案している。
- **技術や手法の肝はどこ？**: 評価理由を条件にしたteacherとstudentの各トークン位置について、予測分布のエントロピー変化を計算する。エントロピー変化が大きい位置は、特定の基準表現への「context sharpening」や、複数表現への「context spreading」を示す。著者らは前者が表現の暗記を促しやすいと解釈し、エントロピー変化分布の低い側だけを残すposition maskingを行う。
- **どうやって有効だと検証した？**: 主観的・客観的な評価サブカテゴリで、提案する自己蒸留judgeをnaiveな自己蒸留およびoutcome-supervised RLと比較。abstract上では、主観的サブカテゴリでRLより2〜9ポイント改善し、客観的タスクでも競争力を維持したと報告している。データセット、モデル、評価指標、細かな実験条件はメタデータからは不明。
- **議論はある？**: エントロピー変化の大きい位置を「暗記寄り」と解釈する因果的根拠は要確認。また、OOD性能の改善がどの評価基準・モデル規模・分布差に依存するか、masking閾値の感度、teacherとstudentの同一性によるバイアス、評価理由自体の品質についてはPDF本文での確認が必要。
- **次に読む/試すなら**: 1. 論文本文でposition maskingの閾値設計とアブレーションを確認する。 2. 小規模judgeモデルで、全位置蒸留・低エントロピー変化位置のみ・ランダムマスクを比較する。 3. 未知の評価基準や言い換えに対するOODテストを追加する。
- **キーワード**: `LLM judges`, `self-distillation`, `language feedback`, `position masking`, `entropy shift`, `OOD generalization`

## 気になったこと

- 「低いエントロピー変化を残す」ことが、なぜ特定表現の暗記を抑えつつ意味理解を促すのか。
- 評価理由の生成品質や長さが、位置ごとの蒸留信号に与える影響。
- 2〜9ポイントの改善が、どの主観的評価サブカテゴリとベースラインで得られたものか。
- 評価理由を使わない通常のSFTや、外部teacherによる蒸留との比較があるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは؟
---

## 追加で聞く

- Chat prompt: [hong2026-vg-training-llm-judges-from-language-feedback-via-position-sele-be2b1a68.md](../../chat/2026-10-03/hong2026-vg-training-llm-judges-from-language-feedback-via-position-sele-be2b1a68.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
