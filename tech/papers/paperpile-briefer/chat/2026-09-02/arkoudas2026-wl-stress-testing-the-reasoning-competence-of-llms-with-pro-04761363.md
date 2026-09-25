# Chat Prompt 2026-09-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Stress-testing the reasoning competence of {LLMs} with proofs under minimal formalism

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-02 - Stress-testing the reasoning competence of LLMs with proofs under minimal formalism

## 基本情報

- **タイトル**: Stress-testing the reasoning competence of LLMs with proofs under minimal formalism
- **著者**: Konstantine Arkoudas, Serafim Batzoglou
- **年 / venue**: 2026 / arXiv [cs.LO]
- **リンク**: https://arxiv.org/abs/2605.12524

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの「正答」ではなく、機械検証可能な証明そのものを採点して推論能力を測るベンチマーク `PROOFGRID` を提案した論文。
- **先行研究と比べてどこがすごい？**: 最終回答だけを採点する数学・推論ベンチマークと異なり、推論過程を形式的に監査できる。短い最小形式言語 NDL を使い、知識の想起・長文脈・外部ソルバへの委譲をなるべく排除して、モデル間の能力差を高い解像度で分離する。
- **技術や手法の肝はどこ？**: 15タスクを証明作成・証明検査・証明マスキング・証明の欠損補完に分ける。軽微な表層的な書式差を許容しつつ、最初の本質的な推論失敗を特定する計測付き proof-checking pipeline を用いる。また、正答率に加えて DI、2PL IRT、Wright map、Fisher情報に基づく識別力、文脈をまたぐ推論の整合性を測る Epistemic Stability Index を導入する。
- **どうやって有効だと検証した？**: 2024年後半以降の公開・非公開モデル計24種を全タスクで評価し、出力の誤りを分析した。基礎的タスクでは最先端モデルが強い一方、グローバルな組合せ推論や低レベルの証明合成を要する難問は未解決だった。例として PL1-PW では GPT-4.1 が35%、DeepSeek 3.1が49%、Gemini 2.5 Proが94%で、モデル差を大きく識別できた。
- **議論はある？**: 抽出PDF本文に基づく評価であり、完全な表・全タスクの数値は確認できない。最小形式論理で測る能力が、自然言語・実務・科学的発見を含む広義の推論へどこまで転移するかは別途検証が必要である。また、形式化自体が現実の推論で必要な問題設定・前提選択を切り落とす可能性がある。
- **次に読む/試すなら**:
  1. PROOFGRIDのタスク、NDL仕様、proof checkerの公開状況を確認する。
  2. 自分の利用モデルに proof writing と proof checking を分けて評価する。
  3. 正答率と、生成した根拠を後から自分で検査できるかの差を測る最小実験を作る。
- **キーワード**: `LLM reasoning`, `formal proof`, `benchmark`, `NDL`, `proof checking`, `epistemic stability`, `item response theory`

## 気になったこと

- 正しい／誤った証明の局所判定はできるのに、同じ誤りを含む証明を自分で生成してしまう「epistemic instability」は、生成と検証を別ロール・別パスで走らせる設計により改善できるか。
- NDLの表現力とタスク生成過程、訓練データへの混入可能性、評価時のプロンプト・サンプリング条件を確認したい。
- 形式証明の性能が、LeanやCoqのような実用 proof assistant、あるいはコードレビューの正しさ検査にどの程度つながるかを調べたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
