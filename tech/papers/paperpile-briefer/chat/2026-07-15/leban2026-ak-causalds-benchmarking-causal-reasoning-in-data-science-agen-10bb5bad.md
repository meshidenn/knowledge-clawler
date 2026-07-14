# Chat Prompt 2026-07-15

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {CausalDS}: Benchmarking Causal Reasoning in Data-Science Agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-15 - CausalDS: Benchmarking Causal Reasoning in Data-Science Agents

## 基本情報

- **タイトル**: CausalDS: Benchmarking Causal Reasoning in Data-Science Agents
- **著者**: Andrej Leban, Yuekai Sun
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2607.08093

## 落合陽一フォーマット

- **ひとことでいうと**: データサイエンスagentが、自然言語の因果ストーリー、表形式データ、観測ノイズ、不識別性を含む状況で、因果推論を本当にできるか測るベンチマーク CausalDS を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の因果推論ベンチマークは記号的なグラフ推論に寄りがちで、データ分析ベンチマークは因果生成構造を持たないことが多い。CausalDS は隠れた SCM、合成データ、自然言語ストーリー、Pearl の3階層タスク、観測モデル、不識別時の abstention を一体で評価する点が新しい。
- **技術や手法の肝はどこ？**: DAG motif や grafting で合成因果グラフを作り、SCM から観測データと ground truth を生成する。さらに概念上の因果変数と公開される noisy measurement を分離し、agent には story、schema、data、task だけを渡す。評価側は隠れた SCM と ground truth で、予測、関連、同定、効果推定、bias 診断、counterfactual などを決定的に採点する。
- **どうやって有効だと検証した？**: 複数の現代的 agent / model に CausalDS exam を解かせ、Pass Rate、正規化誤差、SNR、ATE 区間の coverage、abstention 成功率、tool call 数、token 使用量などで比較している。本文では Claude Opus 4.8、GPT-5.5、Gemini 3.1 Pro、Qwen 3.6 35B、Kimi K2.6、Gemma 4 26B などの結果が報告され、特に uncertainty quantification と abstention で差が出る。
- **議論はある？**: PDF本文によると、構造理解や点推定だけでは差がつきにくく、難所は「推定値がどれだけ信用できるか」と「答えるべきでない時に abstain できるか」にある。限界として、提示された exam はまだ規模や構成の一例であり、より大きく多様な exam、trajectory-level の失敗分類、abstention や counterfactual 専用ストレステストが今後の課題とされている。
- **次に読む/試すなら**: 
  1. GitHub 実装 `github.com/andleb/causalds` を確認し、scene 生成と grader の構造を見る。
  2. 自分の agent に clean / proxy / hard observation の小規模タスクを解かせ、abstention と UQ の失敗を分類する。
  3. CausalBench、CLEAR、CausalGame、CausSciBench など近いベンチマークとの差分を整理する。
- **キーワード**: `causal reasoning`, `data-science agents`, `SCM`, `benchmark`, `abstention`, `uncertainty quantification`, `Pearl's hierarchy`

## 気になったこと

- synthetic scene の自然言語 story がどの程度 graph-faithful か、監査プロセスの失敗率や人手確認の有無を確認したい。
- 不識別タスクでの abstention 評価が、実運用の「保守的に答えない」挙動をどこまで適切に測れているか気になる。
- noisy measurement を含む observation layer で、agent が measurement model を推定すべきなのか、単に robust estimation すべきなのか、タスクごとの期待解法を見たい。
- ベンチマークが完全合成である一方、実データ由来の empirical distribution anchoring がどこまで現実性を担保しているか確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
