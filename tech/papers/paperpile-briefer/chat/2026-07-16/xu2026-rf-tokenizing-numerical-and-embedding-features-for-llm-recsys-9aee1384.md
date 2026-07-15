# Chat Prompt 2026-07-16

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Tokenizing Numerical and Embedding Features for {LLM} {RecSys}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-16 - Tokenizing Numerical and Embedding Features for LLM RecSys

## 基本情報

- **タイトル**: Tokenizing Numerical and Embedding Features for LLM RecSys
- **著者**: Zhe Xu, Ankit Peshin, Chiyu Zhang, Feng Qi, Johnson Lui, Anil Ramakrishna, Justin Johnson, Carl Hu, Kaushik Rangadurai, Luke Simon
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: https://arxiv.org/abs/2607.10016v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMベース推薦モデルに、テキストだけでなく数値特徴量と埋め込み特徴量をsoft tokenとして直接食わせるための推薦モデル設計。
- **先行研究と比べてどこがすごい？**: 既存のLLM RecSysは特徴量をテキスト化・離散化・後段利用しがちだが、この論文は連続値の価格やdense embeddingをLLM embedding空間のtokenとして扱う。単純連結ではなく、embedding soft tokenとnumerical soft tokenをTransformerで事前に相互作用させる点が差分。
- **技術や手法の肝はどこ？**: Qwen3-0.6Bを共有パラメータのtwo-tower retrieval backboneにし、Qwen3-4Bで作ったrich prompt embeddingをQ-Formerで固定長soft tokenに圧縮する。価格などの数値特徴はFourier featuresで符号化し、別のQ-Formerでnumerical soft token化する。最後に両soft tokenをfusion moduleで相互作用させ、text tokenと一緒にLLMへ挿入する。
- **どうやって有効だと検証した？**: Amazon Product ReviewsのBeauty、Sports and Outdoors、Toys and Gamesで、Recall@5/10とNDCG@5/10を評価。text-only、embeddingのみ、numericalのみ、単純連結、interaction fusionを比較し、interaction-based fusionが多くの指標で最良。TIGERなど既存baselineとも比較し、特にToys and GamesではR@5/R@10/NDCGで明確に上回る。
- **議論はある？**: 実験はAmazonの3カテゴリと価格特徴中心で、実産業規模・多種特徴量・大規模backboneでの挙動は未検証。TIGERに対してBeauty/SportsではNDCG系で必ずしも勝っておらず、ランキング上位精度では課題が残る。PDF本文上ではpreprint / under reviewであり、査読済みではない。
- **次に読む/試すなら**: 自前RecSysの連続特徴量をsoft token化する最小実験を組む。Q-Former vs MLP、Fourier数値表現 vs tokenizer表現のablationを再現する。TIGERやSASRec系baselineとの評価プロトコル差を確認する。
- **キーワード**: `LLM RecSys`, `soft token`, `two-tower retrieval`, `Q-Former`, `Fourier features`, `numerical features`, `embedding features`

## 気になったこと

- 価格以外の数値特徴量、カテゴリID、ユーザー統計量、画像・音声embeddingにも同じfusion設計が効くのか。
- Qwen3-4Bでrich prompt embeddingを事前計算するコストが、実運用のretrieval pipelineで許容できるのか。
- interaction-based fusionの最適なattention方向がデータセット依存なので、validationでどれくらい安定して選べるのか。
- 単純連結が悪化する原因が、token干渉なのか、soft token数・位置・スケールの問題なのかを追加で見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
