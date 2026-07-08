# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {OPID}: On-policy skill distillation for agentic reinforcement learning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - OPID: On-policy skill distillation for agentic reinforcement learning

## 基本情報

- **タイトル**: OPID: On-policy skill distillation for agentic reinforcement learning
- **著者**: Shuo Yang, Jinyang Wu, Zhengxi Lu, Yuhao Shen, Fan Zhang, Lang Feng, Shuai Zhang, Haoran Luo, Zheng Lian, Zhengqi Wen, Jianhua Tao
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2606.26790 / code: https://github.com/jinyangwu/OPID/tree/main

## 落合陽一フォーマット

- **ひとことでいうと**: 長期マルチターンagentのRLで、完了済みon-policy trajectoryから「スキル」を抽出し、それをtoken-levelの自己蒸留信号として使うOPIDを提案した論文。
- **先行研究と比べてどこがすごい？**: outcome-only RLは報酬が疎で中間判断のcredit assignmentが弱い。既存のskill distillationは外部skill memoryやretrievalに依存し、現在policyの状態分布とずれやすい。OPIDは現在policy自身のrolloutからhindsight skillを作るため、分布整合的で、推論時にはskill retrievalやprivileged contextが不要。
- **技術や手法の肝はどこ？**: trajectoryをepisode-level skillとstep-level skillに分ける点。episode-levelは全体のworkflowや失敗回避規則、step-levelはcritical timestepの局所判断を表す。critical-first routingで、重要局面ではstep skill、それ以外ではepisode skillを注入し、同じ応答をskillあり/なしcontextでold policyに再スコアさせる。そのlog probability差をtoken-level skill advantageとしてGRPO型のoutcome advantageに足す。
- **どうやって有効だと検証した？**: ALFWorld、WebShop、Search-based QAで、Qwen2.5-3B/7B-InstructとQwen3-1.7B-Instructを使って評価。GRPO、Skill-GRPO、OPSD、Skill-SD、RLSD、SDARなどと比較。Qwen2.5-3BではGRPOに対してALFWorld +9.3、Search-based QA +8.6、WebShop +10.9。Qwen3-1.7BではWebShop +26.5など、特に長期embodied/web taskで改善が大きい。ablationではepisode skill削除、step skill削除、routing削除の全てで性能低下。
- **議論はある？**: skill抽出にLLM-based analyzerを使うため、訓練時コストとanalyzer品質への依存がある。PDF本文上では推論時不要と説明されるが、訓練時の追加計算量・analyzerの失敗モード・他ドメインへの頑健性はさらに確認したい。数値はPDF抽出テキスト由来で、表の細部はレイアウト崩れの可能性がある。
- **次に読む/試すなら**: OPIDのGitHub実装でskill抽出promptとrouting実装を確認する。小さなALFWorld/WebShop風環境でGRPO+logprob差分蒸留だけを最小再現する。SDAR、Skill-SD、RLSDとの違いを実装単位で比較する。
- **キーワード**: `agentic reinforcement learning`, `on-policy distillation`, `skill distillation`, `GRPO`, `hindsight supervision`, `LLM agents`

## 気になったこと

- critical timestepをLLM analyzerがどう判定しているか、再現性とコストが気になる。
- skillを自然言語で注入したときのlogprob差が、本当に「よい行動」の信号になっているか、失敗trajectoryでは逆向きのノイズを拾わないか確認したい。
- 推論時skillなしで効くのは強いが、訓練時skill生成の計算量まで含めたsample efficiency比較が必要。
- Search-based QAでは改善幅が小さいケースがあり、探索型/検索型タスクでは局所skillの有効性が限定的かもしれない。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
