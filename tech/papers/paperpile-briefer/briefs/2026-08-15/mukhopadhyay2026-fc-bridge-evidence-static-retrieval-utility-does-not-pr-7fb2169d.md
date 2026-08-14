# Paperpile Brief 2026-08-15 - Bridge evidence: Static retrieval Utility does not predict causal Utility in multi-step agentic search

## 基本情報

- **タイトル**: Bridge Evidence: Static Retrieval Utility Does Not Predict Causal Utility in Multi-Step Agentic Search
- **著者**: Debayan Mukhopadhyay, Utshab Kumar Ghosh, Shubham Chatterjee
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: [arXiv PDF](https://arxiv.org/pdf/2607.15253)

## 落合陽一フォーマット

- **ひとことでいうと**: エージェント型検索では、単体では答えに役立たなそうな文書が「次の検索語」を与えることで因果的に重要になり、静的なRAG評価ではその価値を捉えられないことを示した。
- **先行研究と比べてどこがすごい？**: 文書を単発で読ませる静的有用性（SRU）ではなく、文書を削除して以降の探索軌跡を再実行する反実仮想的有用性（CTU）で評価した。両者の相関はほぼゼロ（Spearman ρ = -0.026）で、静的評価の最適化がエージェントの探索成功を保証しないことを定量化した。
- **技術や手法の肝はどこ？**: 各時点でエージェントが読んだ文書を1件だけ除外し、その後の軌跡を再実行する Counterfactual Trajectory Exploration を導入。最終回答品質、次クエリの検索品質、必要ターン数の変化からCTUを算出する。「bridge document」は、答えそのものではなく、次の有効な検索を導く識別的エンティティを供給する。
- **どうやって有効だと検証した？**: HotpotQA開発セットから1,000問を用い、23,322件の文書観測を分析。静的には低有用だがCTUが高いbridge文書が35.7%を占めた。BM25とcross-encoderによる代理指標でもbridgeセルは27.2%。また、高OER（Observable Entity Relevance）エンティティは低OERエンティティより次クエリに4.02倍多く引き継がれた（6.1% vs 1.5%、n=227,139）。
- **議論はある？**: 評価はQwen2.5-7B-Instruct、Wikipedia、HotpotQA、特定プロンプトと検索器に依存するため、CTUは文書固有ではなく「エージェントと文書の組」に対する性質である。SRU軸は高スコア文書が少なく歪んでおり、35.7%という数値単独の解釈には注意が必要。BM25/cross-encoder代理評価も、両者が一致した部分集合のみを扱う。反実仮想再実行は高コストで、学習ループにそのまま使うのは難しい。
- **次に読む/試すなら**:
  1. OERを用いた軽量なbridge文書予測器を実装し、通常のBM25/rerankerと比較する。
  2. 別のLLM・データセット・Web検索環境でCTUと静的有用性の乖離が再現するか検証する。
  3. 次クエリに伝播したエンティティを明示的に報酬化するエージェント向けretrieval学習を試す。
- **キーワード**: `agentic retrieval`, `counterfactual evaluation`, `bridge evidence`, `multi-hop QA`, `entity relevance`

## 気になったこと

- 文書除外後の再実行で、残りの検索候補やコンテキストがどこまで元軌跡と同一に保たれるか。
- CTUの3要素（回答品質・次検索品質・ターン数）の重み付けが、結論にどの程度影響するか。
- OERを事前特徴として使ったとき、実運用のランキング品質・計算量・探索成功率がどこまで改善するか。
- 長期記憶、ツール利用、複数エージェント協調を含む探索でもbridge evidenceが成立するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [mukhopadhyay2026-fc-bridge-evidence-static-retrieval-utility-does-not-pr-7fb2169d.md](../../chat/2026-08-15/mukhopadhyay2026-fc-bridge-evidence-static-retrieval-utility-does-not-pr-7fb2169d.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
