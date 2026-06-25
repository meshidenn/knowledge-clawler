# Paperpile Brief 2026-06-26 - Beyond correctness: Rewarding faithful reasoning in retrieval-augmented generation

## 基本情報

- **タイトル**: Beyond correctness: Rewarding faithful reasoning in retrieval-augmented generation
- **著者**: Zhichao Xu, Zongyu Wu, Yun Zhou, Aosong Feng, Kang Zhou, Sangmin Woo, Kiran Ramnath, Yijun Tian, Xuan Qi, Weikang Qiu, Lin Lee Cheong, Haibo Ding
- **年 / venue**: 2025 / arXiv [cs.CL]、本文では Transactions on Machine Learning Research 05/2026 掲載と記載
- **リンク**: https://arxiv.org/abs/2510.13272 / arXiv:2510.13272

## 落合陽一フォーマット

- **ひとことでいうと**: RAG検索エージェントを最終回答の正しさだけでなく、検索・証拠利用・回答生成の各段階が「忠実な推論」になっているかで評価・訓練する論文。
- **先行研究と比べてどこがすごい？**: Search-R1やReSearchのようなRLベースのagentic searchは回答精度を上げるが、中間推論が証拠に忠実とは限らない。本論文は、Think-Search、Information-Think、Think-Answerという3種類のfaithfulnessを定義し、それを評価指標だけでなくRL報酬に組み込むVERITASを提案している点が差分。
- **技術や手法の肝はどこ？**: エージェントの軌跡を`<think>`、`<search>`、`<information>`、`<answer>`の遷移として見て、各遷移に対して「思考に基づく検索か」「取得情報を思考が使っているか」「最終回答が思考に支えられているか」を検証する。VERITASでは、これらを細粒度のチェックリスト型プロセス報酬としてRLループに追加する。
- **どうやって有効だと検証した？**: NQ、TriviaQA、PopQA、HotpotQA、2wiki、MuSiQue、BamboogleなどのQAベンチマークで評価。Search-R1などのベースラインと比較し、Exact Matchと3種類のfaithfulnessを測定している。本文では、VERITAS-R1がInformation-Think faithfulnessやThink-Answer faithfulnessを改善しつつ、平均EMも改善したと報告している。
- **議論はある？**: faithfulness評価の一部はLLM-as-a-Judgeに依存しており、評価器のバイアスや過信の影響を受ける。Think-Answer faithfulnessはsubstring exact-match系で、言い換えや妥当な推論を取りこぼす可能性がある。実験は主にオープンドメインQAで、企業検索・医療QAなどへの一般化は未検証。
- **次に読む/試すなら**: VERITASの報酬設計を自分のRAGエージェントログに当てはめて、3つのfaithfulnessを手動評価する。Search-R1/ReSearch系の実装で、最終回答報酬にInformation-Think報酬を足した最小実験を試す。LLM-as-a-Judgeではなく、引用・根拠スパンベースで同じ指標を近似できるか検討する。
- **キーワード**: `agentic search`, `RAG`, `faithful reasoning`, `reinforcement learning`, `process reward`, `LLM-as-a-Judge`, `VERITAS`

## 気になったこと

- Information-Think faithfulnessの改善がEM改善にも効いているなら、RAGでは「検索後に証拠をちゃんと読む」報酬が最も費用対効果が高いのではないか。
- Think-Answer報酬は精度改善がやや不安定そうなので、回答の厳密一致よりも根拠引用・claim decompositionと組み合わせた方が実用的かもしれない。
- 評価器と報酬モデルの分離は意識されているが、実運用ではjudge driftやドメイン特化バイアスをどう監視するかが問題になりそう。
- Open-domain QA以外、特に社内文書検索や法務・医療RAGで同じ3分類がそのまま使えるか確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [xu2025-wu-beyond-correctness-rewarding-faithful-reasoning-in-retrieval-a-b558f602.md](../../chat/2026-06-26/xu2025-wu-beyond-correctness-rewarding-faithful-reasoning-in-retrieval-a-b558f602.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
