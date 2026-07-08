# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {EurekAgent}: Agent environment engineering is all you need for autonomous scientific discovery

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - EurekAgent: Agent environment engineering is all you need for autonomous scientific discovery

## 基本情報

- **タイトル**: EurekAgent: Agent environment engineering is all you need for autonomous scientific discovery
- **著者**: Amy Xin, Jiening Siow, Junjie Wang, Zijun Yao, Fanjin Zhang, Jian Song, Lei Hou, Juanzi Li
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2606.13662 / https://github.com/THU-Team-Eureka/EurekAgent

## 落合陽一フォーマット

- **ひとことでいうと**: 自律的な科学的発見では、agentの細かいworkflowを設計するより、権限・成果物・予算・人間介入を含む「環境」を設計することが重要だと主張し、その実装としてEurekAgentを提案した論文。
- **先行研究と比べてどこがすごい？**: AlphaEvolveやAIDE系のように探索手順や役割分担を強く規定するのではなく、Claude Codeのような汎用CLI agentを使い、外側の実行環境だけを設計する。数学最適化、GPU kernel engineering、MLE-Bench Lite subsetで既存AI・人間ベースラインを上回る結果を報告している。
- **技術や手法の肝はどこ？**: 中核は「environment engineering」の4分割。評価汚染や改ざんを防ぐpermissions engineering、filesystemとGitで進捗を共有するartifact engineering、時間・API costを制御するbudget engineering、TUI/Web monitorで介入可能にするhuman-in-the-loop engineering。agent本体には詳細な研究手順を押し付けず、prepare → propose → parallel implementの外枠だけを与える。
- **どうやって有効だと検証した？**: 3領域で評価している。数学では26-circle packing、Erdős minimum overlap、first autocorrelation inequalityで新SOTAを報告。Kernel engineeringではGPUMODE TriMulをA100上で再評価し、既存上位solutionより高速な複数解を発見。ML engineeringではMLE-Bench Liteから選んだ7 taskでany medal rate 85.71%を報告している。ただしMLE-Benchはcurated subsetであり、全体ベンチマークではない。
- **議論はある？**: 評価対象は「明確なmetricと実行可能evaluatorがある問題」に寄っており、仮説生成や実験設計そのものが曖昧な科学領域への一般化は未検証。TriMulは公式leaderboardが閉じていたためlocal再評価であり、完全な公式比較ではない。MLE-Benchも7 task subsetなので選択バイアスの余地がある。細かい数値はPDF抽出上の表崩れもあり、原PDF確認が必要。
- **次に読む/試すなら**: EurekAgentのGitHub実装を見て、permissions/artifact/budgetの設計がどこまで汎用化されているか確認する。自分の研究タスクを「metric-driven + hidden evaluator + Git artifact」に落とせるか検討する。ResearchClawBenchやAlphaEvolve/OpenEvolve系との比較軸を整理する。
- **キーワード**: `autonomous scientific discovery`, `agent environment engineering`, `CLI agent`, `artifact management`, `hidden evaluator`, `budget-aware exploration`, `MLE-Bench`, `kernel engineering`

## 気になったこと

- 「環境設計だけで十分」という主張は強いが、実際にはClaude CodeやGLM-5.1の能力、hidden evaluator設計、Web search利用、既存公開解の発見能力にかなり依存していそう。
- 26-circle packingでは既存AlphaEvolve解をWeb searchで見つけてから改良しているため、「発見」と「既存解の探索・改良」の境界をどう扱うか確認したい。
- 同一agent・同一budgetで、workflow-heavy systemとenvironment-engineered systemを直接ablationしているかは本文からは限定的に見える。
- Reward hacking防止を掲げているが、hidden evaluatorやread-only result fileだけでどの程度防げるのか、攻撃的agentに対する検証が欲しい。
- MLE-Bench Lite subsetの選定基準は説明されているが、全22 taskでの成績や失敗例の分析も見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
