# Paperpile Brief 2026-07-09 - {R}$^2$-Searcher: Calibrating retrieval and reasoning boundaries for agentic search

## 基本情報

- **タイトル**: {R}$^2$-Searcher: Calibrating retrieval and reasoning boundaries for agentic search
- **著者**: Sheng Zhang, Junyi Li, Wenlin Zhang, Xiaowei Qian, Yichao Wang, Yingyi Zhang, Maolin Wang, Yong Liu, Xiangyu Zhao
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: https://arxiv.org/pdf/2606.28566

## 落合陽一フォーマット

- **ひとことでいうと**: multi-hop QA向けのagentic searchで、検索した文書のどこを推論に使うべきか、次に何を検索すべきかを明示的に調整するR²-Searcherを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のRAG/search agentは、検索結果が不十分だったり、長い文書中の無関係な箇所で推論したりして、retrievalとreasoningの境界がずれる。この論文は、query tokenに基づく細粒度のreasoning region抽出と、検索後のreflectionを組み合わせ、検索と推論を同時に補正する点が新しい。7つのQAベンチマークで既存のagentic search手法を上回り、AutoRefine比で平均EM +8.2%、F1 +7.3%と報告している。
- **技術や手法の肝はどこ？**: 検索クエリを主語・動作・時間表現・程度修飾などのtoken groupに分解し、取得文書からそのtoken groupに対応する事実だけを`retrieved_facts`として抽出する。さらに各検索ステップ後に、検索結果が現在の推論要求を満たすかをreflectionで診断し、次の検索クエリを修正する。学習ではR²POというGRPO拡張のRL手法を使い、tree-based rolloutでreasoning region、reflection、search actionを探索・最適化する。
- **どうやって有効だと検証した？**: NQ、TriviaQA、PopQA、HotpotQA、2Wiki、Musique、Bamboogleの7ベンチマークでEM/F1を比較。Direct Inference、CoT、Vanilla RAG、IRCOT、Search-o1、Search-R1、ZeroSearch、ReSearch、AutoRefineなどと比較している。さらにsearch success rate、reasoning success rate、Qwen2.5-3B/Qwen3-4Bでのscalability、R²PO・tree rollout・reasoning region・reflection・reward penaltyのablationも実施している。
- **議論はある？**: 検索成功の定義が「取得文書にground-truth answerが含まれるか」に寄っており、実際の証拠十分性や引用品質をどこまで測れているかは注意が必要。reasoning successもF1 10%以上という低めの閾値を使うため、部分的な推論品質の指標として読むべき。PDF本文上では、arXiv論文ながらACMテンプレート由来のvenue表記が残っており、正式採択venueはメタデータからは不明。
- **次に読む/試すなら**: R²-SearcherのGitHub実装で`retrieved_facts`とreflectionのprompt形式を確認する。小規模なmulti-hop QAでreasoning region抽出だけを既存RAG pipelineに差し込んで効果を見る。AutoRefine/Search-R1/ReSearchとの違いを、検索クエリ生成の失敗例ベースで比較する。
- **キーワード**: `agentic search`, `retrieval-augmented generation`, `multi-hop QA`, `reinforcement learning`, `R2PO`, `retrieval reflection`

## 気になったこと

- query token guidedなfact抽出は、token groupの品質に強く依存しそうだが、品詞分解や意味分類の失敗にどれだけ頑健か。
- reflectionが本当に検索境界を補正しているのか、単に長いchain-of-thought的な自己説明で性能が上がっているのかを切り分けたい。
- 実運用RAGではground-truth answerがないため、R²POのreward設計をどう置き換えるかが課題。
- 検索対象がWebではなく社内文書・論文PDF・コードベースになったとき、reasoning region抽出の粒度をどう変えるべきか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhang2026-sr-r-2-searcher-calibrating-retrieval-and-reasoning-boundaries-e5694967.md](../../chat/2026-07-09/zhang2026-sr-r-2-searcher-calibrating-retrieval-and-reasoning-boundaries-e5694967.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
