# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Learning Multi-Agent Coordination via Sheaf-{ADMM}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - Learning Multi-Agent Coordination via Sheaf-ADMM

## 基本情報

- **タイトル**: Learning Multi-Agent Coordination via Sheaf-ADMM
- **著者**: Jeffrey Seely, Bartłomiej Cupiał, Llion Jones
- **年 / venue**: 2026 / arXiv [cs.LG], ICML 2026
- **リンク**: arXiv:2605.31005v1 / https://arxiv.org/pdf/2605.31005

## 落合陽一フォーマット

- **ひとことでいうと**: 局所視野しか持たない複数エージェントを、cellular sheafで定義した「どこを合意すべきか」に従ってADMMで協調させ、全体として迷路、MNIST、Sudokuを解く微分可能な最適化レイヤを提案した論文。
- **先行研究と比べてどこがすごい？**: 固定sheafを使う既存のmulti-agent ADMMを、encoder/decoderと制約写像まで含めてend-to-end学習可能にした点が差分。通常のMPNNと違い、各agentが `x` = local proposal、`z` = consensus、`u` = dual accumulator を明示的に持つため、協調過程を解析・介入しやすい。Sudokuでは1.12M parametersで92.6% solve rateを出し、parameter-matched MPNNの10.7%を大きく上回る。
- **技術や手法の肝はどこ？**: 入力をoverlapping local viewsに分解し、各agentの局所凸目的関数をneural encoderでパラメータ化する。agent間の整合性は、全状態一致ではなく、sheafのrestriction mapで低次元edge stalkへ射影した値の一致として定義する。ADMMの `x-update` で局所最適化、`z-update` でsheaf Laplacianによるconsensus projection、`u-update` で不一致履歴を蓄積し、固定回数unrollして逆伝播する。
- **どうやって有効だと検証した？**: MNIST分類、19×19 maze pathfinding、9×9 Sudokuで評価。MazeではSheaf-ADMMがtest solve rate 99.9%、2×OODで98.1%を示し、同parameterのMPNNよりOODで強い。MNISTではpadding、patch dropout、Gaussian noise下でCNNより頑健。Sudokuではcell accuracy 99.5%、solve rate 92.6%。ablationでは、coordinationなし、identity maps、learned shared maps、LoRA付きrestriction maps、`x/z` update方式、ADMM iteration数を比較している。
- **議論はある？**: 前提は「問題が局所subproblemに分解でき、局所制約/messageで整合できる」こと。非局所統計が必要な問題、agent graphが依存構造とずれる問題、restriction mapが高次元・密になって疎通信の利点が消える場合、長距離協調に対してunroll horizon `K` やdiffusion steps `T` が足りない場合は弱い。PDF抽出テキスト上では、細かい表の数値は一部レイアウト崩れがあり得る。
- **次に読む/試すなら**: 1. Mazeの最小実装で `x,z,u` の残差可視化を再現する。2. MPNN baselineと同じgraph/encoder/decoderでADMM updateだけ差し替えるablationを試す。3. restriction mapのedge stalk次元 `de` とvertex stalk次元 `dv` の比率を小規模タスクで掃く。
- **キーワード**: `Sheaf-ADMM`, `multi-agent coordination`, `cellular sheaf`, `ADMM`, `differentiable optimization`, `MPNN`, `Sudoku`, `maze pathfinding`

## 気になったこと

- sheafのrestriction mapが実際に「意味のある合意変数」を学習しているのか、可視化・介入でどこまで説明できるか。
- Sudokuのような離散制約問題で、ADMM由来の連続latent dynamicsがなぜMPNNより強く効くのか。
- OOD mazeで39×39以降に落ちる原因がiteration budgetなのか、local representation capacityなのか。
- `K`を増やすと性能が劣化するという記述があり、deep unrollのgradient degradation対策が必要そう。
- 非gridデータや動的環境でagent graphをどう設計・学習するのがよいか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
