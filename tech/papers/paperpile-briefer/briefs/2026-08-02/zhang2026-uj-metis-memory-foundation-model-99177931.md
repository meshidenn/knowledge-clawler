# Paperpile Brief 2026-08-02 - Metis: Memory foundation model

## 基本情報

- **タイトル**: Metis: Memory foundation model
- **著者**: Zeyu Zhang, Ziliang Guo, Yihang Sun, Xichong Zhang, Xixuan Hao, Zehao Lin, Yang Zhang, Xiaoyan Zhao, Tong Shen, Bo Tang, Zhi-Qin John Xu, Junchi Yan, Haofen Wang, Xu Chen, Feiyu Xiong, Zhiyu Li, Tat-Seng Chua
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: arXiv:2607.26760 / PDF: https://arxiv.org/pdf/2607.26760 / Code: https://github.com/MemTensor/Metis / Model: https://huggingface.co/collections/IAAR-Shanghai/metis / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントのmemoryをRAGなどの外部モジュールではなく、backbone内部の動的なnative memory stateとして持たせる「memory foundation model」を定式化し、その最初のprototypeとしてMetisを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来の外部memoryは検索・要約・連結がbackbone外にあり、end-to-end最適化やlatencyに弱い。Metisはmemoryをforward計算に組み込み、重みは固定したままmemory stateだけをforward passで更新する。MemOps、LoCoMo、NextMemなどでno-context条件のbaselineより高いmemory性能を示す。
- **技術や手法の肝はどこ？**: Transformer block内にMetis blockを入れ、local memory blockが過去情報をdenseなmemory stateとして保持し、hyper memory blockが現在入力と生成応答からmemory stateを更新する。利用時はmemory attentionでnative memoryを読む。学習はbackboneをfreezeし、memory reconstruction、memory operation、regularization objectiveを使ったmid-trainingで行う。
- **どうやって有効だと検証した？**: Memory operationではMemOpsとMetis独自test set、memory-based QAではLoCoMo GoldとNextMemを使用。比較対象はQwen3.5 full-context / partial-context RAG / no-context、Temp-LoRA、δ-Mem。さらにablation、OOD benchmark、memory capacity、general capability、low-rank compression、case studyで分析している。
- **議論はある？**: 固定サイズのlatent parameterへ圧縮するため、長期memoryでは性能が落ちる。初期に保存したfactが後続更新で弱まり、意味的に近いfactの混同も起きる。active memory状態では一般能力、特にinstruction followingが低下する。著者自身も外部memoryの完全な置き換えではなく、補完的方向だと位置づけている。
- **次に読む/試すなら**: 
  1. 公開checkpointで短いpersona memoryのremember/update/forgetを再現する。
  2. RAG + Metisのhybrid構成で長期memory劣化を補えるか試す。
  3. memory stateの可視化・検査・削除可能性を調べる。
- **キーワード**: `memory foundation model`, `native memory`, `Metis`, `agent memory`, `memory attention`, `parametric memory`, `mid-training`

## 気になったこと

- native memory stateに保存された情報を人間が監査・削除できるのか。
- forget操作が外部benchmarkで弱い理由は、学習データ分布の問題か、latent memory構造そのものの限界か。
- 実運用ではRAG、profile store、episodic memoryとどう役割分担するのがよいか。
- memory stateが個人情報を含む場合の隔離、暗号化、権限管理は本文からは十分に分からない。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhang2026-uj-metis-memory-foundation-model-99177931.md](../../chat/2026-08-02/zhang2026-uj-metis-memory-foundation-model-99177931.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
