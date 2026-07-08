# Paperpile Brief 2026-07-09 - Privileged information distillation for language models

## 基本情報

- **タイトル**: Privileged information distillation for language models
- **著者**: Emiliano Penaloza, Dheeraj Vattikonda, Nicolas Gontier, Alexandre Lacoste, Laurent Charlin, Massimo Caccia
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: メタデータからは不明（DOI / arXiv ID / URLなし）

## 落合陽一フォーマット

- **ひとことでいうと**: 推論時には使えない privileged information を訓練時だけ使い、multi-turn agentic task で frontier model の行動能力を小さい/制約付き student に蒸留する手法の論文。
- **先行研究と比べてどこがすごい？**: 通常の蒸留は Chain-of-Thought や推論過程の supervision を仮定しがちだが、この論文は「成功した行動軌跡だけ見えるが、内部推論は見えない」状況を扱う。`pi-Distill` と `OPSD` により、CoT supervision がなくても action-only PI から学習でき、SFT followed by RL という標準的手法を複数条件で上回ると主張している。
- **技術や手法の肝はどこ？**: `pi-Distill` は PI-conditioned teacher と unconditioned student を同じモデル内で同時に訓練する joint teacher-student objective。`OPSD` は RL に、student と PI-conditioned teacher の reverse KL penalty を加える on-policy self-distillation。要するに、訓練時だけ見える追加情報で teacher の行動分布を強くし、それを推論時に PI を持たない student へ押し込む設計。
- **どうやって有効だと検証した？**: abstract ベースでは、複数の agentic benchmark、複数モデル、複数種類の PI で評価し、`pi-Distill` と一部条件で `OPSD` が SFT+RL 系の標準手法を上回るとされている。PDF本文がないため、具体的な benchmark 名、モデルサイズ、報酬設計、統計的有意性、数値差はメタデータからは不明。
- **議論はある？**: PI がどの程度 teacher の有用な行動分布を作れるかに強く依存しそう。action-only で学べるという主張は重要だが、失敗軌跡、探索の偏り、teacher/student が同じモデルであることの影響、reverse KL の安定性、frontier agent の再現可能性は本文確認が必要。PDF本文がないため、限界や ablation の詳細はメタデータからは不明。
- **次に読む/試すなら**: `pi-Distill` の objective 定義を確認する。OPSD の reverse KL penalty がどの policy に対して計算されるか確認する。手元の agentic benchmark で「PIあり teacher / PIなし student」の最小実験を組む。
- **キーワード**: `privileged information`, `knowledge distillation`, `language agents`, `reinforcement learning`, `reverse KL`, `chain-of-thought distillation`

## 気になったこと

- PI の具体例が何か。環境状態、正解軌跡、隠れた reasoning、oracle feedback のどれに近いのか。
- `same model` で teacher/student を同時訓練する設計が、単なる multi-task learning とどう違うのか。
- CoT supervision なしで SFT+RL を上回るなら、どのタスクで差が最大化するのか。
- OPSD が competitive になる条件と、`pi-Distill` に負ける条件の境界。
- 実装時に PI-conditioned teacher の入力形式をどう切り替えるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [penaloza2026-wc-privileged-information-distillation-for-language-models-a84477bb.md](../../chat/2026-07-09/penaloza2026-wc-privileged-information-distillation-for-language-models-a84477bb.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
