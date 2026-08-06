# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {MemSFT}: Mitigating alignment tax with an external parametric memory

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - MemSFT: Mitigating alignment tax with an external parametric memory

## 基本情報

- **タイトル**: MemSFT: Mitigating alignment tax with an external parametric memory
- **著者**: Jiarui Wang, Xiang Shi, Jiaqi Cao, Rubin Wei, Xiquan Wang, Hao Sun, Jingzhi Wang, Zhiqi Yang, Qipeng Guo, Bowen Zhou, Zhouhan Lin
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.25614

## 落合陽一フォーマット

- **ひとことでいうと**: LLMを専門領域にSFTすると一般能力が落ちる「alignment tax」を、backboneを凍結したまま外部のparametric memoryとrouterで専門知識だけ注入して軽減する論文。
- **先行研究と比べてどこがすごい？**: LoRAやfull SFTは専門性能を上げる代わりにgeneral capabilityを落とすが、MemSFTは専門性能を上げつつ劣化を小さく抑える。さらに、同じ領域memoryをQwen3-8BからQwen3-235B-A22Bまで再利用できる点が新しい。PDF本文では、4種類のQwen3 backbone適応でMemSFTは9.23 EFLOPs、full SFTは41.05 EFLOPsとされ、計算量面でも有利。
- **技術や手法の肝はどこ？**: domain SFTデータからtoken-level datastoreを作り、非parametric retrieverの次token分布をteacherとしてmemory LMをKL + CEで学習する。推論時はbackbone LMとmemory LMを並列に走らせ、2層MLP routerがtokenごとにmemory寄与率 λ を予測し、`p_fused = (1 - λ) p_base + λ p_mem` で分布を混ぜる。
- **どうやって有効だと検証した？**: biologyのBioIns、geoscienceのOpenSWI、lawのLawBenchで評価。backboneは主にQwen3-8B/14B/32B/235B-A22B。比較対象は元backbone、full SFT、LoRA、MemSFT。一般能力はMMLU系などのgeneral benchmarkで見ており、MemSFTは専門性能を改善しながら一般性能低下をほぼ抑えると報告している。BM25 RAGとの比較もあり、BioInsでは直接検索よりMemSFTが大きく上回る。
- **議論はある？**: memory再利用はtokenizerと出力語彙が互換なモデル間に限られる。別モデルファミリへの転用にはvocabulary alignmentが必要。memoryはfull decoder modelなので推論計算・メモリ負荷は軽くない可能性があるが、本文から詳細なlatency評価は不明。RLによる追加訓練も未検証。
- **次に読む/試すなら**: MemSFTのGitHub実装を確認する。小さなQwen系モデルでBioIns風のミニデータを作り、memory/routerだけの再現実験をする。LoRA + rehearsalやRAGとの計算量・推論latency比較を読む。
- **キーワード**: `MemSFT`, `alignment tax`, `catastrophic forgetting`, `parametric memory`, `router`, `domain specialization`, `Qwen3`

## 気になったこと

- 外部memoryをfull decoderとして持つ場合、実運用での推論latencyとVRAM増加がどの程度か。
- tokenizer互換がないモデル間でmemoryを移植する現実的な手順は何か。
- memoryが誤った専門知識を覚えた場合、backboneを保ったまま部分修正できるのか。
- RAGより強い理由が「検索失敗の回避」なのか「分布蒸留による形式学習」なのかを切り分けたい。
- domain/general混合でrouterを学習する際、未知ドメインや境界的な質問でλがどう振る舞うか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
