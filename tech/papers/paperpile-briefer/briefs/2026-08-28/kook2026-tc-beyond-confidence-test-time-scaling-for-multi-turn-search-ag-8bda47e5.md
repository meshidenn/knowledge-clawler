# Paperpile Brief 2026-08-28 - Beyond confidence: Test-time scaling for multi-turn search agents via Retrieval grounding

## 基本情報

- **タイトル**: Beyond confidence: Test-time scaling for multi-turn search agents via Retrieval grounding
- **著者**: Hyunho Kook, Junhyuk So, Tianyu Fu, Haizhong Zheng, Beidi Chen
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.24024v1](https://arxiv.org/abs/2608.24024v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 検索エージェントの複数ロールアウトを投票で統合するとき、LLM内部の確信度ではなく、最終回答が取得文書にどれだけ根拠づけられているかで重み付けするRGVを提案した論文。
- **先行研究と比べてどこがすごい？**: token log probabilityベースの投票が、取得文書のコピーにより過大評価される「copy inflation」を原因まで切り分けた。追加LLM呼び出しやfine-tuningなしで、DeepConfを最大+5.4ポイント上回り、少数の正解ロールアウトしかない問題では最大+35%改善した。
- **技術や手法の肝はどこ？**: 各ロールアウトの回答文と、そのロールアウトで取得した各文書の語彙重複率を計算し、最も一致する文書との重複率を重みとする。モデル文脈内のlogprobではなく、取得ログという外部信号を使うことで、コピー由来の見かけの確信を避ける。
- **どうやって有効だと検証した？**: BrowseComp-Plus、GAIA、BrowseComp、FRAMESの4ベンチマークと5モデルで比較した。単純多数決・DeepConf・RGVを評価し、RGVは4ロールアウトでDeepConfの8ロールアウト相当の精度に達した。コピーtokenは非コピーtokenより平均logprobが高く、DeepConfの正誤スコア分布が大きく重なることも分析している。
- **議論はある？**: 語彙的一致は「文書に書いてある」ことの代理指標であり、文書自体が誤っている場合、複数文書を統合する推論、言い換え・非英語への一般化には弱くなり得る。各データセット150問・3分割による分散推定であり、統計的検定としては粗い。正誤判定にQwen3-32B judgeを用いる影響も確認したい。
- **次に読む/試すなら**:  
  1. 自分のRAG/ブラウジングエージェントで、回答文と取得文書のoverlapをロールアウト投票の重みに実装する。  
  2. citation単位・文単位のentailmentスコアへ置換して、単純語彙重複との性能・コスト差を測る。  
  3. DeepConf、自己申告confidence、RGVの組合せを難問・少数正解ロールアウトに限定して比較する。
- **キーワード**: `test-time scaling`, `search agent`, `retrieval grounding`, `confidence calibration`, `RAG`, `self-consistency`

## 気になったこと

- 回答が正しくても取得文書を要約・抽象化して語彙が一致しないケースで、RGVはどの程度不利になるか。
- 文書の最大一致だけを見る設計は、複数ソースをまたぐmulti-hop回答をどこまで扱えるか。
- 日本語・形態変化の大きい言語では、token正規化とstopword除去をどう設計すべきか。
- 重複率の高い誤情報を含む検索結果に対して、groundingと正確性をどう分離するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [kook2026-tc-beyond-confidence-test-time-scaling-for-multi-turn-search-ag-8bda47e5.md](../../chat/2026-08-28/kook2026-tc-beyond-confidence-test-time-scaling-for-multi-turn-search-ag-8bda47e5.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
