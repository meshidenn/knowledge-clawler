# Paperpile Brief 2026-08-21 - Aligning tree-search policies with fixed token budgets in test-time scaling of LLMs

## 基本情報

- **タイトル**: Aligning tree-search policies with fixed token budgets in test-time scaling of LLMs
- **著者**: Sora Miyamoto, Daisuke Oba, Naoaki Okazaki
- **年 / venue**: 2026 / ICML 2026（PMLR 306）
- **リンク**: [arXiv:2602.09574](https://arxiv.org/abs/2602.09574) / [PDF](https://arxiv.org/pdf/2602.09574)

## 落合陽一フォーマット

- **ひとことでいうと**: 固定出力トークン予算下のLLM木探索を、序盤は広く・終盤は深く探索するよう制御する Budget-Guided MCTS（BG-MCTS）を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のMCTS系は予算を停止条件として扱いがちなのに対し、残予算を探索方策そのものへ組み込む。固定10k/20k/30kトークンで、数学・物理推論の複数ベンチマークにおいて予算非考慮の木探索法を概ね上回った。
- **技術や手法の肝はどこ？**: 残予算比率 `ρ` を使い、(1) 終盤ほどPUCTの探索ボーナスを弱める、(2) 深いノードの完成を優先するバイアスを強める、(3) 新しい枝を生やす「仮想生成ノード」の価値を終盤ほど下げる、という3点でwide-to-deepな探索へ移行させる。
- **どうやって有効だと検証した？**: Llama-3.1-8B-Instruct、Qwen2.5-7B-Instruct、Qwen3-32Bを用い、MATH500、AIME24/25、UGPhysicsで評価。Repeated Sampling、逐次リファイン、MCTS、AB-MCTS-M、LiteSearchと比較し、アブレーションで探索減衰・深さバイアス・枝刈り制御の各要素の寄与も調べた。
- **議論はある？**: ノード評価のGenPRM-7Bはスコアが飽和してほぼ二値的になり、細かな経路順位付けには弱い。物理評価では参照解答に基づくrollout評価を使うため、数学実験と評価器条件が異なる。また予算は出力トークンのみで、入力トークンや報酬モデル計算量は未考慮。
- **次に読む/試すなら**:
  1. 自前のMCTS実装で、探索係数を残予算比率に比例させる最小版を試す。
  2. より校正されたPRM／verifierに差し替え、改善幅が評価器品質に依存するか測る。
  3. API料金・レイテンシも含む総コスト予算へ拡張する。
- **キーワード**: `test-time scaling`, `MCTS`, `budget-aware decoding`, `tree search`, `process reward model`

## 気になったこと

- `κ=1`、`λ=1`という制御係数がタスク・モデル・予算規模をまたいでどこまで頑健か確認したい。
- 終盤の「深いほど良い」バイアスは、冗長な思考連鎖や誤った枝の深掘りを誘発しないか。
- BG-MCTSは回答到達率を必ずしも最大化せず、より少数で高品質な完成候補を作る設計である。単一回答の正答率と、データ合成用の候補品質では最適な評価指標が異なりそう。
- 画像・コード・長文生成など、正解照合が難しいタスクでの有効性は本文からは不明。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [miyamoto2026-bq-aligning-tree-search-policies-with-fixed-token-budgets-i-10805180.md](../../chat/2026-08-21/miyamoto2026-bq-aligning-tree-search-policies-with-fixed-token-budgets-i-10805180.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
