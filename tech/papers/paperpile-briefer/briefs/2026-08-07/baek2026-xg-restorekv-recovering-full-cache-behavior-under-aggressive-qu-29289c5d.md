# Paperpile Brief 2026-08-07 - RestoreKV: Recovering Full-Cache Behavior Under Aggressive Query-Agnostic KV Cache Eviction

## 基本情報

- **タイトル**: RestoreKV: Recovering Full-Cache Behavior Under Aggressive Query-Agnostic KV Cache Eviction
- **著者**: Changwoo Baek, Seungjun Shin, Kyeongbo Kong
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2608.01247 / https://paper.pnu-cvsp.com/RestoreKV/

## 落合陽一フォーマット

- **ひとことでいうと**: query-agnostic な KV cache eviction で捨てた情報を、少数の restore token と LoRA による一回の restore pass で補完し、full-cache に近い挙動を回復する手法。
- **先行研究と比べてどこがすごい？**: 既存の KVzip / KVzip+ / ContrastKV などは「どの元 KV pair を残すか」に主眼があるのに対し、RestoreKV は同じ総 KV budget 内で「残す KV」と「生成した補完 KV」を組み合わせる。Qwen3-4B では 5% budget で KVzip の RULER-4K accuracy を 38.2 から 73.2 に改善し、5種類の base eviction method に対する 60設定中59設定で改善したと報告している。
- **技術や手法の肝はどこ？**: context prefill 後、デフォルト8個の learnable restore tokens を full KV cache に causal attention させ、LoRA-adapted pass で context-conditioned restore cache を生成する。LoRA は restore-cache 生成時だけ有効で、その後の query processing と decoding では frozen backbone に戻す。最終 cache は `Evict(C, s, B - nLH)` で残した元 KV と、`nLH` 個の restore KV を結合し、元の KV budget `B` を保つ。
- **どうやって有効だと検証した？**: 4つの model backbone、4つの long-context benchmark、5つの base eviction method で評価。RULER-4K、KVPress Benchmark、LongBench、SCBench などで比較し、特に aggressive compression ほど改善が大きい。自己蒸留では frozen full-cache teacher の answer-token distribution に student を symmetric KL で近づけ、trainable parameter は約0.4%。32K-context 評価では restore pass の追加 overhead は 0.03-0.04 秒、総 compression time の 0.5% 未満、peak memory 追加は約84MBとされる。
- **議論はある？**: restore mechanism は training-time evictor にある程度依存し、SnapKV で訓練して KVzip 推論に使う mismatch では tight budget で効果が大きく落ちる。PDF抽出からは、より多様な実運用 query 分布、multi-turn 状況、極端に長い context での安定性、他の RoPE/attention 実装との相性は十分には断定できない。数値は抽出テキスト由来であり、表・図の細部は原PDFで確認したい。
- **次に読む/試すなら**: KVzip+ 実装に RestoreKV を差し込む最小実験を確認する。restore token 数 `n=8` と LoRA target module の ablation を再現する。自分の長文RAG/agent memory workload で query-agnostic cache reuse が本当に効くか測る。
- **キーワード**: `KV cache eviction`, `RestoreKV`, `query-agnostic compression`, `LoRA`, `self-distillation`, `long-context LLM`

## 気になったこと

- restore cache が「何を」保持しているのか、attention pattern や token-level probing で解釈できるか。
- base evictor ごとに個別 training が必要なら、運用上の model × evictor 組み合わせコストはどの程度か。
- RAG のように context が頻繁に変わる場合、one-time restore pass の overhead と cache reuse 回数の損益分岐点はどこか。
- full-cache teacher による self-distillation が、teacher の誤りや benchmark bias も圧縮してしまわないか。
- Latent Context Compilation、Still、Attention Matching など、cache を合成・圧縮する同時期研究との比較軸を整理したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [baek2026-xg-restorekv-recovering-full-cache-behavior-under-aggressive-qu-29289c5d.md](../../chat/2026-08-07/baek2026-xg-restorekv-recovering-full-cache-behavior-under-aggressive-qu-29289c5d.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
