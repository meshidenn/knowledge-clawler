# Chat Prompt 2026-06-28

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Sakana Fugu Technical Report

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-28 - Sakana Fugu Technical Report

## 基本情報

- **タイトル**: Sakana Fugu Technical Report
- **著者**: Yujin Tang, Edoardo Cetin, Jinglue Xu, Qi Sun, Stefan Nielsen, Vincent Richard, Haruto Goda, Iaroslav Tymchenko, Nhan Nguyen, Hyunin Lee, Mari Ashiga, Shashank Kotyan, So Kuroki, Tarin Clanuwat
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2606.21228

## 落合陽一フォーマット

- **ひとことでいうと**: 複数のフロンティアLLMを、タスクごとに選択・分担・検証・統合する「学習済みオーケストレータ」Sakana Fugu / Fugu-Ultraを作った技術報告。
- **先行研究と比べてどこがすごい？**: 従来の固定的なマルチエージェント構成や単一ルータではなく、入力ごとにエージェント構成そのものを動的に作る点が差分。SWE Bench Pro、Terminal Bench 2.1、LiveCodeBench、GPQA Diamond、CharXiv Reasoningなどで、個別の構成員モデルを超える性能を報告している。
- **技術や手法の肝はどこ？**: Fuguは低遅延版で、LLMバックボーンの隠れ状態に軽量な選択ヘッドを付け、各入力に最適なワーカーモデルを選ぶ。SFTで単発タスクのソフトな性能分布を学び、さらにend-to-endタスクをsep-CMA-ESで最適化する。Fugu-Ultraは高品質版で、Conductor系の枠組みにより自然言語で最大5ステップのワークフローを生成し、GRPOで学習する。関数呼び出し時には、同一ワークフロー内のエージェント分離と、会話をまたぐ共有メモリを組み合わせる。
- **どうやって有効だと検証した？**: SWE Bench Pro、Terminal Bench 2.1、LiveCodeBench / Pro、GPQA Diamond、Humanity’s Last Exam、CharXiv Reasoning、SciCode、長文推論などで比較。さらにAutoResearchでのLLM訓練最適化、古典日本語書簡の読み順推定、機械式アイリスのCAD生成といった定性的・実用寄りタスクでも評価している。PDF本文ではFugu-UltraがSWE Bench Pro 73.7、Terminal Bench 2.1 82.1、GPQA Diamond 95.5などを報告しているが、抽出テキスト由来なので細かい数値は要原表確認。
- **議論はある？**: ベースラインの一部はprovider-reportedで、同一条件の再現性には注意が必要。Fugu-Ultraは品質重視のため遅延・コストが増える。ワーカーモデルがAPI提供・非公開モデルに依存するため、モデル更新、価格、利用制限、データガバナンスの影響を受ける。訓練データ、評価ハーネス、報酬設計の詳細は完全再現には不足がありそう。
- **次に読む/試すなら**: 1. Trinity / Conductor / GRPO / sep-CMA-ES周辺の参照論文を読む。2. 自分のタスクで「単一ベストモデル」対「ルータ」対「動的ワークフロー」を小さく比較する。3. エージェント間メモリ分離と共有メモリの設計を、Codex系ワークフローで再現実験する。
- **キーワード**: `LLM orchestration`, `multi-agent systems`, `agentic scaffolds`, `model routing`, `collective intelligence`, `GRPO`, `CMA-ES`

## 気になったこと

- 「オーケストレーションが能力を増幅する」という主張は強いが、コスト正規化・レイテンシ正規化・同一ハーネス比較をしたときにどこまで残るか。
- Fuguが選択するワーカー分布は、タスクドメインだけでなく難易度・失敗履歴・ツール状態にどう反応しているのか。
- Fugu-Ultraの自然言語ワークフロー生成は、プロンプトインジェクションや悪い中間結果の伝播にどれくらい弱いのか。
- 古典日本語読み順推定のような小規模・専門家評価タスクは面白いので、文化資料処理での実装可能性を別途追いたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
