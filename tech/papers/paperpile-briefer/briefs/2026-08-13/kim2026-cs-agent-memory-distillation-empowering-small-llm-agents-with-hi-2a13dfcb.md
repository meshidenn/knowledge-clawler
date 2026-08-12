# Paperpile Brief 2026-08-13 - Agent Memory Distillation: Empowering small LLM agents with hierarchical teacher memory

## 基本情報

- **タイトル**: Agent Memory Distillation: Empowering small LLM agents with hierarchical teacher memory
- **著者**: Taeil Kim, Kangsan Kim, Sung Ju Hwang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2608.07169 / PDF: https://arxiv.org/pdf/2608.07169.pdf / arXiv:2608.07169

## 落合陽一フォーマット

- **ひとことでいうと**: 大きなteacher LLM agentの成功軌跡から階層的なmemoryを作り、小さなstudent LLM agentにtraining-freeで移植して、tool-use性能を上げる論文。
- **先行研究と比べてどこがすごい？**: 既存のagent memoryは大規模モデル前提が多く、小型モデルでは成功軌跡が少なくmemory品質が低い。AMDはteacherの経験をそのまま渡すだけでなく、Workflow / Subtask / Functionの3階層に分解して、小型モデルが理解しやすい粒度に変換する点が新しい。AppWorldで平均+27.2%p、BFCL V3で+11.2%p、ToolSandboxで+3.4%pの改善を報告。
- **技術や手法の肝はどこ？**: teacherの成功軌跡だけを使い、タスク全体の方針を表すWorkflow memory、具体的な中間手順を表すSubtask memory、関数呼び出し失敗時の修正例を表すFunction memoryに蒸留する。WorkflowとSubtaskはタスク開始時にproactive injectionし、Functionはtool-calling errorが起きたときだけreactiveにretrieveする。
- **どうやって有効だと検証した？**: AppWorld、BFCL V3、ToolSandboxの3つのtool-use benchmarkで、4B〜8B級の4種類のstudent modelを評価し、GPT-5-miniをteacherとして使用。zero-shot、student自身のmemory、既存memory-based baselineと比較し、AMDが一貫して上回ると報告。ablationではSubtask memoryの寄与が最大で、Function memoryは追加改善を与えるがモデルによっては文脈増加が逆効果になる場合も示している。
- **議論はある？**: teacher性能だけでなくteacher-student compatibilityが効く。弱いstudentは追加memoryを処理しきれない可能性があり、LLaMA3.1-8BではFunction memory追加で性能低下する例がある。評価は既存benchmark中心で、実運用の長期memory管理、コスト、汚いtool schema、失敗軌跡からの学習についてはまだ詰める余地がある。
- **次に読む/試すなら**: 1. 自分のtool-use agentでWorkflow/Subtask/Functionの3階層memoryを最小実装する。 2. Subtask memoryだけを先に試し、context量と成功率のトレードオフを見る。 3. teacherを変えたときのcompatibilityを小型モデルごとに比較する。
- **キーワード**: `agent memory`, `knowledge distillation`, `tool-use agents`, `small LLM`, `hierarchical memory`, `training-free distillation`

## 気になったこと

- Subtask memoryが最大寄与なら、WorkflowやFunctionを省いた軽量版AMDでどこまで性能が出るか。
- teacher軌跡の成功判定が誤っていた場合、誤ったmemoryがstudentにどれくらい伝播するか。
- Function memoryのreactive injectionは、エラー文が不親切な実APIでも機能するのか。
- memory retrievalのembedding modelやtop-k、similarity thresholdへの感度。
- 実運用ではteacher trajectory生成コストとstudent推論改善の損益分岐点を測る必要がある。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [kim2026-cs-agent-memory-distillation-empowering-small-llm-agents-with-hi-2a13dfcb.md](../../chat/2026-08-13/kim2026-cs-agent-memory-distillation-empowering-small-llm-agents-with-hi-2a13dfcb.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
