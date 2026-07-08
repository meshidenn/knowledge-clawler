# Paperpile Brief 2026-07-09 - DRACO: A cross-domain benchmark for Deep Research Accuracy, completeness, and objectivity

## 基本情報

- **タイトル**: DRACO: A cross-domain benchmark for Deep Research Accuracy, completeness, and objectivity
- **著者**: Joey Zhong, Hao Zhang, Clare Southern, Jeremy Yang, Thomas Wang, Kate Jung, Shu Zhang, Denis Yarats, Johnny Ho, Jerry Ma
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2602.11685 / https://hf.co/datasets/perplexity-ai/draco

## 落合陽一フォーマット

- **ひとことでいうと**: Deep Researchシステムを、実ユーザー由来の複雑な調査タスク100件で評価するベンチマーク「DRACO」を作った論文。
- **先行研究と比べてどこがすごい？**: 既存ベンチマークの多くが合成タスク、専門領域限定、閉形式QA寄りなのに対し、DRACOはPerplexity Deep Researchの実利用ログから匿名化・拡張・選別したタスクを使う。10ドメイン、40カ国由来の情報源、専門家設計rubricを組み合わせ、現実のopen-ended researchに近づけている。
- **技術や手法の肝はどこ？**: 生クエリをPII除去・曖昧性解消し、persona、出力形式、source指定、時間範囲、比較対象、地理範囲を付与して評価可能な調査課題に変換する点。各タスクには平均39.3個の評価基準を持つrubricを作り、factual accuracy、breadth/depth、presentation quality、citation qualityの4軸でLLM-as-a-judge採点する。
- **どうやって有効だと検証した？**: OpenAI Deep Research、Gemini Deep Research、Claude Opus、Perplexity Deep Researchを100タスクで評価。本文ではPerplexity Deep Researchが総合スコアとpass rateで最上位と報告され、Opus 4.6版でnormalized score 70.5%、pass rate 72.8%。軸別ではpresentation qualityは高い一方、factual accuracyとcitation qualityにまだ大きな余地があると示している。
- **議論はある？**: 単発turn評価であり、clarifying questionを含むmulti-turn能力は測れていない。静的ベンチマークなので将来の利用形態への一般化に限界がある。text-to-textに限定され、multimodal researchは未評価。rubric作成は専門家依存で高コスト。LLM judge間で相対順位は安定するが、絶対スコアはjudgeに依存する。
- **次に読む/試すなら**: DRACO datasetを実際に取得してタスク/rubricの粒度を見る。自分のDeep Research agentを4軸rubricで小規模評価する。失敗分析用にretrieval、source selection、planning、synthesisを分解して測るmini-benchmarkを作る。
- **キーワード**: `deep research`, `benchmark`, `LLM-as-a-judge`, `rubric evaluation`, `agent evaluation`, `citation quality`

## 気になったこと

- Perplexity由来タスクでPerplexity Deep Researchを評価しているため、タスク分布やrubric設計が自社システムに有利になっていないか確認したい。
- 「実ユーザー由来」と「LLMによるaugmentation」の間で、どこまで現実の曖昧な要求が保持されているのかが気になる。
- 実装上は、rubricの重み付けとnegative criteriaの扱いがスコアを大きく左右しそう。
- citation qualityの評価で、引用が「存在する」だけでなく、主張を本当に支持しているかをどこまで判定できるか確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhong2026-uz-draco-a-cross-domain-benchmark-for-deep-research-accuracy-c-8905539f.md](../../chat/2026-07-09/zhong2026-uz-draco-a-cross-domain-benchmark-for-deep-research-accuracy-c-8905539f.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
