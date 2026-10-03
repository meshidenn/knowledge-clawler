# Paperpile Brief 2026-10-01 - Allspark: Weak to strong transfer via alternating chain of thought

## 基本情報

- **タイトル**: Allspark: Weak to strong transfer via alternating chain of thought
- **著者**: Kaizhao Liang, Junxiong Wang, Chen Liang, Zhendong Wang, Qiang Liu
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: 弱いモデルの推論能力を、強いモデルのロールアウトなしで強いモデルへ移転する、交互思考連鎖ベースの訓練・推論フレームワークを提案した。
- **先行研究と比べてどこがすごい？**: 大規模モデル自身の高コストなロールアウトを訓練に使わず、弱い教師モデルを再利用して複数の強い学生モデルへ転移できる点が新しい。テキストを介して通信するため、異なるモデル系列やTokenizer間でも適用できる。
- **技術や手法の肝はどこ？**: 弱い教師モデルを、同一モデルの凍結コピーと並行して訓練する。両者が推論過程のセグメントを交互に生成し、最後の回答は凍結モデルが出力する。推論時には訓練時の凍結モデルを、より強い学生モデルに置き換え、両モデルを固定したまま交互に思考させる。
- **どうやって有効だと検証した？**: Qwenを用いた数学・推論タスクでの制御実験と、ARC-AGI-2を用いた大規模なInkling実験を実施した。モデル系列内だけでなく、KimiやNemotronへのクロスファミリー転移も調べ、推論設定ごとの精度向上とトークン数とのトレードオフを評価した。細かな数値や比較条件はPDF本文がないため、メタデータからは不明。
- **議論はある？**: 効果は推論設定によって変わる。また、弱い教師がどの条件で強い学生を改善できるのか、転移可能性の限界、追加トークン消費との費用対効果は要検証である。PDF本文がないため、実験規模・統計的有意性・再現手順はメタデータからは不明。
- **次に読む/試すなら**:
  1. Allsparkの交互生成プロトコルを最小構成で実装し、弱い教師と強い学生の組み合わせを比較する。
  2. 同一モデル系列と異なる系列で、精度向上・推論トークン数・レイテンシを測定する。
  3. ARC-AGI-2や数学ベンチマークで、教師の訓練量と転移性能の関係を調べる。
- **キーワード**: `weak-to-strong transfer`, `alternating chain of thought`, `reinforcement learning`, `reasoning`, `cross-family transfer`

## 気になったこと

- 弱い教師モデルはどの程度の性能・訓練量で、強い学生への転移効果を持つのか。
- 交互に生成するセグメント長やターン数は、精度とトークンコストにどう影響するのか。
- 強いモデルを固定したまま使う場合、通常の蒸留や自己改善と比べて何が本質的に異なるのか。
- KimiやNemotronへの転移で、モデル系列やTokenizerの違いがどの程度ボトルネックになるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [liang2026-tm-allspark-weak-to-strong-transfer-via-alternating-chain-of-t-7d645e09.md](../../chat/2026-10-01/liang2026-tm-allspark-weak-to-strong-transfer-via-alternating-chain-of-t-7d645e09.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
