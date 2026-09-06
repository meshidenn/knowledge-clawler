# Paperpile Brief 2026-09-07 - Avey-B

## 基本情報

- **タイトル**: Avey-B
- **著者**: Devang Acharya, Mohammad Hammoud
- **年 / venue**: 2026 / ICLR 2026（arXiv:2602.15814）
- **リンク**: [arXiv PDF](https://arxiv.org/pdf/2602.15814)、[実装](https://github.avey.ai/avey-b)

## 落合陽一フォーマット

- **ひとことでいうと**: 自己注意を使わず、関連する文書断片だけを検索・圧縮して処理する長文向け双方向encoder、Avey-Bを提案した論文。
- **先行研究と比べてどこがすごい？**: BERT、RoBERTa、ModernBERT、NeoBERTと比較し、token classificationと情報検索で一貫して高い性能を報告する。ModernBERTより約11倍少ない事前学習トークンでも競争力を示し、96KトークンではModernBERT比3.38倍、NeoBERT比11.63倍高速とする。
- **技術や手法の肝はどこ？**: 入力をsplitに分割し、MaxSimで関連splitをtop-k検索する。各splitは、(1) 静的な学習済み射影と動的なcosine類似度を層で分離、(2) 動的類似度を行方向に正規化して安定化、(3) 検索した文脈を元のsplit長へニューラル圧縮してから処理する。これにより、attentionの全トークン間演算を避けつつ両方向の文脈を取り込む。
- **どうやって有効だと検証した？**: FineWeb由来の180Bトークンで事前学習したbase/largeモデルを、分類（MNLI、QQP、SST-2）、token classification（CoNLL-2003、OntoNotes、UNER）、QA（ReCoRD、SQuAD、SQuAD v2）、検索（MLDR、MS MARCO、NQ）で評価した。各学習率を10 seedで試し中央値を報告し、NVIDIA H200・batch size 8で128〜96Kトークンのレイテンシとthroughputも比較した。設計要素ごとのablationも実施している。
- **議論はある？**: 高速化の中心はneural processorだが、全split間の関連度を求めるranker自体は漸近的に $O(N^2d)$ とされ、完全な線形計算量ではない。長文での品質評価は主にsyntheticなneedle-in-a-haystackであり、実運用の超長文タスクへの一般化は追加検証が必要。比較対象・実験設定・実装は公開予定／公開済みとされるが、独立再現は未検証である。
- **次に読む/試すなら**:
  1. 公開実装でrankerとcompressionの実測コストを分離して計測する。
  2. 長文検索・RAGの実データで、96K級の品質と速度をTransformer encoderと比較する。
  3. top-k、split長、rankerの近似検索が精度・メモリ・計算量へ与える影響をablationする。
- **キーワード**: `attention-free encoder`, `long-context NLP`, `retrieval-conditioned architecture`, `bidirectional encoding`, `neural compression`

## 気になったこと

- rankerの $O(N^2d)$ コストが、長さ・GPU・batch sizeごとの実測でどの時点から支配的になるか。
- 圧縮した関連splitが、固有表現認識やQAで必要な細粒度証拠をどの程度失うか。
- 英語中心の事前学習・評価から、多言語や専門領域の長文検索へどこまで転移できるか。
- 96Kトークンでの高速性は示されているが、同程度の長さにおける実タスク品質の比較は追加で確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [acharya2026-nw-avey-b-1d6f38d2.md](../../chat/2026-09-07/acharya2026-nw-avey-b-1d6f38d2.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
