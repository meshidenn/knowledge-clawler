# Paperpile Brief 2026-10-03 - Retrieval capacity of self-attention under competition

## 基本情報

- **タイトル**: Retrieval capacity of self-attention under competition
- **著者**: Timur Mudarisov, Mikhail Burtsev, Radu State
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2609.37879v1

## 落合陽一フォーマット

- **ひとことでいうと**: Self-attentionが実際に必要とする文脈トークン数を、重要度の高いトークンだけを残したときのNLL増加から測定する手法を提案した論文。PDF本文は取得できておらず、以下はabstractベース。
- **先行研究と比べてどこがすごい？**: 「モデルが文脈全体を使うのか」という問いを、attention上位トークンによる有効attention集合のサイズとして定量化する。ランダム選択よりattentionベース選択が有効で、必要な集合サイズはモデルや文脈長、トークン間競合に依存する。
- **技術や手法の肝はどこ？**: 再学習せず、各head・layer・queryごとにattention重みの上位トークンだけを残し、完全なattentionとのNLL差を測る。保持した重みを再正規化する条件も比較し、単に情報量だけでなく、選択された表現の結合方法が必要集合サイズを左右することを調べる。
- **どうやって有効だと検証した？**: 複数モデルで選択集合のサイズとNLLを比較し、ランダム選択、文脈長の拡張、固定したsupporting factへの背景文追加、重みの再正規化などを評価している。データセット名、モデル構成、細かな数値はメタデータからは不明。
- **議論はある？**: attentionの幾何学的分離が見られても、それだけでloss保存を保証しない。文脈が長くなると必要集合の絶対数は増える一方、文脈に占める割合は減少したという結果も、測定範囲を超えて一般化できるかは不明。attention重みをそのまま保持するか再正規化するかで結論が変わるため、「検索すべき情報量」と「attention集約の制約」を分離する必要がある。
- **次に読む/試すなら**:
  1. 論文本文で、effective attention set sizeの閾値とモデル別の実測値を確認する。
  2. 小規模言語モデルでtop-k attention遮断実験を実装し、NLLと生成品質の変化を測る。
  3. attention上位トークンと実際の因果的寄与を、マスキングやactivation patchingで比較する。
- **キーワード**: `self-attention`, `retrieval capacity`, `attention competition`, `effective context`, `negative log-likelihood`

## 気になったこと

- 「必要集合サイズ」を定義するloss toleranceの選び方で、モデル間比較の結論がどの程度変わるか。
- attention上位トークンを残す方法が、長文理解・needle-in-a-haystack・生成タスクでも成立するか。
- 背景文によるsupporting factの順位低下が、softmaxの競合だけで説明できるのか、それとも表現干渉も含むのか。
- PDF本文がないため、理論モデルの仮定、実験対象モデル、データセット、再現性の詳細は未確認。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [mudarisov2026-wr-retrieval-capacity-of-self-attention-under-competition-ce519f9a.md](../../chat/2026-10-03/mudarisov2026-wr-retrieval-capacity-of-self-attention-under-competition-ce519f9a.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
