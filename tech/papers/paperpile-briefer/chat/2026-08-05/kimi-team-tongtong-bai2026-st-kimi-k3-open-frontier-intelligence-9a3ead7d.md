# Chat Prompt 2026-08-05

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Kimi {K3}: Open Frontier Intelligence

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-05 - Kimi K3: Open Frontier Intelligence

## 基本情報

- **タイトル**: Kimi K3: Open Frontier Intelligence
- **著者**: Kimi Team: Tongtong Bai, Yifan Bai, Yiping Bao ほか
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.24653 / arXiv:2607.24653v1

## 落合陽一フォーマット

- **ひとことでいうと**: 2.8T parameters、104B activated parameters、1M-token context、native vision を持つ MoE frontier model「Kimi K3」の architecture、training、RL、system infrastructure、benchmark 結果をまとめた technical report。
- **先行研究と比べてどこがすごい？**: Kimi K2 に対して約 2.5x の scaling efficiency 改善を主張し、open model として 3T-class pre-training と 1M context の test-time scaling / agentic RL を同時に狙っている点。評価では最強 proprietary model とされる Claude Fable 5 / GPT-5.6 Sol には総合的に劣るが、比較対象の他 open / proprietary models を一貫して上回ると述べている。
- **技術や手法の肝はどこ？**: sequence length 方向は Kimi Delta Attention と Gated MLA の hybrid attention、depth 方向は Attention Residuals、width 方向は 896 routed experts から token ごとに 16 experts を使う Stable LatentMoE。post-training では general / agentic / coding domains と low / high / max reasoning effort の組み合わせで RL expert を作り、Multi-Teacher On-Policy Distillation で単一 model に統合する。
- **どうやって有効だと検証した？**: long-horizon coding、agentic tasks、knowledge、reasoning、vision tasks の広範な benchmark で比較。DeepSWE、Terminal-Bench、Kimi Code Bench、ProgramBench、GDPval-AA v2、JobBench、BrowseComp、CharXiv、FrontierSWE、SWE-Marathon、AutomationBench、Zerobench などが本文に登場する。ただし抽出テキストは図表レイアウトが崩れているため、細かい score の対応関係は断定しない。
- **議論はある？**: strongest proprietary systems にはまだ届かないと明記されている。巨大 MoE、1M context、agentic RL、sandbox state persistence、expert-parallel training などに依存するため、再現には model weights だけでなく大規模 infrastructure と training environment の再構築が必要。PDF抽出は16ページ分で、全文の後半や詳細 appendix は今回の入力からは不完全な可能性がある。
- **次に読む/試すなら**: KDA / Kimi Linear / Attention Residuals / Kimi K2.5 Agent Swarm の参照論文を読む。Hugging Face の Kimi-K3 weights と推論要件を確認する。1M context での retrieval / coding agent task を小規模に再現して、長文性能が局所検索で代替できないか検証する。
- **キーワード**: `Mixture-of-Experts`, `Kimi Delta Attention`, `Attention Residuals`, `Stable LatentMoE`, `1M context`, `agentic RL`, `multi-teacher distillation`, `frontier model`

## 気になったこと

- 2.5x scaling efficiency の算出条件と、Kimi K2 比較時の compute / data / architecture 差分を分離できるか。
- 1M-token context の能力が synthetic long-context data にどの程度依存しているか。
- benchmark suite に internal tasks が含まれるため、外部再現可能な評価だけで見た順位がどう変わるか。
- MXFP4 / MXFP8 の deployment-aware post-training が精度低下をどれだけ抑えているか。
- 公開 weights だけで agentic RL 由来の能力を再現利用できるのか、tool harness 側の設計がどれだけ効くのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
