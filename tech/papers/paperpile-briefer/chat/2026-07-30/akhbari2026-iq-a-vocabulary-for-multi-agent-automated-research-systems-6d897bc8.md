# Chat Prompt 2026-07-30

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- A vocabulary for multi-agent automated research systems

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-30 - A vocabulary for multi-agent automated research systems

## 基本情報

- **タイトル**: A vocabulary for multi-agent automated research systems
- **著者**: Bardiya Akhbari
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.22682v1

## 落合陽一フォーマット

- **ひとことでいうと**: multi-agent automated research system を、agent・operation・communication・capability・state・policy・initialization・evaluator の座標で記述するための共通語彙を提案した論文。
- **先行研究と比べてどこがすごい？**: 「multi-agent が効いた」という曖昧な主張を、通信構造、権限設計、cross-run memory、初期化、評価器などのどの設計差分によるものかに分解できる点が肝。特に evaluator を外部の採点器ではなくシステム構成要素として扱い、proxy score と真の品質のズレを明示している。
- **技術や手法の肝はどこ？**: システムを `M = <A, O, C, α, S, π, ι, e>` として定式化する。`A` は agent、`O` は操作集合、`C` は通信構造、`α` は誰が何を実行できるか、`S` は within-run / world / cross-run state、`π` は制御方策、`ι` は初期化、`e` は評価器。さらに trajectory を「task から artifact までの実行記録」として扱い、同じ task でも stochastic な system は trajectory 分布を生むと見る。
- **どうやって有効だと検証した？**: 新しい benchmark 実験ではなく、AIRA, Glia, Automated Alignment Researcher, AI Scientist-v2, MetaGPT, EvoX, ml-intern, SimpleTES, Engram など既存の autoresearch / agent system をこの語彙で整理し、構造の違いを表現できることを示している。
- **議論はある？**: 実証的な性能改善を示す論文ではなく、分類・記述のための conceptual framework に近い。各座標の独立性は設計上は有用だが、実際の system では agent 数、通信、memory、policy、評価器が絡み合うため、完全に一変数だけを変えた比較は難しい。また、PDF本文上ではこの語彙自体の網羅性や予測力を定量評価した結果は見当たらない。
- **次に読む/試すなら**: 自分の agent 実験を `M = <A, O, C, α, S, π, ι, e>` で棚卸しする。次に、既存 system の改善主張がどの座標の変更なのかを表にする。最後に、evaluator の proxy-quality gap を明示した ablation 設計を作る。
- **キーワード**: `multi-agent systems`, `automated research`, `agent architecture`, `trajectory`, `evaluator`, `cross-run memory`, `capability assignment`

## 気になったこと

- 「generative taste」と「evaluative taste」の分離は有用そうだが、実装上どう測るかは追加確認したい。
- agent 数そのものより architecture-task alignment が重要という示唆は、手元の agent workflow 評価にも使えそう。
- `α`、つまり capability assignment を独立した設計軸にしている点は、least privilege な agent harness 設計にそのまま応用できる。
- この語彙を使って既存の自動実験環境や Codex/Claude Code 系 workflow を記述すると、どの差分を ablation すべきか見えそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
