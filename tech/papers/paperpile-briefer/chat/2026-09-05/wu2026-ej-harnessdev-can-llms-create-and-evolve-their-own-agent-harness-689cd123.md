# Chat Prompt 2026-09-05

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {HarnessDev}: Can {LLMs} create and evolve their own agent harness?

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-05 - HarnessDev: Can LLMs Create and Evolve Their Own Agent Harness?

## 基本情報

- **タイトル**: HarnessDev: Can LLMs Create and Evolve Their Own Agent Harness?
- **著者**: Yuhao Wu, Jingyuan Zhang, Jiajun Shi, Xinping Lei, Qingshui Gu, Yuxuan Zhang, Zexuan Wang, Chen He, Chen Huang, Maojia Song, Zhiyuan Zeng, Shaowen Wang, Jinkai Liu, Yunfeng Shi, Jiaheng Liu, Shen Yan, Wenhao Huang, Ge Zhang, Wenxuan Zhang
- **年 / venue**: 2026 / arXiv [cs.SE]
- **リンク**: https://arxiv.org/abs/2609.01437v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMがタスクを解く能力ではなく、将来のタスクを解くための「agent harness」を自作し、実行ログから継続改良できるかを測るベンチマークHarnessDevを提案した。
- **先行研究と比べてどこがすごい？**: 従来の多くのagent benchmarkはharnessを固定条件としていた。本研究は、弱い実行可能seedからharnessを構築するCreationと、自作harnessをフィードバックで改良するEvolutionを分離し、性能・実行tokenコスト・異なる実行モデルへの転移・held-out性能まで評価する。
- **技術や手法の肝はどこ？**: 提出物を単発の回答ではなく、実行ループ、tool policy、context管理、状態、recovery、verificationを含む凍結済みの再利用可能なharnessとする。Creationでは1〜3件の開発例だけを与え、EvolutionではSWE-Pro 100件とTerminal-Bench 89件の結果を手掛かりに最大10回の正式評価を行い、別のSWE-Pro 630件で汎化を測る。
- **どうやって有効だと検証した？**: Opus 4.8、GPT-5.5、Gemini 3.1 Pro、DeepSeek V4 Pro、Qwen 3.7 Max、Seed 2.0 Proの6モデルを、コード・データ分析・執筆・調査の4領域、計2,207件で評価した。Creationでは人間設計harnessに対し、執筆では近く、ML実験では一部上回る一方、コードと調査では大きく劣後した。Evolutionでは自己実行時にheld-out改善が見られる例があるが、固定Gemini実行では多くが悪化し、改善の移植性は限定的だった。
- **議論はある？**: 人間baselineは同一実行モデルで再測定した対照ではなく、最適性も保証されない。Evolutionは各モデル・実行器の軌跡が原則1本で、統計的な不確実性を十分に見積もれない。held-out評価もEvolutionではSWE-Proに限られ、feedback最適化による過学習やharnessと実行モデルの共適応が残る。
- **次に読む/試すなら**:
  1. 自分のagent基盤を「モデル固定・harness差分」で評価し、実行loop、context圧縮、検証gateの寄与を分解する。
  2. 改良候補はfeedback scoreだけで選ばず、独立held-out taskと実行tokenコストで採択する。
  3. 実行モデルを差し替えるablationを行い、prompt・tool protocol・終了条件へのモデル依存を調べる。
- **キーワード**: `agent harness`, `self-evolving agents`, `agent benchmark`, `LLM agents`, `held-out generalization`, `execution cost`

## 気になったこと

- 人間設計referenceが異なるharness・モデル構成に基づくため、純粋なharness差分としてどこまで比較可能か確認したい。
- Evolutionの改善が「真の設計改善」なのか、100件のfeedback setへの適応なのかを切り分けるため、複数seed・複数軌跡・領域横断のheld-out評価が必要そう。
- 実際に導入するなら、生成harnessを信頼せず、sandbox、権限制御、回帰テスト、実行経路監査を必須にすべき。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
