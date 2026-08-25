# Paperpile Brief 2026-08-26 - Let’s Scale Step by Step: Compute-Efficient Hyperparameter Transfer for Large-Scale Mixture-of-Experts

## 基本情報

- **タイトル**: Let’s Scale Step by Step: Compute-Efficient Hyperparameter Transfer for Large-Scale Mixture-of-Experts
- **著者**: Nayeon Kim, Hojin Lee, Yunju Bak, Jaesun Park, Boseop Kim
- **年 / venue**: 2026 / COLM 2026（arXiv:2608.20061）
- **リンク**: [arXiv Abstract](https://arxiv.org/abs/2608.20061) / [PDF](https://arxiv.org/pdf/2608.20061.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: 巨大MoEの学習率探索を、µPによるモデル幅方向の転写とトークン数方向の外挿に分解し、小規模proxy実験だけから10Tトークン学習用の学習率を推定する手法。
- **先行研究と比べてどこがすごい？**: 従来のµP/µ-Transferは主にdenseモデルの幅スケーリングを対象としたのに対し、MoEの専門家数増加による疎性拡大も含めて扱う。モデル規模とトークン予算の二次元探索を、幅転写＋一次元のトークン外挿へ置き換え、155B総パラメータ・17B activeのMoEを10Tトークンで事前学習まで実証した。
- **技術や手法の肝はどこ？**: 行列型パラメータだけにµPの初期化・学習率スケーリングを適用し、expert FC1・routerを行列型、expert FC2をベクトル型として扱う。小規模モデルを複数の学習率で学習し、各トークン時点の損失と対数学習率を二次式フィットして最適学習率を得る。さらに最適学習率とトークン数をlog-log線形回帰し、長期学習の学習率へ外挿する。
- **どうやって有効だと検証した？**: 0.6B→30.7BのMoE幅スケールで、標準パラメータ化では最適学習率がずれる一方、µPでは転写できることを示した。10.8B/3.3B activeのproxyを約500Bトークン学習し、255B以降のデータから10T時点の最適学習率を`3.85×10^-4`と推定（`R²=0.95`）。held-outの約500Bトークン近傍では平均誤差約4.4%で、最終的な155B/17B activeモデルの10T学習でも損失は安定した。
- **議論はある？**: 10Tトークン・155Bモデルで学習率スイープをして直接最適性を検証してはいないため、最終的な「最適」性は安定損失と評価結果からの間接的な裏付けである。対象は主に学習率で、batch size、深さスケーリング、異なるMoEルーティング設計やoptimizerへの一般化は未検証。外挿は同一の学習設定・データ分布・WSD schedulerを保てることに依存する。
- **次に読む/試すなら**:
  1. 自前MoEで、µPあり／なしの幅スケール間学習率転写を小規模に再現する。
  2. proxyの各checkpointで損失対log LRを二次式フィットし、トークン数対最適LRのlog-log回帰を実装する。
  3. batch size変更、expert数のみの増加、別optimizerで外挿則が維持されるか検証する。
- **キーワード**: `Mixture-of-Experts`, `µP`, `µ-Transfer`, `learning-rate scaling`, `hyperparameter transfer`, `scaling laws`, `Muon`

## 気になったこと

- 10Tトークンへの外挿は255B〜502Bの範囲から行っており、外挿倍率が大きい。データ分布変更や学習後半の能力獲得フェーズでも同じ則が保たれるか確認したい。
- 最適化対象を学習率に絞っているが、MoEではrouter設定、load balancing、active expert数、batch sizeとの相互作用が大きい。複数ハイパーパラメータへ拡張できるかが実運用上の焦点になる。
- 評価ベンチマークの絶対スコアや比較モデルの詳細は、PDF抽出テキストからは断定しにくい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [kim2026-le-let-s-scale-step-by-step-compute-efficient-hyperparameter-tra-84875625.md](../../chat/2026-08-26/kim2026-le-let-s-scale-step-by-step-compute-efficient-hyperparameter-tra-84875625.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
