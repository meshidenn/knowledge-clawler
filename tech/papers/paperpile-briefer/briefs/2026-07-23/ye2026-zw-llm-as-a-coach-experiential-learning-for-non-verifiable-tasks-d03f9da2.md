# Paperpile Brief 2026-07-23 - LLM-as-a-coach: Experiential Learning for non-verifiable tasks

## 基本情報

- **タイトル**: LLM-as-a-coach: Experiential Learning for non-verifiable tasks
- **著者**: Tianzhu Ye, Li Dong, Guanheng Chen, He Zhu, Xun Wu, Shaohan Huang, Furu Wei
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.18110 / PDF: https://arxiv.org/pdf/2607.18110.pdf / arXiv: `2607.18110` / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: open-endedで正解検証が難しいタスクに対し、LLM-as-a-Judgeのスカラー報酬ではなく、LLM-as-a-Coachが生成する「転移可能な経験知」を使ってLLMをpost-trainingする Experiential Learning（EL）を提案した論文。
- **先行研究と比べてどこがすごい？**: Rubric-as-Reward型RLは評価文を1〜10点などのスカラーに圧縮するため、同点の高品質応答間の差分を学習できない。ELは評価モデルの文章フィードバックを「経験知」として残し、context-conditioned teacher経由でtoken-levelの分布蒸留に変換する。Qwen3-8B、OLMo-3-7B系で、WildChat held-out、AlpacaEval v2、WildBench、ArenaHard v2、CreativeWritingV3の多くでRLを上回る。
- **技術や手法の肝はどこ？**: policyがon-policy responseを生成し、同じrubricでLLM-as-a-Coachが応答を分析して`<experience>`内に再利用可能な改善知識を抽出する。そのexperienceをteacher modelのcontextに入れ、policyの生成軌跡上で、policy分布とexperience-conditioned teacher分布のtoken-level reverse KLを最小化する。推論時にはcoachもexperience contextも不要で、知識はpolicy weightsに内在化される。
- **どうやって有効だと検証した？**: WildChat-IF 7500 promptsで訓練し、held-out WildChat 250 promptsとAlpacaEval v2、WildBench、ArenaHard v2、CreativeWritingV3で評価。feedback modelは初期policy自身またはGPT-4o。RL baselineはGRPOによるRubric-as-Reward。主要結果ではELがRLより汎化性能で優位。さらにteacher更新、general prompt混合、context形式のablation、feedback quantizationのtoy analysis、reward hacking傾向の分析を行っている。
- **議論はある？**: ELはfeedback bandwidthのボトルネックを緩和するが、feedback model自体のバイアスやmiscalibrationは解決しない。経験知抽出の品質に依存する。iterative teacherはWildChat scoreを上げる一方でIFEvalのOOD accuracyを落とし、general prompt OPDで緩和が必要。数値結果はPDF抽出テキスト由来で、細部の表・式はレイアウト崩れの可能性がある。
- **次に読む/試すなら**: 1. `aka.ms/el-code`が公開されているか確認し、training promptとexperience extraction promptを読む。 2. 小さなinstruction-following datasetで、scalar reward RLとexperience-conditioned distillationを比較する。 3. experienceを「全文critique」「rubric only」「短いdirective」に圧縮した場合の性能劣化を再現する。
- **キーワード**: `Experiential Learning`, `LLM-as-a-Coach`, `on-policy context distillation`, `non-verifiable tasks`, `rubric-based evaluation`, `reward hacking`

## 気になったこと

- experienceの良し悪しをどう測るか。単に長いfeedbackが効いているのか、抽象化された「転移可能な知識」が効いているのかをさらに分離したい。
- feedback modelが弱い、あるいは偏っている場合、ELはその偏りをより高帯域に蒸留してしまう可能性がある。
- RLとの比較で、より高解像度なreward modelやmulti-dimensional rewardを使った場合に差がどこまで残るか。
- 推論時context不要という利点は大きいが、training costはcoach生成とteacher forwardが必要なので、実運用での費用対効果を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [ye2026-zw-llm-as-a-coach-experiential-learning-for-non-verifiable-tasks-d03f9da2.md](../../chat/2026-07-23/ye2026-zw-llm-as-a-coach-experiential-learning-for-non-verifiable-tasks-d03f9da2.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
