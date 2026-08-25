# Paperpile Brief 2026-08-26 - The physics of multi-turn long-horizon planning: From pre-training to post-training via single- and multi-teacher on-policy agentic distillation

## 基本情報

- **タイトル**: The physics of multi-turn long-horizon planning: From pre-training to post-training via single- and multi-teacher on-policy agentic distillation
- **著者**: Tianyi Men, Zhuoran Jin, Kang Liu, Jun Zhao
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2607.24720](https://arxiv.org/abs/2607.24720) / [PDF](https://arxiv.org/pdf/2607.24720) / [Code](https://github.com/Quester-one/PlanPhysCode)

## 落合陽一フォーマット

- **ひとことでいうと**: 長期・複数ターンのエージェント計画能力を、事前学習・RL後学習・複数教師蒸留の3段階に分け、制御可能な合成タスク環境で「何が能力を伸ばし、何が壊すか」を実験的に分解した論文。
- **先行研究と比べてどこがすごい？**: 実環境ベンチマークの結果比較に留まらず、タスク長・軌跡品質・知識・計画パターンを操作できる統一環境を作った点が新しい。長期計画では、CoTで状態遷移を明示する世界モデル化、少量の長軌跡、低品質データ下でのOPDが重要だと、学習段階ごとに切り分けている。
- **技術や手法の肝はどこ？**: 3ドメインの階層的スキルグラフを合成環境へ写像し、未知のアイテム対応で多段合成を解かせる。計画を汎用的な「計画パターン」とタスク固有の「計画知識」に分け、後者ほど入力との相互情報量が高いと捉える。GRPOとon-policy distillation（OPD）を比較し、さらに複数教師OPD（MOPD）が教師間で共有される計画パターンへ収束することを分析する。
- **どうやって有効だと検証した？**: Fantasy Alchemy・Livestock Farming・Electronic Assemblyの3環境で、短・中・長ホライズンの成功率（Avg@K、Pass@K）を評価した。短軌跡だけの事前学習では長期性能がほぼゼロになる一方、少量の長軌跡で改善した。低品質軌跡を混ぜると誤りが累積して長期性能が大きく崩れ、低品質・長ホライズン条件ではOPDがGRPOより広い有効領域を示した。MOPDでは、教師間パターンが互換的なら汎化、部分共有なら継続学習、完全競合なら破滅的忘却が起きた。
- **議論はある？**: 評価は合成されたスキルグラフと反実仮想的な合成規則を使うため、OS操作・Web操作など現実の複雑なエージェント環境へ結論をどこまで一般化できるかは未検証である。「理想的な教師」を前提にしたOPDの優位性や、計画パターン／知識の分離が実際のLLM内部でどれほど明確かも今後の検証が必要。
- **次に読む/試すなら**:
  1. 公開コード・データセットで、CoT状態遷移あり／なしの最小比較を再現する。
  2. 実タスク環境で、長軌跡の混入率と軌跡品質が成功率へ与える影響を測る。
  3. 複数専門エージェントの蒸留前に、計画パターンの共有度を推定する指標を設計する。
- **キーワード**: `long-horizon planning`, `agentic planning`, `world model`, `on-policy distillation`, `GRPO`, `multi-teacher distillation`, `catastrophic forgetting`

## 気になったこと

- 長軌跡を「少量」追加すれば効くという結果は、現実のWeb・GUIタスクでも再現するか。
- OPDの優位性は教師品質、教師と生徒のモデル規模差、報酬設計に対してどの程度頑健か。
- 計画パターンの共有・競合を、CoT表層の類似性ではなく内部表現から測定できるか。
- 完全に競合する教師知識を統合するには、MOPD以外にルーティング、MoE、再生リプレイが有効か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [men2026-zw-the-physics-of-multi-turn-long-horizon-planning-from-pre-trai-d8f8d904.md](../../chat/2026-08-26/men2026-zw-the-physics-of-multi-turn-long-horizon-planning-from-pre-trai-d8f8d904.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
