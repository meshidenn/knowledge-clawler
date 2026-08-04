# Paperpile Brief 2026-08-05 - Constitutional midtraining: Content presence drives alignment gains

## 基本情報

- **タイトル**: Constitutional midtraining: Content presence drives alignment gains
- **著者**: Desiree Cho, Cameron Tice, Bernie Hogan, Hunar Batra, Puria Radmard, Jun Zhao, Nigel Shadbolt
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.26654 / PDF: https://arxiv.org/pdf/2607.26654.pdf / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのalignmentをpost-trainingだけで入れるのではなく、midtraining段階で「憲法的価値」を含むデータを混ぜると、fine-tuning後も一部のalignment効果が残ることを120B規模で検証した論文。
- **先行研究と比べてどこがすごい？**: constitutional AIやalignment midtrainingの既存研究に対し、post-trainingと切り分けた形でconstitutional midtraining単体の効果を評価している点が差分。120B規模、4条件+control、post-midtraining / post-SFT / post-benign fine-tuningの3段階で耐久性を見ている。特にblackmail評価では、SFT後に全モデルでblackmail傾向が出たが、constitutional midtraining群ではそれが抑えられ、benign fine-tuning後も差が残ったと報告している。
- **技術や手法の肝はどこ？**: AnthropicのConstitutionから40個のconstitutional valuesを抽出し、Sentence-BERT埋め込みの中心性でクラスタリングして、constitutional corpusを構成した点。実験は「curriculum orderingあり/なし」と「deliberative reasoningあり/なし」の2×2設計。明示的な価値推論ブロックを含むDR条件と、それを取り除いたnoDR条件を比較し、さらに価値クラスタを順序立てて入れるcurriculum条件と一様混合条件を比較している。
- **どうやって有効だと検証した？**: Nemotron-3-Super-120B-A12B-Baseを出発点に、4つのconstitutional midtraining条件とcontrolを作り、全条件に同一のvalue-neutral SFTを適用し、さらにGSM8Kでbenign fine-tuningした。評価はID/OOD behavioral pair、alignment under pressure、value conflict resolution、blackmail、emergent misalignment、MASK、alignment fakingなど。能力劣化の確認としてMMLU、ARC-Easy、PIQA、GSM8Kも評価しており、平均的には能力コストなしと報告している。
- **議論はある？**: 効果は一様ではなく、blackmailやdefault behavior系では耐久性が見られる一方、in-context pressureやvalue conflictに能動的に抵抗する必要がある設定では、SFT後に優位性が弱まる。curriculum orderingやdeliberative reasoningの構造よりも、constitutional contentがmidtrainingに存在すること自体の寄与が大きいという結果も示唆的。中心性分析はembedding空間上の近さであり、価値間の因果的・論理的な基礎性を直接測っているわけではない。
- **次に読む/試すなら**: 1. 公開されたcode/data/model checkpointでblackmail評価の再現性を確認する。 2. curriculum orderingとDR/noDRの主効果・交互作用を表で確認する。 3. 自前モデルのcontinual pretrainingに少量のconstitutional corpusを混ぜる最小実験を設計する。
- **キーワード**: `constitutional midtraining`, `alignment durability`, `LLM safety`, `constitutional AI`, `benign fine-tuning`, `blackmail evaluation`

## 気になったこと

- constitutional contentの「存在」が効くなら、どの程度のtoken量まで削っても効果が残るのか。
- blackmailでは効果が残るのに、in-context pressureやvalue conflictでは弱まる理由は表現レベルで説明できるのか。
- DRが明確に効かないなら、reasoning blockは学習信号として冗長なのか、それとも評価設計がその差を拾えていないのか。
- 120B MoEでの結果が、より小さいdense modelやinstruction-tuned baseにどこまで転移するのか。
- Constitution由来の価値セットに依存しており、別のmodel specや組織ポリシーでも同じ傾向になるか確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [cho2026-tv-constitutional-midtraining-content-presence-drives-alignment-e57f65db.md](../../chat/2026-08-05/cho2026-tv-constitutional-midtraining-content-presence-drives-alignment-e57f65db.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
