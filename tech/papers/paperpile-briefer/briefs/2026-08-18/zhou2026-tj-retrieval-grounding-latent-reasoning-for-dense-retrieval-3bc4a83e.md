# Paperpile Brief 2026-08-18 - Retrieval Grounding Latent Reasoning for dense retrieval

## 基本情報

- **タイトル**: Retrieval Grounding Latent Reasoning for dense retrieval
- **著者**: Gang Zhou, Xiongxi Yu, Hu Tian, Yang Wei, Lu Pan, Ke Zeng, Shibiao Xu, Xiaolong Zheng
- **年 / venue**: 2026 / arXiv [cs.AI]（arXiv:2608.14107v1）
- **リンク**: https://arxiv.org/abs/2608.14107v1

## 落合陽一フォーマット

- **ひとことでいうと**: Dense retrievalの潜在的な推論過程を、「最終的に当たる」だけでなく各推論段階が実際にランキングを改善するように学習させた手法RGLT。
- **先行研究と比べてどこがすごい？**: 既存のlatent reasoning retrieverは最終検索性能や中間状態の類似度を教師にしがちだった。本研究は、明示CoTの各段階が正解文書をhard negativeより上位へ動かした量をlatent state遷移へ転写する。BRIGHTでnDCG@10 34.20、Recall@10 39.97を報告し、LaSERを上回る一方、推論時は1.12倍の遅延に留める。
- **技術や手法の肝はどこ？**: クエリと検索instructionから作るanchor表現で、固定長のsilent token列を条件付ける。全silent tokenを一回のforward passで処理し、その最終状態をquery embeddingとして使う。学習では、(1) 段階化した明示CoTの累積再構成、(2) 各段階の直接的な対照検索損失、(3) 明示CoT段階ごとのランキング改善量をlatent遷移に一致させるretrieval-effect creditを組み合わせる。
- **どうやって有効だと検証した？**: ReasonEmbed由来の81,659件で学習し、BRIGHT、FollowIR、BrowseComp-Plusで標準・明示推論・潜在推論retrieverと比較した。BRIGHTではlatent段階を進めるほどnDCG@10が26.39から34.20へ上昇。retrieval-effect matchingを除くと31.26まで低下し、段階的なランキング改善の教師が効いていることを示す。A100上で24.0 ms/queryで、明示CoT生成方式の約4,000 ms/queryより大幅に高速とする。
- **議論はある？**: 明示CoTの段階分割は、見出しや文境界に依存し、不規則なCoTでは等分割へフォールバックするため教師信号の品質が課題になり得る。評価は推論集約型ベンチマーク中心で、一般的な検索や多言語検索への一般化は本文からは不明。外部LLM生成CoTと長いCoT（最大8,192 token）を訓練に使うため、学習コストとCoT生成品質への依存も要確認。
- **次に読む/試すなら**:
  1. LaSERとReasonEmbedを読み、中間state alignmentとretrieval-effect supervisionの差を比較する。
  2. 既存dual encoderに16個程度のsilent tokenを追加し、段階別nDCGの単調改善を再現する。
  3. CoT分割方法・hard negativeの選び方を変え、改善量教師の頑健性を測る。
- **キーワード**: `dense retrieval`, `latent reasoning`, `chain-of-thought distillation`, `retrieval-effect credit assignment`, `instruction-conditioned embedding`

## 気になったこと

- 段階ごとの「ランキング改善量」が、CoTの文章品質ではなく真に必要な推論ステップを測れているか。
- 4段階・16 silent tokenという設計は他のモデル規模、タスク、言語でも最適か。
- FollowIRでは平均スコアは高い一方でp-MRR改善が限定的に見える。instruction変更への追従性能を個別タスク別に確認したい。
- 学習時の明示CoTをどの外部LLMが生成し、その誤りや偏りが最終retrieverへどう伝播するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhou2026-tj-retrieval-grounding-latent-reasoning-for-dense-retrieval-3bc4a83e.md](../../chat/2026-08-18/zhou2026-tj-retrieval-grounding-latent-reasoning-for-dense-retrieval-3bc4a83e.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
