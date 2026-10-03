# Paperpile Brief 2026-09-30 - Operationalising representation in natural language processing

## 基本情報

- **タイトル**: Operationalising representation in natural language processing
- **著者**: Jacqueline Harding
- **年 / venue**: 2023 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2306.08193

## 落合陽一フォーマット

- **ひとことでいうと**: NLPモデルの内部表現が、入力の特定の性質を本当に「表現している」と言える条件を、哲学的な議論と probing classifier に基づいて具体化した論文。
- **先行研究と比べてどこがすごい？**: 内部状態に情報が含まれているだけの「表現」と、モデルの予測に実際に使われる因果的な表現を区別した点。Information、Use、Misrepresentation の3基準を提示し、probeの精度だけに依存しない評価枠組みを提案する。
- **技術や手法の肝はどこ？**: 活性化ベクトルに介入し、対象性質の情報だけを削除する `ablate` intervention、別の性質の情報を保つ `control condition`、モデルの解釈を正しいラベル分布へ近づける `modify` / `correct` intervention を定義する。probeはモデルが情報をどう利用し得るかの代理（proxy）として位置づけられる。
- **どうやって有効だと検証した？**: BERTの品詞判断やGPT-3の共参照解決などを例に、提案基準を probing、活性化操作、下流出力の変化へ落とし込む方法を示した。論文の主な貢献は実験結果ではなく、既存の probing・介入研究を整理する概念的／方法論的枠組みである。
- **議論はある？**: PDF本文に基づくと、成功したprobeをどこまで「下流システムの代理」と見なせるか、probeの線形性・サイズ制約、他の情報を保ったまま対象情報だけを操作できるかが未解決。介入が完全な control condition を満たすことも難しく、実際には近似が必要である。提案された条件を満たせば表現が証明されるというより、モデルやタスクごとに慎重な設計と検証が必要になる。
- **次に読む/試すなら**:
  1. 手元のTransformerで、probe精度と活性化アブレーション後のタスク性能を比較する。
  2. 対象属性以外のprobe予測を保つ control condition を評価する。
  3. probing の限界と causal interpretability に関する関連研究を読む。
- **キーワード**: `representation`, `probing classifiers`, `causal intervention`, `interpretability`, `misrepresentation`

## 気になったこと

- 「下流システムの解釈」を、複数の成功probeの予測で近似する場合、probeの選び方によって結論がどの程度変わるのか。
- 対象属性の情報を削除した結果、性能が落ちても、それが本当にその属性の利用を示すのか、それとも介入による副作用なのか。
- modify intervention を大規模言語モデルの実際の残差ストリームへ適用したとき、他の意味・構文情報をどの程度維持できるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [harding2023-qn-operationalising-representation-in-natural-language-proce-a656c088.md](../../chat/2026-09-30/harding2023-qn-operationalising-representation-in-natural-language-proce-a656c088.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
