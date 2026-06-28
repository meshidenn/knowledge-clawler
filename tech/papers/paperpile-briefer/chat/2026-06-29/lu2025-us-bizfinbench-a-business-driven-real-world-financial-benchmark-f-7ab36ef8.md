# Chat Prompt 2026-06-29

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {BizFinBench}: A business-driven real-world financial benchmark for evaluating {LLMs}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-29 - BizFinBench: A business-driven real-world financial benchmark for evaluating LLMs

## 基本情報

- **タイトル**: BizFinBench: A business-driven real-world financial benchmark for evaluating LLMs
- **著者**: Guilong Lu, Xuntao Guo, Rongjunchen Zhang, Wenqiao Zhu, Ji Liu
- **年 / venue**: 2025 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2505.19457v1 / arXiv:2505.19457v1 / DOI: メタデータからは不明 / code & dataset: https://github.com/HiThink-Research/BizFinBench

## 落合陽一フォーマット

- **ひとことでいうと**: 実金融サービスのユーザークエリを起点に、中国語の金融LLM評価ベンチマークBizFinBenchと、LLM-as-a-Judgeの偏りを減らすIteraJudgeを提案した論文。
- **先行研究と比べてどこがすごい？**: FinEvalやFinQA系が知識QA・静的問題・文書QA寄りだったのに対し、長文コンテキスト、表データ、時系列、ノイズ混じりニュース、投資判断に近い因果推論を含む「業務駆動」のタスクに寄せている。25モデルを評価し、数値計算・推論・情報抽出・予測認識などでモデルごとの得手不得手を可視化した点が差分。
- **技術や手法の肝はどこ？**: iwencai APP由来の実ユーザークエリを金融専門家が整理し、5次元、9カテゴリのタスクへ落とし込む設計。カテゴリは異常イベント帰因、金融数値計算、金融時間推論、金融ツール利用、金融知識QA、金融データ記述、感情価値評価、株価予測、金融NERなど。評価側ではIteraJudgeにより、評価観点の分解、逐次的な修正生成、参照回答に沿った判定を組み合わせて、LLM評価器のプロンプトバイアスを抑える。
- **どうやって有効だと検証した？**: proprietary/open-sourceを含む25モデルをBizFinBenchで評価。本文抽出上、総数はabstractでは6,781件、比較表では7,016件と読め、件数表記に揺れがある。結果として、数値計算ではClaude-3.5-SonnetやDeepSeek-R1が高く、推論ではChatGPT-o3やGemini-2.0-Flashなど商用モデルが優勢、情報抽出ではモデル間の差が大きく、予測認識では全体にスコア幅が小さい、という傾向を報告している。
- **議論はある？**: 中国語・特定金融アプリ由来のデータなので、他言語・他市場・機関投資家業務への外部妥当性は未検証。LLM-as-a-Judgeを改善しているが、評価器自体がモデル依存である限界は残る。PDF抽出では細かい表の数値が崩れている箇所があり、モデル別スコアの厳密な再確認は原PDFや公開データで確認したい。
- **次に読む/試すなら**: 1. GitHubのデータ形式と評価スクリプトを確認する。2. 日本株・日本語IRニュースで同じカテゴリが作れるか小規模に再現する。3. IteraJudgeを通常のLLM-as-a-Judgeや人手評価と比較する。
- **キーワード**: `financial benchmark`, `LLM evaluation`, `BizFinBench`, `IteraJudge`, `LLM-as-a-Judge`, `financial reasoning`

## 気になったこと

- 6,781件と7,016件の表記差が、フィルタ前後・公開版差分・抽出ミスのどれなのか確認したい。
- 「業務駆動」と言うとき、実ユーザークエリの匿名化、権利処理、分布バイアスはどこまで説明されているか。
- IteraJudgeが本当に人間専門家に近づくのか、金融タスク以外でも効くのか。
- 予測認識タスクのスコアが低めで分散も小さい理由は、問題設計の難しさなのか、現在のLLMの限界なのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
