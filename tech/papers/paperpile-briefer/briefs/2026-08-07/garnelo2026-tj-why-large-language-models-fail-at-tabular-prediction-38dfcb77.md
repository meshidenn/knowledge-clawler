# Paperpile Brief 2026-08-07 - Why large language models fail at tabular prediction

## 基本情報

- **タイトル**: Why large language models fail at tabular prediction
- **著者**: Marta Garnelo, Wojciech M. Czarnecki
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2608.02412v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMが表形式データのin-context予測で失敗する主因を、ノイズ・CSV形式・数値tokenization・一括予測数・次元数の5仮説で切り分け、次元数の増加だけが決定的な崩壊要因だと示した論文。
- **先行研究と比べてどこがすごい？**: Tabular foundation model分野では「汎用LLMは表に弱い」とされてきたが、この論文は単に性能比較するのでなく、失敗理由を介入実験で検証している。特に、31 benchmark datasetのrandom projection sweepで、9手法中LLMだけが次元増加に伴って精度低下する点を示したのが強い。
- **技術や手法の肝はどこ？**: LLMを「単一promptにtrain/test表を入れ、toolなし・fine-tuningなし・agentなしで一回生成する」純粋な推論器として固定し、5仮説を個別に潰す設計。さらに、2次元ではLLMの予測境界をclassical model群と比較し、Gaussian processや低kのkNNに近い局所距離ベース挙動を示す一方、高次元では252設定の古典モデルでも再現できないと分析している。
- **どうやって有効だと検証した？**: UCI/scikit-learn由来の小規模tabular分類データとsynthetic datasetを使い、memorisation probeで既知データ混入を検出して除外。H1-H4については分離度操作、正解列を混ぜるneedle-in-haystack、decimal precision変更、test batch分割で検証し、いずれも主要因ではないと判断。H5ではrandom projectionで次元数を変え、LLMだけが次元増加で悪化することを確認した。
- **議論はある？**: 主実験は主にClaude Opus 4.6に依存し、Qwenは2D確認に限られるため、将来モデルや全LLM一般への外挿は注意が必要。解析はbehavioralであり、内部機構やactivation/circuitの説明ではない。また、実験はtoy-scale tableに限られるが、これはraw tableをpromptに入れる方式自体のcontext/cost限界でもある。
- **次に読む/試すなら**: 1. TabPFN / TabICL / Nexusなどpurpose-built tabular foundation modelと比較する。 2. 自分のtabular taskで列数をrandom projectionやfeature subsetで変え、LLM精度の崩れ方を再現する。 3. LLMに直接表予測させるより、特徴量設計・モデル選択・コード生成補助に使う設計へ切り替える。
- **キーワード**: `tabular prediction`, `in-context learning`, `LLM`, `dimensionality`, `random projection`, `Gaussian process`, `kNN`, `tabular foundation models`

## 気になったこと

- 「次元数が増えると崩壊する」原因がattentionの構造、training distribution、数値表現、列間関係の探索能力のどれに由来するのかは未解明。
- random projectionで情報量を概ね保つという前提は妥当そうだが、LLMにとっての「列の意味のなさ」が追加で不利に働いていないか確認したい。
- 実務ではLLM単体分類ではなく、LLMが特徴量説明やmodel card生成、EDA、AutoML orchestrationを担当する構成ならどこまで有効かを試したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [garnelo2026-tj-why-large-language-models-fail-at-tabular-prediction-38dfcb77.md](../../chat/2026-08-07/garnelo2026-tj-why-large-language-models-fail-at-tabular-prediction-38dfcb77.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
