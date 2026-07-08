# Paperpile Brief 2026-07-09 - Logit-Contribution Scoring identifies non-literal retrieval heads

## 基本情報

- **タイトル**: Logit-Contribution Scoring identifies non-literal retrieval heads
- **著者**: Aryo Pradipta Gema, Beatrice Alex, Pasquale Minervini
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.01002

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの長文文脈検索で、文字列をそのままコピーするのではなく意味を合成して答える「non-literal retrieval」に効くattention headを、OV circuitが答えlogitへどれだけ寄与するかで特定する論文。
- **先行研究と比べてどこがすごい？**: 従来のretrieval head検出は「どこを読んだか」、特にattended tokenと生成tokenの一致に寄りすぎていた。本研究は「読んだ情報を何として書き込むか」を見るため、Eiffel Towerを読んでYukiを出すような非リテラル検索headを拾える。Qwen3、Gemma-3、OLMo-3.1で、LOCOS上位headをmean ablationするとNoLiMaのROUGE-Lが既存attention-based手法より少ないhead数で大きく崩れる。
- **技術や手法の肝はどこ？**: Logit-Contribution Scoring、略してLOCOS。各headのsource positionごとの出力 `alpha * W_O v` を、正解answer tokenのunembedding方向に射影し、そのlogit contributionを測る。さらにneedle領域とoff-needle領域の寄与を同一forward pass内で比較するspatial contrastを使い、単に広く効くheadではなく、needle由来で答え方向に書き込むheadをスコア化する。
- **どうやって有効だと検証した？**: NoLiMaのnon-literal retrieval benchmarkで、Qwen3 8B/14B/32B、Gemma-3 12B/27B、OLMo-3.1 32Bを評価。上位LOCOS headをmean ablationし、ROUGE-L低下をRandom、Wu/NIAH-scored、Wu/NoLiMa-scoredなどと比較した。Qwen3-8Bではtop-50 LOCOS head ablationでROUGE-Lが0.401から0.000へ落ち、強いbaselineは0.292を維持した。MuSiQueやBABI-Longでも低下が確認され、parametric recallや算術では大きく崩れないためretrieval特異性も示している。
- **議論はある？**: 白箱アクセス、attention weights、value cache、unembedding方向へのprojectionが必要なので、通常のAPI越しには使いにくい。評価は英語中心で、多言語・方言・domain shiftへの一般化は未検証。Gemma-3-27Bではattention-only controlが一部深いablationでLOCOSを上回るなど、OV projectionが常に最大効果を出すわけではない。PDF抽出からは実装コスト、モデルサイズごとの安定性、closed model適用の詳細は限定的。
- **次に読む/試すなら**: NoLiMaの具体的なデータ生成と評価設定を確認する。公開repo `https://github.com/aryopg/locos` でQwen3-8BのLOCOS score再現を試す。KV cache compressionやRAG hallucination検出にLOCOS scoreを使えるか検討する。
- **キーワード**: `mechanistic interpretability`, `retrieval heads`, `non-literal retrieval`, `OV circuit`, `logit attribution`, `long-context LLM`

## 気になったこと

- LOCOSで見つかるheadは、モデルfamilyを跨いで同じ層・KV group付近に集中するのか。
- answer-token unembedding方向へのprojectionだけで、多token answerや言い換え生成をどこまで正しく扱えるのか。
- top head ablationで性能が崩れることは示されているが、逆にLOCOS headだけを残す圧縮で性能をどこまで維持できるか。
- non-literal retrieval以外のreasoning、たとえばmulti-hop合成や照応解決でも同じhead群が効くのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [gema2026-sm-logit-contribution-scoring-identifies-non-literal-retrieval-09438550.md](../../chat/2026-07-09/gema2026-sm-logit-contribution-scoring-identifies-non-literal-retrieval-09438550.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
