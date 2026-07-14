# Chat Prompt 2026-07-15

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Remember when it matters: Proactive memory agent for long-horizon agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-15 - Remember when it matters: Proactive memory agent for long-horizon agents

## 基本情報

- **タイトル**: Remember When It Matters: Proactive Memory Agent for Long-Horizon Agents
- **著者**: Yifan Wu, Lizhu Zhang, Yuhang Zhou, Mingyi Wang, Bo Peng, Serena Li, Xiangjun Fan, Zhuokai Zhao
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2607.08716 / Code: https://github.com/yifannnwu/proactive-memory-agent

## 落合陽一フォーマット

- **ひとことでいうと**: 長期タスク中にエージェントが過去の重要情報を行動に反映できなくなる「behavioral state decay」を、別プロセスの memory agent が必要な瞬間だけリマインドして防ぐ論文。
- **先行研究と比べてどこがすごい？**: メモリを単なる保存・検索・要約ではなく、「いつ介入するか」を決める制御問題として扱う点が新しい。Terminal-Bench 2.0 と τ²-Bench で、弱い action agent だけでなく強い action agent に対しても pass@1 を改善している。
- **技術や手法の肝はどこ？**: action agent は改変せず、並走する memory agent が recent trajectory と memory bank を読む。Phase 1 で status / knowledge / procedural memory を更新し、Phase 2 で `<context_for_action>` として短い reminder を注入するか、`<no_intervention/>` で沈黙するかを選ぶ。
- **どうやって有効だと検証した？**: Terminal-Bench 2.0 と τ²-Bench で評価。Claude Sonnet 4.5 の action agent では Terminal-Bench が 37.6% → 45.9%、τ²-Bench が 55.0% → 61.8%。Opus 4.6 action agent でも小幅改善。さらに full-bank exposure、always inject、injection-only、Mem0 との ablation を行い、維持されたメモリと選択的介入の組み合わせが最もバランスよく効くことを示した。
- **議論はある？**: 介入の校正がまだ難しい。不要な reminder、既知情報の反復、推測を強く出しすぎるケースがある。memory agent に frontier model call が必要な構成ではコストとレイテンシも問題になる。固定間隔で呼ぶ設計なので、呼び出しタイミング自体を学習する余地が残る。
- **次に読む/試すなら**: 1. GitHub 実装で memory bank の schema と intervention prompt を確認する。2. 自分の coding agent loop に「failed attempts / open subgoals」だけを保持する最小版を試す。3. Mem0 や Reflexion 系との比較条件を詳しく読む。
- **キーワード**: `long-horizon agents`, `agent memory`, `behavioral state decay`, `proactive intervention`, `Terminal-Bench`, `tau2-Bench`

## 気になったこと

- どのくらいの頻度で memory agent を呼ぶと、性能・コスト・邪魔さのバランスが最適になるのか。
- reminder が action agent の探索を狭めすぎるケースはどの程度あるのか。
- memory bank の status / knowledge / procedural という分割は、coding agent 以外の業務エージェントにもそのまま効くのか。
- open-weight memory agent の学習では、pivot turn のラベル設計が性能をかなり左右しそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
