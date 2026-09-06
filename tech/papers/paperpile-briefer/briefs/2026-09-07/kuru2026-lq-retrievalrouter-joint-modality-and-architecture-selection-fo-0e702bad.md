# Paperpile Brief 2026-09-07 - RetrievalRouter: Joint Modality and Architecture Selection for Document Retrieval

## 基本情報

- **タイトル**: RetrievalRouter: Joint Modality and Architecture Selection for Document Retrieval
- **著者**: Emre Kuru, Mehmet Onur Keskin, Reza Farahbakhsh, Noel Crespi
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: [arXiv PDF](https://arxiv.org/pdf/2608.25625) / [コード・データ](https://github.com/emrekuruu/retrieval-router)

## 落合陽一フォーマット

- **ひとことでいうと**: クエリごとに、テキスト／マルチモーダルとDense／Late Interactionをまたいで最適な文書検索パイプラインを選び、精度とレイテンシのトレードオフを動的に改善するルータを提案した論文。
- **先行研究と比べてどこがすごい？**: 単一コーパス上で検索器を切り替える既存手法に対し、モダリティとアーキテクチャを同時に選ぶ。固定構成ではなくクエリ単位で「必要十分に高価な」検索器を使い、最良の静的ベースライン（ML）よりnDCG@5を2.5%改善しつつ12.4倍高速と報告する。
- **技術や手法の肝はどこ？**: BM25、Text-Dense、Text-Rerank、Multimodal-Dense、Multimodal-Rerankの5アームから、クエリ文だけを入力に選択する。Qwen3-0.6B-BaseへLoRAを適用し、各検索器のクエリ別nDCG@5と正規化レイテンシを重みλで合成した報酬を、soft targetとしてKL divergenceで学習する。単一の勝者ラベルではなく報酬分布を学ぶため、同点の多い検索器選択のラベルノイズを抑える。
- **どうやって有効だと検証した？**: 金融・科学・オープンドメインを含む11ベンチマーク、8万超クエリで評価した。全手法をNVIDIA H100上で測定し、nDCG@5、MRR@5、Recall@5、平均・P95レイテンシを比較。λ=0.1ではnDCG@5 0.755、平均0.666秒で、静的なLate Interaction系を精度・速度の両面で上回ったとする。既存の適応的選択法より、精度重視設定で有意に高いnDCG@5を示した。
- **議論はある？**: 全検索器のインデックスを常駐させる必要があり、約40GBのVRAMと大きなストレージを要する。評価は各データセット内の80/10/10分割であり、未知ドメインへのゼロショット一般化は未検証。さらにクエリ本文だけでは対象文書のレイアウトを判別できないため、Oracleとの間に大きなギャップが残る。報告値は各λにつき単一seedの学習実行に基づく。
- **次に読む/試すなら**:
  1. コードと公開されたクエリ別Oracleラベルを用い、自分の文書コーパスでルータの再現実験を行う。
  2. ルーティング前に軽量検索や文書メタデータ参照を挟み、クエリのみでは解けない視覚・レイアウト曖昧性を減らせるか検証する。
  3. LLM rerankerや生成モデルのサイズ選択までアクション空間を拡張したcompound AIとして比較する。
- **キーワード**: `document retrieval`, `query routing`, `multimodal retrieval`, `late interaction`, `accuracy-latency trade-off`, `LoRA`

## 気になったこと

- 「全静的ベースラインを支配する」という主張は、複数インデックスを保持するVRAM・ストレージ費用をレイテンシ評価へどう織り込むかで実運用上の判断が変わる。
- ルータはクエリのみを見るため、「5ページの表を要約して」のように文書側の視覚構造が決定的なケースでは原理的に曖昧である。
- 英語の金融・科学・オープンドメイン中心の訓練分布から、日本語文書や社内固有文書へ移植した際の性能はPDF本文からは不明。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [kuru2026-lq-retrievalrouter-joint-modality-and-architecture-selection-fo-0e702bad.md](../../chat/2026-09-07/kuru2026-lq-retrievalrouter-joint-modality-and-architecture-selection-fo-0e702bad.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
