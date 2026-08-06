# Paperpile Brief 2026-08-07 - When many answers are valid, voting fails: Symbolic verification for best-of-{K} causal reasoning in {LLMs}

## 基本情報

- **タイトル**: When many answers are valid, voting fails: Symbolic verification for best-of-{K} causal reasoning in {LLMs}
- **著者**: Omatharv Bharat Vaidya, Connor Thomas Jerzak, Zayne Rea Sprague, Fangcong Yin, Nhat Ho
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2608.03506 / arXiv:2608.03506

## 落合陽一フォーマット

- **ひとことでいうと**: 複数の正解があり得る causal reasoning では self-consistency の多数決が壊れるため、LLM の複数推論候補を因果グラフ上の公理的妥当性で検証して選ぶ CALVER を提案した論文。
- **先行研究と比べてどこがすごい？**: 多数決、set-aware medoid、reward model、LLM judge、model confidence のような汎用スコアではなく、Pearl の因果基準そのものを executable predicate として使う点が差分。CLEAR の many-valid-answer 設定で CALVER は 42.1% に達し、汎用比較手法は約30%付近に留まる。72B judge でも差は埋まらない。
- **技術や手法の肝はどこ？**: 各候補 trace を `graph`, `query`, `strategy`, `derivation record`, `computed result`, `answer` の6スロットに構造化し、d-separation、m-separation、backdoor adjustment、intervention graph surgery、ATE 再計算などで各スロットを決定的に採点する。最終的には最高スコア候補、同点なら最初の候補を返す。
- **どうやって有効だと検証した？**: CLEAR clean core、bnlearn の Bayesian network、graph-from-text 条件、CausalGraph2LLM、DoVerifier、Knights and Knaves logic task、ATE threshold decision で評価。K=32 まで sampling budget を増やすと CALVER と plurality の差が広がる。ATE では strict certificate を満たす誤答がなかったと報告している。
- **議論はある？**: CALVER は妥当性判定を実行できる領域に依存する。答えがほぼ一意なら通常の best-of-K で十分で、テキストからグラフを安定に抽出できるなら「一度グラフを抽出して exact solver に渡す」方が強い。抽出テキスト上では、公開 Code/Data Package の完全性や再現詳細は本文中で今後提供される扱いに見える。
- **次に読む/試すなら**: 1. CALVER の trace schema を自分の causal QA タスクに合わせて最小実装する。2. backdoor adjustment set が複数ある小さな DAG で plurality と verifier selection を比較する。3. graph-from-text で query-local な関係だけ残れば十分かを実験する。
- **キーワード**: `causal reasoning`, `self-consistency`, `symbolic verification`, `best-of-K`, `d-separation`, `backdoor adjustment`, `LLM verifier`

## 気になったこと

- CALVER の強さは「妥当性 predicate が正しく実装できる」ことにかなり依存するので、未知タスクへ移すときの verifier 実装コストが気になる。
- trace contract に適応したモデルほど信号が出るため、prompt/schema training なしでどこまで使えるかを確認したい。
- graph-from-text では全体の edge-F1 より query-local signature が重要という主張が面白い。評価指標として採用できるか調べたい。
- 公開予定の Code/Data Package で、CLEAR clean core の抽出条件と checker の fail-closed 実装を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [vaidya2026-ho-when-many-answers-are-valid-voting-fails-symbolic-verifica-260ca38f.md](../../chat/2026-08-07/vaidya2026-ho-when-many-answers-are-valid-voting-fails-symbolic-verifica-260ca38f.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
