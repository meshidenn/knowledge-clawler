# Chat Prompt 2026-06-04

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {MiniLLM}: On-policy Distillation of large language models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-04 - {MiniLLM}: On-policy Distillation of large language models

## 基本情報

- **タイトル**: {MiniLLM}: On-policy Distillation of large language models
- **著者**: Yuxian Gu, Li Dong, Furu Wei, Minlie Huang
- **年 / venue**: 2023 / arXiv [cs.CL]
- **リンク**: メタデータ上のURL/DOI/arXiv IDは不明。コード・データ・チェックポイント: https://github.com/microsoft/LMOps/tree/main/minillm

## 落合陽一フォーマット

- **ひとことでいうと**: 大規模言語モデルの知識を小さな言語モデルへ蒸留するために、生成モデル向けのon-policy distillation手法「MiniLLM」を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のKDが分類モデルやChatGPT APIの模倣に寄りがちだったのに対し、white-boxなLLMから小型LMへ蒸留する問題を扱う。標準的なforward KLDではなくreverse KLDを使い、教師分布の低確率領域を学生モデルが過大評価する問題を抑える設計が新規性。
- **技術や手法の肝はどこ？**: 生成時の学生モデル自身の分布に沿って学習するon-policy最適化を導出し、reverse KLD目的を実用的に学習する点。これにより、学習時と生成時の分布ずれ、つまりexposure biasを減らす狙いがある。
- **どうやって有効だと検証した？**: instruction-following設定で評価し、ベースラインと比べて応答の精度、全体品質、calibration、長文生成性能、exposure biasの低減を示したとされる。120Mから13Bパラメータまで複数のモデル規模・ファミリでスケールすることも主張している。ただしPDF本文がないため、具体的なデータセット、指標、比較手法、数値差はメタデータからは不明。
- **議論はある？**: PDF本文がないため詳細な限界は不明。abstractベースでは、white-box teacherを前提にしている可能性、reverse KLDが多様性より精密さを優先しやすい可能性、instruction-following以外の汎化、評価の人手依存性、教師モデルの品質に強く依存する点が確認対象。
- **次に読む/試すなら**: GitHub実装でreverse KLDとon-policy samplingの具体的な学習ループを確認する。 / forward KLD、sequence-level KD、DPO/RLHF系の目的関数と比較する。 / 小型モデルでinstruction tuning用の最小再現実験を組む。
- **キーワード**: `knowledge distillation`, `large language models`, `reverse KLD`, `on-policy distillation`, `instruction following`, `MiniLLM`

## 気になったこと

- reverse KLDにすると、応答の多様性や創造性がどの程度落ちるのか。
- on-policy最適化の計算コストは通常のKDと比べてどれくらい増えるのか。
- teacherとstudentのtokenizerやモデルファミリが異なる場合に、蒸留がどれだけ安定するのか。
- calibrationやlong-text generationの評価指標が何で、どのベースラインに対して改善したのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
