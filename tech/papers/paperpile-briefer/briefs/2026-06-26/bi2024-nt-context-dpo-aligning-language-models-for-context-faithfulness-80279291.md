# Paperpile Brief 2026-06-26 - Context-{DPO}: Aligning language models for context-faithfulness

## 基本情報

- **タイトル**: Context-{DPO}: Aligning language models for context-faithfulness
- **著者**: Baolong Bi, Shaohan Huang, Yiwei Wang, Tianchi Yang, Zihan Zhang, Haizhen Huang, Lingrui Mei, Junfeng Fang, Zehao Li, Furu Wei, Weiwei Deng, Feng Sun, Qi Zhang, Shenghua Liu
- **年 / venue**: 2024 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2412.15280 / arXiv:2412.15280 / code: https://github.com/byronBBL/Context-DPO

## 落合陽一フォーマット

- **ひとことでいうと**: LLMがRAGや指示文脈と内部知識が衝突したとき、文脈側に忠実に答えるようにDPOでアラインする論文。
- **先行研究と比べてどこがすごい？**: プロンプトやデコード時の工夫ではなく、モデル自体のcontext-faithfulnessを preference optimization で改善する点。ConFiQAという反事実的なRAG風ベンチマークも作り、Llama2、Llama3、Mistral、Qwen2でContext-DPOがベースやプロンプトベース、SFTを上回ったと報告している。
- **技術や手法の肝はどこ？**: Wikidata由来の事実パスから、現実に基づく“stubborn response”と、与えられた反事実コンテキストに従う“faithful response”の選好ペアを作る。入力は反事実コンテキストと質問、勝ち応答は文脈に従う推論列、負け応答はパラメトリック知識に固執する推論列としてDPOにかける。
- **どうやって有効だと検証した？**: ConFiQA、反事実化したNatural Questions、MQUAKEのin-context editingで評価。ConFiQAではContext-DPO後にPcが平均でLlama2-7B-chat 35.2%、Llama3-8B 78.3%、Mistral-7B 151.8%、Qwen2-7B 280.1%改善。Natural Questionsでも平均93%以上の精度とされる。TruthfulQAではMC指標の変動が平均1%以内で、通常の事実生成能力を大きく損ねないと主張している。
- **議論はある？**: 主に知識衝突を強調した人工的・反事実的設定で評価しており、通常の実運用RAGでどこまで効くかは十分未検証。モデルサイズや訓練洗練度が上がるほどcontext-faithfulnessが下がるという観察も、追加検証が必要。PDF本文ベースでは、データ生成にChatGPT-4やエンティティ置換が絡むため、ベンチマークの自然さや漏洩、置換ミスの影響も気になる。
- **次に読む/試すなら**: Context-DPOのコードとデータを確認する。小さなRAG QAセットで「文脈 vs 既知事実」の衝突ペアを作り、LoRA+DPOで再現する。FaithEval、context-aware decoding、knowledge conflict系の比較論文を追う。
- **キーワード**: `Context-DPO`, `context-faithfulness`, `DPO`, `RAG`, `knowledge conflict`, `ConFiQA`, `preference optimization`

## 気になったこと

- 現実のRAGでは「検索文脈が常に正しい」とは限らないので、Context-DPOが誤検索への過剰追従を増やさないか。
- faithful responseをChain-of-Thought風に作る設計が、短答・引用付き回答・拒否判断にも一般化するか。
- ConFiQAの反事実置換は評価として鋭いが、実運用ログから作った選好ペアでも同じ改善が出るか。
- SFTが効きにくくDPOが効く理由を、応答形式ではなく選好境界としてどこまで説明できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [bi2024-nt-context-dpo-aligning-language-models-for-context-faithfulness-80279291.md](../../chat/2026-06-26/bi2024-nt-context-dpo-aligning-language-models-for-context-faithfulness-80279291.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
