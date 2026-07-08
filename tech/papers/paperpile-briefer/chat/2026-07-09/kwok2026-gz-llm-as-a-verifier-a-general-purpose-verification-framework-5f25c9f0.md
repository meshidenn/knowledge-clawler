# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {LLM}-as-a-Verifier: A general-purpose verification framework

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - LLM-as-a-Verifier: A general-purpose verification framework

## 基本情報

- **タイトル**: LLM-as-a-Verifier: A general-purpose verification framework
- **著者**: Jacky Kwok, Shulu Li, Pranav Atreya, Yuejiang Liu, Yixing Jiang, Chelsea Finn, Marco Pavone, Ion Stoica, Azalia Mirhoseini
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: メタデータからは DOI、arXiv ID、URL は不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMに候補解の正しさを判定させる「検証」を、agentic task向けの汎用スケーリング軸として定式化した論文。
- **先行研究と比べてどこがすごい？**: 通常のLLM judgeのように離散スコアを直接出させるのではなく、scoring token logitsの分布上の期待値から連続スコアを計算する点が新しい。これにより、スコア粒度、反復評価、評価基準分解という複数方向にverificationをスケールできると主張している。
- **技術や手法の肝はどこ？**: 候補解に対する採点を確率的に扱い、離散ラベルではなく連続的な検証スコアを得ること。さらに、細かいスコア粒度で正例・負例の分離を改善し、複数回評価で分散を下げ、criteria decompositionで評価タスクの複雑さを下げる設計になっている。
- **どうやって有効だと検証した？**: abstractベースでは、Terminal-Bench V2、SWE-Bench Verified、RoboRewardBench、MedAgentBenchで評価し、それぞれ86.5%、78.2%、87.4%、73.3%のstate-of-the-art性能を報告している。また、Claude Code拡張による進捗推定、SACやGRPOへのdense feedbackとしての利用も示したとされる。
- **議論はある？**: PDF本文がなく、abstract/メタデータベースのため詳細な実験設定、比較対象、コスト、失敗例、統計的有意性は不明。LLM自身をverifierにするため、モデル依存のバイアス、プロンプト感度、logit取得可能性、API制約、評価対象とverifierのリークの可能性は追加確認が必要。
- **次に読む/試すなら**: 1. 論文本文でranking algorithmとcriteria decompositionの具体手順を確認する。2. SWE-BenchやTerminal-Benchで既存LLM judgeとのコスト・精度比較を見る。3. 自分のagent評価ログに対して連続スコア化できるか小さく再現する。
- **キーワード**: `LLM-as-a-Verifier`, `LLM judge`, `verification`, `agentic tasks`, `continuous scoring`, `SWE-Bench`, `Terminal-Bench`, `dense feedback`

## 気になったこと

- scoring token logitsの期待値をどう定義しているのか。特に採点語彙、スケール、正規化の設計。
- repeated evaluationとcriteria decompositionのコスト増に対して、どの程度の精度改善があるのか。
- Claude Code拡張で「task progress」をどう推定しているのか。
- verifierとsolution generatorが同系統モデルの場合、自己評価バイアスをどう扱っているのか。
- RLのdense rewardとして使う場合、reward hackingや過適合が起きないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
