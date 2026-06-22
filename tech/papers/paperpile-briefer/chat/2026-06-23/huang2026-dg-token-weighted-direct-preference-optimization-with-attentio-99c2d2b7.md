# Chat Prompt 2026-06-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Token-weighted direct Preference Optimization with attention

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-23 - Token-weighted Direct Preference Optimization with Attention

## 基本情報

- **タイトル**: Token-weighted Direct Preference Optimization with Attention
- **著者**: Chengyu Huang, Zhuohang Li, Sheng-Yen Chou, Claire Cardie
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2605.21883 / GitHub: https://github.com/HCY123902/AttentionPO

## 落合陽一フォーマット

- **ひとことでいうと**: DPOが応答中の全トークンを同じ重みで扱う問題に対し、LLM自身のattentionを使って重要トークンに重みを付けるPreference Optimization手法を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のtoken-level POは位置ヒューリスティックや追加モデルによる重要度推定に依存しがちだが、AttentionPOは参照LLM自身をpairwise judgeとして使い、その判定トークンから応答トークンへのattentionを重みにする。内容依存で、追加学習モデルなし、1例あたり追加forward passは2回。
- **技術や手法の肝はどこ？**: TwDPOとして、DPOのlog probability ratioをトークン重み付き和に置き換える。AttentionPOでは、好ましい応答と好ましくない応答の順序を入れ替えて2回judge promptを投げ、判定出力トークンから各応答トークンへのattentionを抽出し、平均化・正規化・attention sink補正をして訓練重みに使う。
- **どうやって有効だと検証した？**: LLaMA-3-8B-Base-SFTとLLaMA-3-8B-Instructを対象に、UltraFeedback系データで訓練し、AlpacaEval、MT-Bench、ArenaHardで評価。DPO、TDPO、TI-DPO、IPO、CPO、KTO、ORPO、R-DPO、SimPOなどと比較し、全体平均ランクで最良。Base-SFTではAlpacaEval、MT-Bench、ArenaHardでベースから大きく改善し、Instruct設定でもAlpacaEvalとMT-Benchで強い結果。
- **議論はある？**: attentionが本当に「重要度」かは未解決で、論文も解釈可能性を強く仮定していない。大規模モデルでの検証はなく、instruction-following中心。どのlayer/headのattentionを使うべきかの探索空間も大きく、モデル依存の可能性がある。
- **次に読む/試すなら**: AttentionPOの実装を確認してDPO訓練ループへの差分を見る。自前のDPO実験でlast-layer attention重みとuniform重みを比較する。attention head選択やattention rolloutがなぜ効かないかを小規模に再検証する。
- **キーワード**: `DPO`, `Preference Optimization`, `token-level credit assignment`, `attention weights`, `RLHF`, `LLM alignment`

## 気になったこと

- attention重みが「人間選好への寄与」ではなくjudge prompt固有の癖を拾っている可能性はどの程度あるか。
- first/last layerが良く、middle layerが悪い理由を、attentionの意味論ではなく勾配・表層特徴の観点で説明できるか。
- token matchingで未対応トークンに0重みを割り当てる設計が、長文・コード・数式応答で悪影響を出さないか。
- GPT-4o-mini judgeによる評価が、AttentionPOの出力スタイルと相性よく偏っていないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
