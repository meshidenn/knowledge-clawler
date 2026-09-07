# Paperpile Brief 2026-09-08 - DRACO: Fine-grained credit assignment with dynamic rubrics for long-horizon agent training

## 基本情報

- **タイトル**: DRACO: Fine-grained credit assignment with dynamic rubrics for long-horizon agent training
- **著者**: Shubham Gandhi, Saurabh Goyal, Kiran Kate, Yara Rizk
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2609.04094](https://arxiv.org/abs/2609.04094) / [コード](https://github.com/IBM/draco)

## 落合陽一フォーマット

- **ひとことでいうと**: 正解判定器のない長期エージェントRLで、動的に生成した評価ルーブリックを使い、「どのステップが良かった／悪かったか」に応じてGRPOの学習信号を再配分するDRACOを提案した。
- **先行研究と比べてどこがすごい？**: 従来のルーブリック報酬は軌跡全体へ単一スカラーを与えがちで、長い行動列のクレジット割当が粗い。DRACOは、検証器・正解答・学習済み帰属モデル・各ステップごとの判定呼び出しなしに、ルーブリックの判定根拠をステップ単位のadvantageへ変換する。AppWorld TNでベースモデル比+15.9ポイント、疎な正解報酬で学習したGRPO比+5.3ポイントを報告している。
- **技術や手法の肝はどこ？**: 各ロールアウト群について、タスク指示と実際の軌跡から判定器LLMがルーブリックを動的生成・統合し、各基準をpass/fail/N/Aで採点する。軌跡のGRPO advantageは保ったまま、基準が引用した各ステップのpass/fail比率に応じて重み付けして再配分する。正のadvantageでは良いステップを強化し、負のadvantageでは悪いステップを抑制する設計で、冗長に長い出力が過大に更新されないようステップ長でも補正する。
- **どうやって有効だと検証した？**: Qwen3.6-27BをAppWorldで100ステップ学習し、動的ルーブリックとステップ帰属の有無を切り替えるablation、正解報酬ベースライン、自己判定器版と比較した。AppWorld TNではDRACOがTGC 85.3%、ベースは69.4%、動的ルーブリックも帰属も除いた版は81.1%だった。未学習ドメインのτ-benchでも、ベース比+5.3ポイントの改善を報告している。
- **議論はある？**: ルーブリック生成・統合・採点の品質が判定器LLMに強く依存する。自己判定器は外部のGPT-5.4判定器より性能が落ち、特に基準の網羅的生成や不要基準の除去が弱い。また「outcome-blind」は学習時に正解検証器を使わないという意味であり、評価時にはAppWorldの正解判定を用いる。判定コストも無視できず、フロンティア判定器版は100ステップで約1,607ドルと報告されている。
- **次に読む/試すなら**:
  1. コードで、ルーブリックの生成・統合・採点プロンプトとステップ引用形式を確認する。
  2. 自分のエージェント軌跡に対し、固定ルーブリック版と動的ルーブリック版を比較する。
  3. 判定器を小型モデルへ置き換え、採点の一貫性・コスト・最終性能のトレードオフを測る。
- **キーワード**: `long-horizon agents`, `outcome-blind RL`, `GRPO`, `credit assignment`, `dynamic rubrics`, `LLM judge`

## 気になったこと

- ルーブリックが「相互排他的かつ網羅的」であることをどの程度保証できるか。重複した基準は、特定ステップへの報酬を過大計上し得る。
- 判定器がステップを誤引用した場合の影響と、引用なし時に通常GRPOへフォールバックする頻度を確認したい。
- AppWorld以外の、曖昧な成功条件やユーザー嗜好を含む実運用タスクで、ルーブリック報酬の代理指標化をどこまで抑えられるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [gandhi2026-hg-draco-fine-grained-credit-assignment-with-dynamic-rubrics-21ade74e.md](../../chat/2026-09-08/gandhi2026-hg-draco-fine-grained-credit-assignment-with-dynamic-rubrics-21ade74e.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
