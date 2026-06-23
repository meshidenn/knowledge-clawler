# Chat Prompt 2026-06-24

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {FAPO}: Fully Autonomous Prompt Optimization of multi-step {LLM} pipelines

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-24 - {FAPO}: Fully Autonomous Prompt Optimization of multi-step {LLM} pipelines

## 基本情報

- **タイトル**: {FAPO}: Fully Autonomous Prompt Optimization of multi-step {LLM} pipelines
- **著者**: Paul Kassianik, Baturay Saglam, Huaibo Zhao, Blaine Nelson, Supriti Vijay, Aman Priyanshu, Amin Karbasi
- **年 / venue**: 2026 / arXiv [cs.SE]
- **リンク**: https://arxiv.org/pdf/2606.19605 （本文中 arXiv:2606.19605v2, 2026-06-20。DOI はメタデータからは不明）

## 落合陽一フォーマット

- **ひとことでいうと**: マルチステップLLMパイプラインを、Claude Codeが評価・失敗帰属・修正提案・検証まで回して、プロンプトだけでなく必要ならチェーン構造まで自律最適化するFAPOを提案した論文。

- **先行研究と比べてどこがすごい？**: GEPAやDSPy系のような「固定パイプライン内のプロンプト最適化」に留まらず、各ステップの中間出力を見て、失敗が検索・推論・整形・制約遵守のどこで始まったかを帰属し、許可された範囲でパイプライン構造にも踏み込む。6ベンチマーク×3モデルでGEPAに15/18勝ち、平均 +14.1 pp。HoVerとIFBenchのように構造変更が効くタスクでは平均 +33.8 pp の改善を報告している。

- **技術や手法の肝はどこ？**: tenant単位の標準化されたコードワークスペースを作り、LangGraphのパイプライン、プロンプト、スコアラー、データ分割、変更可能範囲を明示する。Claude Codeの最適化エージェントが、評価実行、step-attribution subagentによる失敗分類、variant-reviewer subagentによるスコープ・リーク・スコアラー互換性チェックを経て、1回に1つのスコープ付き変更を試す。基本は prompt-first で、プロンプト修正では解けない構造的ボトルネックが記録証拠から見えた場合だけ、検索ホップ追加や決定的ポストプロセス追加などに進む。

- **どうやって有効だと検証した？**: HotpotQA, HoVer, IFBench, LiveBench-Math, AIME, Papillonの6ベンチマークで、GPT-4.1-mini, GPT-5.4-mini, Gemma 3-12Bを使いGEPA再現実装と比較。各セルは3試行平均±標準偏差で、最良validation選択variantのtest scoreを報告。CTIBench-RCMではprompt-only制約でGPT-5とFoundation-Sec系2モデルを評価し、test accuracyをそれぞれ +4.0 pp, +7.1 pp, +2.0 pp 改善した。

- **議論はある？**: GEPA比較ではFAPOの探索空間が広く、完全な同条件比較ではない。構造変更を許すと経路依存が大きく、HoVerやIFBenchでは標準偏差も大きい。AIMEではGEPAが全モデルで上回り、FAPOの改善は不安定で、少数サンプルへの過適合可能性が示唆されている。さらにClaude CodeやClaude Opus 4.6 reflectorなど、強い外部オーケストレータへの依存があり、コスト・再現性・モデル更新への感度は追加確認が必要。

- **次に読む/試すなら**: FAPOのGitHub実装を見てtenant構造とscope contractの実装を確認する。自分のRAG/評価パイプラインで中間出力ログと失敗帰属を追加し、prompt-only最適化との比較を小さく再現する。GEPA, DSPy/MIPRO, TextGradとの探索空間・評価分割・リーク対策の違いを整理する。

- **キーワード**: `prompt optimization`, `LLM pipeline`, `Claude Code`, `LangGraph`, `failure attribution`, `GEPA`, `agentic optimization`, `pipeline optimization`

## 気になったこと

- FAPOの「構造変更」は強力だが、どこまでを許すとベンチマーク特化の手作業的最適化になるのか。
- variant-reviewerが本当にデータリークやスコアラー汚染を防げるか、攻撃的・高圧な最適化ループで検証したい。
- Claude Code依存の最適化能力が、他のコードエージェントや小型オープンモデルのオーケストレータでも再現するか。
- AIMEで弱い理由が、数学推論の難しさなのか、サンプル数・スコアラー・探索方針の問題なのかを切り分けたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
