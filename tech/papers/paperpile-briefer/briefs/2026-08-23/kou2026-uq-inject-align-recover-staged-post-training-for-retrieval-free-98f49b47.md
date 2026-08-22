# Paperpile Brief 2026-08-23 - Inject, Align, Recover: Staged Post-Training for Retrieval-Free Document Knowledge Internalization

## 基本情報

- **タイトル**: Inject, Align, Recover: Staged Post-Training for Retrieval-Free Document Knowledge Internalization
- **著者**: Qian Kou, Xiaofeng Shi, Xiaosong Qiu, Hua Zhou
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.20281](https://arxiv.org/abs/2608.20281) / [PDF](https://arxiv.org/pdf/2608.20281.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: 検索なしで固定文書コーパスの知識をLLMパラメータへ取り込み、QA性能と汎用能力の両立を狙う3段階のpost-training手法IARを提案した。
- **先行研究と比べてどこがすごい？**: QAのみのSFTや通常のcontinued pretrainingと異なり、文書知識の注入・QA形式への適合・汎用能力の回復を分離して最適化する。8条件中7条件でVanilla SFTの4指標すべてを改善し、平均でドメインQA精度を3.6ポイント、汎用性能平均を12.1ポイント向上したと報告する。
- **技術や手法の肝はどこ？**: Injectでは文書の続きを生成するContinuation、要約・アウトラインからのRewrite、読解指示付き再構成を混ぜ、QAペアより密な文書教師信号を作る。Alignで回答部分だけに損失をかけたQA SFTを行い、Recoverで元のinstruction modelと適応済みモデルをSLERP・task arithmetic・TIES・DAREでマージして忘却を抑える。
- **どうやって有効だと検証した？**: Common Corpus（CC）とCCIで、Llama、Phi、Qwen、SmolLM系列を評価した。推論時は文書も検索結果も与えず質問だけを入力し、ドメインQA精度に加えてIFEval、MMLU、MSBenchで汎用能力を測定した。マージ候補の選択はvalidation splitで行い、最終評価にはheld-out testを使う。
- **議論はある？**: 最適なInjectの混合比はモデル・コーパス依存であり、全条件で優位ではない。各結果は単一seedの学習runで、ドメインQA生成およびLLM judgeには確率性が残る。評価QA自体も文書から生成されたものであり、実運用の人間質問・長期的な知識更新・RAGとの総合的な費用対効果は十分に検証されていない。
- **次に読む/試すなら**:
  1. 自分の固定ドキュメント群で、QA-only SFT・Inject+Align・Inject+Align+Recoverを同一トークン予算で比較する。
  2. TIESまたはSLERPによるマージ比率を振り、ドメイン精度とIFEval等のPareto frontierを可視化する。
  3. 人手作成のheld-out QAを追加し、生成QAへの過適合やjudge依存を監査する。
- **キーワード**: `retrieval-free QA`, `knowledge internalization`, `post-training`, `catastrophic forgetting`, `model merging`, `continued pretraining`

## 気になったこと

- 文書再構成タスクで「知識を覚える」効果と、単に文書の表層表現を模倣する効果をどう切り分けられるか。
- Recoverのモデルマージが、特定コーパスの更新・削除要求に対してどの程度制御可能か。
- ドメイン評価がLLM judgeに依存するため、judgeモデル変更時の順位安定性や人手評価との一致率を追加で確認したい。
- RAGが使えない事情がない限り、精度・更新性・引用可能性を含めたRAGとの実運用比較も必要である。  

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [kou2026-uq-inject-align-recover-staged-post-training-for-retrieval-free-98f49b47.md](../../chat/2026-08-23/kou2026-uq-inject-align-recover-staged-post-training-for-retrieval-free-98f49b47.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
