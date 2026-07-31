# Paperpile Brief 2026-08-01 - CoRT: Counterfactual Replay for Token-Level Rubric-Guided Policy Optimization

## 基本情報

- **タイトル**: CoRT: Counterfactual Replay for Token-Level Rubric-Guided Policy Optimization
- **著者**: Bo-Wen Zhang, Junwei He, Wen Wang, Song-Lin Lv, Wentao Ma, Rongyi Lin, Shuhan Zhong, Lan-Zhe Guo
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.25659 / arXiv:2607.25659 / PDF: https://arxiv.org/pdf/2607.25659.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: Rubric付きGRPOで、response-level rewardを全tokenへ一様に配る代わりに、rubric依存度が高いtokenへcreditを再配分するCoRTを提案した論文。
- **先行研究と比べてどこがすごい？**: Rubrics-to-Tokensのようにtoken-level relevance modelを別途学習せず、同じ生成列をrubricありpromptとrubricなしpromptで再スコアするだけでtoken重みを作る。response-level rewardやGRPO本体は変えず、credit allocationだけを差し替える設計が軽い。
- **技術や手法の肝はどこ？**: 生成済みresponseを固定し、full rubric promptでのtoken log probabilityとcriteria-free promptでのtoken log probabilityの差分を取る。この差分を「そのtokenがrubric文脈にどれだけ依存しているか」のproxyとし、sigmoidでbounded score化、SmoothStep rampとresponse normalizationで安定化して、signed GRPO advantageに掛ける。
- **どうやって有効だと検証した？**: Qwen3-4B、Qwen2.5-7B系のinstruction-tuned modelで、IFEval、IFBench、MultiDimIFなどを評価。本文では、matched response-level GRPOに対して大多数の比較で改善し、平均4.4ポイント向上したと報告。RTT系のlearned token credit baselineとも競争的。Math500、GPQA-Diamond、MMLU-Proで一般能力が大きく崩れないことも確認している。
- **議論はある？**: replay contrastはtoken importanceの校正済み指標ではなく、あくまでpolicy-internalなrubric依存proxy。局所的に表面化する条件、例えばbullet数、固定phrase、section labelには強いが、言語指定や最低文数のようなglobal/absence-style criterionでは効果が拡散しやすい。追加replay passの計算コスト、rubric除去promptの作り方への感度、他モデル・他reward設計での再現性は確認したい。
- **次に読む/試すなら**: RTTとの実装・データ生成コスト差を読む。小さいGRPO実験でcriteria-free replayのlogprob差を可視化する。global constraint向けにcriterion-wise removalやspan aggregationを試す。
- **キーワード**: `GRPO`, `rubric-based RL`, `token-level credit assignment`, `counterfactual replay`, `LLM alignment`, `instruction following`

## 気になったこと

- criteria-free promptをどう自動生成するかで信号の質が変わりそう。
- high-contrast tokenが「rubric達成に重要」なのか「prompt差分に敏感」なだけなのかを、失敗responseでも分離して見たい。
- 長文・複数rubric・相互依存rubricの場合、token重みが局所条件に偏りすぎないか。
- rewardが誤判定した場合、rubric-sensitive tokenをより強く間違った方向に更新するリスクがある。
- 関連研究として、RTT、TRACE、Self-OPD、context attribution、process reward modelを追うとよさそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhang2026-tr-cort-counterfactual-replay-for-token-level-rubric-guided-po-b92ba06d.md](../../chat/2026-08-01/zhang2026-tr-cort-counterfactual-replay-for-token-level-rubric-guided-po-b92ba06d.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
