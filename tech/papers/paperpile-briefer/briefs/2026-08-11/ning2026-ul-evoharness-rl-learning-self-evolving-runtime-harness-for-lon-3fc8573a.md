# Paperpile Brief 2026-08-11 - EvoHarness-RL: Learning Self-Evolving Runtime Harness for Long-Horizon LLM Agents

## 基本情報

- **タイトル**: EvoHarness-RL: Learning Self-Evolving Runtime Harness for Long-Horizon LLM Agents
- **著者**: Xuying Ning, Dongqi Fu, Tianxin Wei, Hanqing Zeng, Yuanchen Bei, Bingxuan Li, Zihao Li, Qifan Wang, Xiang Shen, Yifan Wu, Jiayi Liu, Hong Li, Yinglong Xia, Xiangjun Fan, Hanghang Tong, Jingrui He
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2608.05446

## 落合陽一フォーマット

- **ひとことでいうと**: 長期タスクを解くLLM agentに対して、外部メモリや進捗管理などの「harness」を手作業のプロンプト設計ではなく、学習可能な実行時ポリシーとして扱う論文。
- **先行研究と比べてどこがすごい？**: 既存のagent harnessは、memory、tool、state tracker、verifierなどを個別に設計し、いつ使うかはheuristicやpromptに依存しがちだった。本論文はBelief / Progress / Experienceという統一抽象を置き、`track`, `commit`, `recall`, `note`の行動としてpolicyに学習させる点が差分。ALFWorldではQwen3-8Bベースでseen 96.9%、unseen 86.6%の成功率を報告している。
- **技術や手法の肝はどこ？**: 外部状態をBPEに分解する設計が中心。Beliefは環境状態、Progressはサブゴールと実行状況、Experienceは過去episodeからの再利用知識を担う。まずSFTでharness actionの意味と使い方を教え、その後cost-aware GRPOで「harnessを呼ぶ価値があるタイミング」を最適化する。harness actionも環境actionと同じstep budgetを消費するため、乱用ではなく選択的利用を学ばせる。
- **どうやって有効だと検証した？**: ALFWorldの家庭内タスク環境で評価。policy modelはQwen3-8B、teacher / consolidation modelはClaude Opus。500 training gamesから成功trajectoryのみを使ってSFTデータを作り、GRPOで追加学習した。比較としてprompt-time BPE、SFT、標準GRPOなどとの性能・学習曲線・harness action頻度を見ている。PDF本文によると、学習が進むにつれて`commit`や`note`は減り、`recall`は比較的残るというharness annealingも観察されている。
- **議論はある？**: 評価がALFWorld中心なので、web navigationやsoftware engineeringなど複雑な外部ツール環境へそのまま一般化できるかは未検証。Belief trackerはrule-based、Experience retrievalはkeyword overlapなど、harness自体の実装は比較的軽量で環境依存。Claude Opusをteacherとconsolidationに使うため、完全に単一モデルで自己進化しているわけではない。細かい比較表や数値はPDF抽出の制約上、断定しすぎない方がよい。
- **次に読む/試すなら**: ALFWorld以外、特にsoftware engineering agentでProgressがどれだけ効くか小実験する。`commit/track/recall/note`を既存agent loopに差し込み、step costあり・なしで比較する。Experience storeのretrievalをkeyword overlapからembedding retrievalに替えた場合の差を見る。
- **キーワード**: `LLM agents`, `runtime harness`, `reinforcement learning`, `GRPO`, `ALFWorld`, `external memory`, `Belief-Progress-Experience`

## 気になったこと

- BPE抽象はきれいだが、software engineeringではBelief / Progress / Experienceの境界が曖昧になりそう。
- harness actionをstep budgetに含める設計は妥当だが、実サービスではtool call cost、latency、失敗率も報酬に入れる必要がある。
- Experience consolidationにClaude Opusを使っているため、consolidation modelの品質差が結果にどれくらい効いているか確認したい。
- `note`が減ることは効率化とも読めるが、長期的な自己改善能力の低下にもなり得る。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [ning2026-ul-evoharness-rl-learning-self-evolving-runtime-harness-for-lon-3fc8573a.md](../../chat/2026-08-11/ning2026-ul-evoharness-rl-learning-self-evolving-runtime-harness-for-lon-3fc8573a.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
