# Chat Prompt 2026-06-17

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {APPO}: Agentic Procedural Policy Optimization

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-17 - APPO: Agentic Procedural Policy Optimization

## 基本情報

- **タイトル**: APPO: Agentic Procedural Policy Optimization
- **著者**: Xucong Wang, Ziyu Ma, Yong Wang, Yuxiang Ji, Shidong Yang, Guanhua Chen, Pengkun Wang, Xiangxiang Chu
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: arXiv:2606.12384 / https://arxiv.org/pdf/2606.12384

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントの強化学習で、ツール呼び出し単位ではなく、生成系列中の「重要な意思決定トークン」に分岐と信用割当を移す APPO を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の agentic RL はツール呼び出し境界、固定ワークフロー、thinking block など粗い単位で credit assignment していた。APPO は、重要な分岐点がツール呼び出し周辺だけでなく reasoning 全体に分布すること、かつ高エントロピーだけでは重要点を選べないことを示し、より細かい procedure 単位で探索する。13ベンチマークで強い agentic RL ベースラインを平均約3〜4ポイント改善したと報告している。
- **技術や手法の肝はどこ？**: Branching Score が中核。各トークンについて、局所的な不確実性である entropy と、現在方策が旧方策に比べて後続 continuation の尤度をどれだけ押し上げるかを表す future value を組み合わせる。これにより、単なる珍しい語や表層的に不確実な語ではなく、後続推論を実際に変える意思決定点を選んで分岐する。さらに procedure-level advantage scaling と dual-group advantage estimation により、初期 rollout と分岐 rollout を適切に比較して credit を配る。
- **どうやって有効だと検証した？**: 数学推論、知識集約型推論、DeepSearch 系の計13ベンチマークで評価。数学では AIME24/25, MATH500, GSM8K, MATH、QAでは HotpotQA, 2WikiMultihopQA, Musique, Bamboogle, WebWalker、DeepSearch では GAIA, Humanity’s Last Exam, Xbench などを用いた。GRPO, DAPO, GPPO, CISPO, GIGPO, ARPO, ReAct, RAG, Search-o1, WebThinker などと比較し、APPO が多くの設定で最高性能。アブレーションでは Branching Score を entropy のみに置換、future-aware advantage を削除、dual-group を削除すると性能が落ちる。
- **議論はある？**: Branching Score の有効性は、future value が実際の成功確率差の代理になるという仮定に依存する。PDF本文では理論的な variance reduction と policy improvement bound を示すが、条件付き報酬分散が BS と単調関係にあるなどの仮定がある。評価は抽出テキスト上では主に既存ベンチマークと LLM-as-a-Judge に基づき、実運用エージェントでのコスト、安定性、ツール環境差への頑健性は追加確認が必要。
- **次に読む/試すなら**: APPO の Branching Score を既存の tool-use RL 実装に入れて、entropy-only 分岐と比較する。ARPO / Tree-GRPO / GIGPO との違いをコードレベルで整理する。自分のエージェントログで「高entropyだが無意味な語」と「推論方針を変える語」が分離できるか可視化する。
- **キーワード**: `agentic RL`, `credit assignment`, `LLM agents`, `procedural branching`, `Branching Score`, `tool-use`, `policy optimization`

## 気になったこと

- future value が「後続推論の重要性」をどの程度安定して近似できるのか。
- 分岐点選択の計算コストが、通常の agentic RL や ARPO と比べてどれだけ増えるのか。
- LLM-as-a-Judge を使うタスクで、評価器バイアスが APPO の改善幅に影響していないか。
- procedure という単位がモデル・タスク・プロンプトをまたいでどれだけ再利用可能なのか。
- 実装するなら、VeRL 上の PPO/GRPO 系ループに Branching Score と dual-group advantage をどう差し込むのが最小変更か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
