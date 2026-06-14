# Chat Prompt 2026-06-15

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {MiniMax}-{M1}: Scaling test-time compute efficiently with lightning attention

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-15 - MiniMax-M1: Scaling Test-Time Compute Efficiently with Lightning Attention

## 基本情報

- **タイトル**: MiniMax-M1: Scaling test-time compute efficiently with lightning attention
- **著者**: MiniMax, Aili Chen, Aonian Li, Bangwei Gong, Binyang Jiang, Bo Fei ほか多数
- **年 / venue**: 2025 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2506.13585 / arXiv:2506.13585

## 落合陽一フォーマット

- **ひとことでいうと**: Lightning Attention と MoE を組み合わせ、長い推論・長文コンテキストを低コストに扱う open-weight 大規模推論モデル MiniMax-M1 を作った論文。
- **先行研究と比べてどこがすごい？**: DeepSeek-R1 や Qwen3-235B のような強い open-weight 推論モデルに対し、1M token 入力、最大 80K token の extended thinking、100K token 生成時に DeepSeek R1 比で約 25% FLOPs という効率を主張している。特に SWE-bench、TAU-bench、長文理解で強い。
- **技術や手法の肝はどこ？**: 456B 総パラメータ、45.9B active/token、32 experts の MoE をベースに、7層の lightning attention 系 transnormer block ごとに1層 softmax attention を入れる hybrid attention 構成を採る。RL では CISPO を提案し、token update ではなく importance sampling weight を clip して、全 token を勾配計算に使いながら安定化する。
- **どうやって有効だと検証した？**: AIME、MATH-500、LiveCodeBench、FullStackBench、GPQA Diamond、SWE-bench Verified、OpenAI-MRCR、LongBench-v2、TAU-bench、SimpleQA、MultiChallenge などで評価。MiniMax-M1-80k は AIME 2024 86.0、LiveCodeBench 65.0、SWE-bench Verified 56.0、TAU-bench airline 62.0、OpenAI-MRCR 128k 73.4 を報告。RL training は 512 H800 GPU で約3週間、レンタル費約 $534,700 とされる。
- **議論はある？**: 数学・競プロ系では最新 DeepSeek-R1-0528 に劣る場面がある。SimpleQA など factuality は強みではない。評価は自社実装や特定 scaffold、GPT judge を含むため、完全な再現性や benchmark 条件の公平性は追加確認が必要。PDF抽出上、細かい数値や表の読み取りは断定しすぎない方がよい。
- **次に読む/試すなら**: MiniMax-M1 の GitHub/Hugging Face 実装と vLLM 対応を確認する。CISPO と DAPO/GRPO の差分を式レベルで読む。長文 agent task で 40K/80K thinking budget のコスト対性能を小さく再現する。
- **キーワード**: `large reasoning model`, `test-time compute`, `lightning attention`, `hybrid attention`, `MoE`, `CISPO`, `long context`, `reinforcement learning`

## 気になったこと

- CISPO の安定性が architecture 固有なのか、通常 Transformer や小規模モデルにも一般化するのか。
- 1M context と 80K generation を実運用したときの latency、memory、serving cost はどの程度か。
- SWE-bench や TAU-bench の強さが RL 環境構築によるものか、長文推論能力によるものかを切り分けたい。
- factuality が相対的に弱い理由は、長い thinking の副作用なのか、事前学習・RL データ配合の問題なのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
