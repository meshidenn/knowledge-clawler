# Paperpile Brief 2026-08-27 - The laws of context allocation: Causal measurement and closed-loop orchestration in generative search

## 基本情報

- **タイトル**: The laws of context allocation: Causal measurement and closed-loop orchestration in generative search
- **著者**: Peiyang Liu, Xi Wang, Di Liang, Wei Ye
- **年 / venue**: 2026 / arXiv [cs.LG]（ACM TOIS投稿原稿）
- **リンク**: [arXiv:2608.23252v1](https://arxiv.org/abs/2608.23252v1)

## 落合陽一フォーマット

- **ひとことでいうと**: RAGでは長いコンテキストを一度に読ませるより、因果的な利用度推定をフィードバックして短いコンテキストを逐次切り替える方が、回答集合のカバレッジを大きく高められると示した論文。
- **先行研究と比べてどこがすごい？**: BM25や埋め込み類似度による「関連性」を、LLMが実際に根拠として使った度合いと混同する評価上の錯覚を指摘した。同一クエリのhard negativeでは既存proxyがほぼランダムになる一方、leave-one-out（LOO）因果プローブは識別性を保つと報告する。固定予算では逐次的な狭い文脈がportfolio recallを絶対値で16.8〜20.5ポイント改善し、最大32Bモデルまで検証した。
- **技術や手法の肝はどこ？**: 生成済み応答を固定し、各文書を一つずつ除いたときの尤度変化で証拠利用を測るLOOプローブを用いる。その利用履歴を基に、既読の知識facetを割り引くsubmodular schedulerで次ラウンドの文書を選ぶ。さらに、使い過ぎた証拠に対応するトークン確率を抑えるcontrastive decodingで、LLMの「attention inertia」を抑制する。
- **どうやって有効だと検証した？**: ASQA、QAMPARI、ELI5、異文化レシピ適応タスクで、検索器と候補プールを固定して比較した。Qwen2.5-7B、Llama-3.1-8B、Mistral-7B-v0.3と、Qwen2.5の14B・32Bを用い、幅 \(k\) と生成回数 \(T\) のfactorial gridで、同じ証拠スロット予算におけるwide contextと逐次rotationを比較した。ASCPは選択型ベースラインをportfolio recallで+0.033〜+0.081上回ったと報告する。
- **議論はある？**: 効果はportfolio形式の多面的回答を重視する評価に依存する。逐次生成はautoregressive latencyを増やし、LOOにも各生成あたり \(k+1\) 回のforward passが必要である。著者はteacher-forced評価の並列化で軽減できるとするが、実運用の総レイテンシ・コストは追加検証が必要。また、幅に対する利用度の弾性値はタスク難度や証拠の冗長性で変動し、普遍定数ではない。
- **次に読む/試すなら**: 
  1. 公開コードで、固定top-\(k\)・単純rotation・ASCPを同一予算で比較する。
  2. 自分のRAGログにLOO利用度推定を導入し、類似度ベースの文書選択との差を測る。
  3. 逐次化によるrecall向上と、レイテンシ・トークンコスト・正確性のPareto frontierを作る。
- **キーワード**: `RAG`, `context attribution`, `causal leave-one-out`, `inference-time scaling`, `submodular optimization`, `generative search`

## 気になったこと

- LOO尤度差が「証拠を因果的に使った」ことをどこまで忠実に表すか。固定応答・長さ一致置換などの設計はあるが、モデル内部の推論過程そのものではない。
- portfolio recallの改善が、ユーザーの最終満足度・回答の整合性・幻覚率にどう転写されるか。
- 逐次ラウンドで過去の生成物をどの程度引き継ぐか、またcontrastive decodingが新証拠の過剰反映や矛盾を招かないか。
- PDF抽出範囲からは、実運用でのend-to-endレイテンシ、計算コスト、再現実験の詳細は十分には確認できない。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [liu2026-fv-the-laws-of-context-allocation-causal-measurement-and-closed-b73c9032.md](../../chat/2026-08-27/liu2026-fv-the-laws-of-context-allocation-causal-measurement-and-closed-b73c9032.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
