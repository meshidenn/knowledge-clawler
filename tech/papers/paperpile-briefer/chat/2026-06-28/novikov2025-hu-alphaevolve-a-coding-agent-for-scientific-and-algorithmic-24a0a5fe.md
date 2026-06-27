# Chat Prompt 2026-06-28

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {AlphaEvolve}: A coding agent for scientific and algorithmic discovery

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-28 - AlphaEvolve: A coding agent for scientific and algorithmic discovery

## 基本情報

- **タイトル**: AlphaEvolve: A coding agent for scientific and algorithmic discovery
- **著者**: Alexander Novikov, Ngân Vũ, Marvin Eisenberger, Emilien Dupont, Po-Sen Huang, Adam Zsolt Wagner, Sergey Shirobokov, Borislav Kozlovskii, Francisco J. R. Ruiz, Abbas Mehrabian, M. Pawan Kumar, Abigail See, Swarat Chaudhuri, George Holland, Alex Davies, Sebastian Nowozin, Pushmeet Kohli, Matej Balog
- **年 / venue**: 2025 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2506.13131 / arXiv:2506.13131

## 落合陽一フォーマット

- **ひとことでいうと**: LLMにコード差分を生成させ、実行評価をフィードバックにして進化的にアルゴリズムを改善する科学・工学発見エージェント AlphaEvolve の白書。
- **先行研究と比べてどこがすごい？**: FunSearch が主に短い単一関数を進化させていたのに対し、AlphaEvolve は複数関数・数百行規模・任意言語・複数評価指標・長時間/並列評価まで扱う。4×4複素行列積で48スカラー乗算の手続きを見つけ、Strassen以来の改善と主張している。数学50件超では約75%で既知最良に一致し、約20%でSOTA超え。Google実インフラでもデータセンター資源0.7%回収、Gemini向けカーネル平均23%高速化、学習時間1%削減などを報告。
- **技術や手法の肝はどこ？**: 人間が「何を最適化するか」を評価関数として定義し、AlphaEvolve が「どう改善するか」をコード変更として探索する。初期プログラムの `EVOLVE-BLOCK` をLLMがdiffで書き換え、評価器がスコアを返し、良いプログラムをデータベースに蓄積する。過去の良解・失敗・評価結果・問題文脈をプロンプトに入れ、LLM ensemble、prompt sampler、program database、evaluator pool を回す進化ループが中心。
- **どうやって有効だと検証した？**: 行列積アルゴリズム、構成的数学問題、Googleのスケジューリング、TPU/Pallasカーネル最適化などで評価。数学では自動検証可能な構成を比較し、工学ではシミュレータ、未見ワークロード、実TPU上のランタイム、実運用デプロイ後の計測を使っている。PDF本文は16ページ分抽出されており、後半・付録の詳細は抽出範囲外の可能性がある。
- **議論はある？**: 最大の制約は「自動評価できる問題」に依存する点。評価関数が弱い、代理指標が本質からズレる、探索空間の設計が悪い場合は成果も歪む。Google内部インフラでの成果は再現環境・データ・コストが外部から検証しにくい。数値改善は抽出本文上では一部しか確認できず、細かい表や付録の完全性はメタデータからは不明。
- **次に読む/試すなら**: 1. FunSearchとの差分を実装観点で整理する。2. 小さな最適化問題で `initial program + evaluator + evolutionary LLM loop` の最小再現を作る。3. arXiv PDF本体と公開Colabの数学結果を確認する。
- **キーワード**: `LLM coding agent`, `evolutionary computation`, `program synthesis`, `automated discovery`, `FunSearch`, `matrix multiplication`, `scientific discovery`, `code optimization`

## 気になったこと

- 評価関数をどう設計すると「本当に欲しい発見」と「ベンチマーク攻略」を分離できるのか。
- LLMサンプル数、評価計算資源、失敗率、探索停止条件の実務的コストがどれくらいか。
- AlphaEvolveが見つけた数学的構成や行列積アルゴリズムは、人間が理解・単純化・証明再利用できる形になっているのか。
- オープンなモデルとローカル評価器で、FunSearch以上の実用的な再現が可能か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
