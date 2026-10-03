# Paperpile Brief 2026-10-03 - DAGent: Evaluate-then-Grow planning for deep research agents

## 基本情報

- **タイトル**: DAGent: Evaluate-then-Grow planning for deep research agents
- **著者**: Hanwen Liu, Yuanfu Sun, Qiaoyu Tan
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [実装リポジトリ](https://github.com/hanwenliu6825/DAGent)（論文URL・arXiv IDはメタデータからは不明）

## 落合陽一フォーマット

- **ひとことでいうと**: 深いリサーチの途中で得られた証拠や不確実性を評価しながら、実行時にDAG型のタスク計画を段階的に拡張するマルチエージェント・フレームワークを提案した。
- **先行研究と比べてどこがすごい？**: 既存の「Plan-then-Patch」が最初に大部分の計画を固定し、失敗後に修正するのに対し、DAGentは「Evaluate-then-Grow」で一度に1バッチずつ計画を拡張する。BrowseComp-Plus、GAIA、xbench-DeepSearchで強いオープンソースベースラインを5.3、5.8、2.0ポイント上回ったと報告している。
- **技術や手法の肝はどこ？**: Orchestratorが完了ノードのconfidenceとuncertaintyを条件にDAGを拡張する。通常は圧縮したQueryDocを下流へ渡し、必要時には完全な実行トレースを参照できる階層的コンテキストを採用する。さらに、DAGの構造をRLの報酬・クレジット設計に利用し、Executor向けのDAGRPOと、Orchestrator計画の構造的コンプライアンス正則化を導入する。
- **どうやって有効だと検証した？**: BrowseComp-Plus、GAIA、xbench-DeepSearchで評価し、Qwen3-235B-A22Bを含む複数バックボーン、さらにGPT-5・327Kコンテキストへ検証範囲を広げている。Qwen3-8Bでは、同一予算のoutcome-only GRPOより平均Pass@1が3.0ポイント向上したと報告する。同一アーキテクチャ比較では、Plan-then-Patchより高精度かつ少ないトークン、ツール呼び出し、ステップ数を達成したとしている。細かな実験条件や数値の内訳は、PDF本文がないためメタデータからは不明。
- **議論はある？**: 評価結果はabstractベースであり、どの程度が動的計画、コンテキスト設計、DAGRPOの各要素による改善かは不明。confidenceやuncertaintyの校正方法、DAG拡張の停止条件、Orchestratorの追加計画による遅延・コスト、GPT-5での再現条件も確認が必要。PDF本文がなく、実装詳細や失敗例、再現性はメタデータからは不明。
- **次に読む/試すなら**:
  1. GitHub実装でOrchestrator、QueryDoc、DAGRPOのデータフローを確認する。
  2. 同一検索タスクでPlan-then-PatchとEvaluate-then-Growを比較し、精度・ツール呼び出し数・トークン数を測る。
  3. confidence/uncertaintyを単純な自己評価から検索結果の一貫性や検証成功率に置き換えて比較する。
- **キーワード**: `deep research agents`, `DAG planning`, `incremental planning`, `DAGRPO`, `multi-agent systems`

## 気になったこと

- confidenceとuncertaintyはどのモデル出力・評価器から算出され、実際の証拠の信頼性とどの程度相関するのか。
- QueryDocの圧縮で失われる情報と、オンデマンドの完全トレース参照コストはどの程度か。
- タスクの難易度や検索空間の大きさによって、動的に成長するDAGの優位性が変わるか。
- `DAGent`の改善が、計画戦略そのものによるものか、追加の推論・ツール予算によるものか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [liu2026-tv-dagent-evaluate-then-grow-planning-for-deep-research-agents-10bc9ffb.md](../../chat/2026-10-03/liu2026-tv-dagent-evaluate-then-grow-planning-for-deep-research-agents-10bc9ffb.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
