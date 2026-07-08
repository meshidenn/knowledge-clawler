# Paperpile Brief 2026-07-09 - Memex(RL): Scaling Long-Horizon LLM Agents via Indexed Experience Memory

## 基本情報

- **タイトル**: Memex(RL): Scaling Long-Horizon LLM Agents via Indexed Experience Memory
- **著者**: Zhenting Wang, Huancheng Chen, Jiayun Wang, Wei Wei
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2603.04257

## 落合陽一フォーマット

- **ひとことでいうと**: 長期タスクを行うLLM agentの履歴を、単なる要約ではなく「index付き要約 + 外部の完全な経験記録」として管理し、必要時に正確な過去証拠を取り戻せるようにする論文。
- **先行研究と比べてどこがすごい？**: 既存のtruncationやrunning summaryは履歴を圧縮する代わりに証拠を失いやすい。Memexはworking contextには短いindex付きsummaryだけを残し、tool outputやlogなどの詳細は外部storeに保持するため、圧縮しつつ証拠を捨てない設計になっている。RLで「何を要約し、何を保存し、どうindexし、いつ読むか」まで学習する点も差分。
- **技術や手法の肝はどこ？**: `CompressExperience`で長いtrajectoryを短いindexed summaryに置き換え、詳細内容を外部key-value storeに保存する。後続ステップでは`ReadExperience(index)`で必要な過去証拠を明示的にdereferenceしてcontextへ戻す。MemexRLはcontext budget下でのwrite/read policyをreward shapingとsegmented trajectory processingで訓練する。
- **どうやって有効だと検証した？**: Modified ALFWorldの長期tool-useタスクで評価。PDF本文では、MemexRLによりtask success rateが24.22%から85.61%へ上がり、peak working context lengthが16934.46 tokensから9634.47 tokensへ下がったと報告している。学習後は`CompressExperience`回数が減り、`ReadExperience`回数が増える傾向も示され、単なる圧縮ではなく再利用可能なindexed memoryの使い方を学んだと解釈されている。
- **議論はある？**: 理論解析は「適切なindexed summaryとbounded dereferenceが存在するなら」という条件付きで、実際に常に学習できるとは主張していない。実験は主にModified ALFWorldで、他の現実的なcoding agent、research agent、multi-API workflowで同じ効果が出るかは未検証。外部storeのindex設計品質、retrieval失敗、保存内容の肥大化、privacy/security面も追加検証が必要。
- **次に読む/試すなら**: MemGPT、Memory-R1、ReSum、FoldGRPO/AgentFoldと比較して、summary-only memoryとの設計差を整理する。自分のagent実装で「短い作業状態 + artifactへのstable reference + 明示的retrieve」を最小実装してみる。Modified ALFWorld以外のlong-horizon coding/search taskで再現可能か確認する。
- **キーワード**: `LLM agents`, `long-horizon tasks`, `indexed experience memory`, `MemexRL`, `context compression`, `reinforcement learning`, `external memory`

## 気になったこと

- indexの命名や粒度が悪い場合、後続の`ReadExperience`がどれくらい壊れるのか。
- semantic retrievalではなく明示indexに寄せる設計は、探索的タスクや曖昧な記憶検索でも十分か。
- 外部storeが肥大化したときのgarbage collectionや古い経験の統合は扱っているのか。
- RLなしのprompted memory policy、heuristic indexing、RAG型memoryとの公平な比較条件をさらに確認したい。
- coding agentや論文調査agentのような実運用タスクで、どのartifactをfull-fidelity保存すべきか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [wang2026-gl-memex-rl-scaling-long-horizon-llm-agents-via-indexed-experie-a370c9b6.md](../../chat/2026-07-09/wang2026-gl-memex-rl-scaling-long-horizon-llm-agents-via-indexed-experie-a370c9b6.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
