# Paperpile Brief 2026-06-09 - OPRD: On-Policy Representation Distillation

## 基本情報

- **タイトル**: OPRD: On-Policy Representation Distillation
- **著者**: Shenzhi Yang, Guangcheng Zhu, Bowen Song, Haobo Wang, Mingxuan Xia, Xing Zheng, Yingfan Ma, Zhongqi Chen, Weiqiang Wang, Gang Chen
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2606.06021

## 落合陽一フォーマット

- **ひとことでいうと**: on-policy distillationを次トークン確率の出力空間ではなく、教師モデルと生徒モデルの中間hidden stateを揃える表現空間の蒸留として再設計した論文。
- **先行研究と比べてどこがすごい？**: 従来のOPDはsampled-token / full-vocabulary / top-kの違いはあっても、すべてLM head後の出力分布を合わせる設計だった。OPRDはLM headを迂回して選択層・選択位置のhidden representationを直接合わせることで、サンプリング分散をなくし、教師の中間表現情報を使える点が新しい。AIME 2024/2025、AIMOで教師とのギャップをほぼ閉じ、top-k OPDより1.44倍高速、actor-update時の一時メモリを最大54%削減したと報告している。
- **技術や手法の肝はどこ？**: 生徒が自分で生成したon-policy rolloutに対して、同じ入力列を教師にも通し、対応する層・応答位置のhidden stateを正規化MSEで一致させる。出力語彙全体のlogitやsoftmax KLを計算しないため、巨大語彙に由来するMonte Carlo KL推定のノイズと `[B, T, |V|]` テンソルのコストを避ける。本文では、特に応答末尾側に生徒と教師の表現差が集中する観察から、last-k tokenを重点的に監督する設計も使っている。
- **どうやって有効だと検証した？**: R1-distill-1.5B生徒モデルとJustRL-1.5B教師モデルを中心に、同一rollout・同一ハードウェア条件でOPD top-1、OPD top-16、OPRDを比較している。評価はAIME 2024、AIME 2025、AIMOなどの数学ベンチマーク。さらにwall-clock、GPUメモリ、top-k overlap、hidden state cosine similarity、entropy、policy-gradient lossの推移を分析し、OPRDが後半の停滞を破りやすいことを示している。
- **議論はある？**: 現状のOPRDは同一アーキテクチャ前提が強い。異なるサイズ・構造のモデル間ではhidden stateがほぼ直交し、単純なMSE整合は既存知識を壊す可能性がある。また、層や位置の選び方はlast-kなど経験的なヒューリスティックで、より原理的な重み付けやcross-architecture対応は今後の課題。数値結果はPDF本文ベースだが、抽出テキスト由来のため細かい表の値は断定しすぎないのが安全。
- **次に読む/試すなら**: 1. GitHub実装でOPRD lossがどの層・位置にかかっているか確認する。 2. 既存OPD実装にhidden-state MSEを足す最小実験を作る。 3. 異種モデル間ではprojection headやCKA/contrastive alignmentが必要か調べる。
- **キーワード**: `on-policy distillation`, `representation distillation`, `hidden-state alignment`, `LLM post-training`, `knowledge distillation`, `AIME`

## 気になったこと

- 同一アーキテクチャ制約が実運用でどの程度ボトルネックになるか。
- hidden state MSEの正規化方法、層選択、last-kの値に対する感度。
- OPRD単体とOPD+OPRDのどちらが安定か、タスクや教師品質で変わるか。
- teacher forwardでlogitsを本当に省ける実装にした場合、速度・メモリ削減がさらにどの程度伸びるか。
- 数学推論以外、特にコード生成・対話・長文推論でも同じ末尾表現ギャップが出るか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yang2026-xi-oprd-on-policy-representation-distillation-ddee28ac.md](../../chat/2026-06-09/yang2026-xi-oprd-on-policy-representation-distillation-ddee28ac.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
