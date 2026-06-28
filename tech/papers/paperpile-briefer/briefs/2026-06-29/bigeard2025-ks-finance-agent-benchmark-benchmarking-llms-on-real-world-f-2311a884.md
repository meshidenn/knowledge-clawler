# Paperpile Brief 2026-06-29 - Finance Agent Benchmark: Benchmarking LLMs on real-world financial research tasks

## 基本情報

- **タイトル**: Finance Agent Benchmark: Benchmarking LLMs on real-world financial research tasks
- **著者**: Antoine Bigeard, Langston Nashold, Rayan Krishnan, Shirley Wu
- **年 / venue**: 2025 / arXiv [cs.CE]
- **リンク**: https://arxiv.org/abs/2508.00828v1

## 落合陽一フォーマット

- **ひとことでいうと**: 実際の金融リサーチ業務に近いSEC filingsベースの質問537件で、LLMエージェントの金融分析能力を測るベンチマークを作った論文。
- **先行研究と比べてどこがすごい？**: 単なるQAではなく、銀行・ヘッジファンド・PEなどの実務経験者と作った9カテゴリのタスク分類、専門家作成の回答、ステップ別ルーブリック、Google SearchやEDGAR検索を使うエージェント評価まで含めている点。最新モデルでも最高46.8%程度の精度に留まり、金融ドメインでの実運用ギャップを強く示している。
- **技術や手法の肝はどこ？**: 537問を「定量取得」「定性取得」「数値推論」「Beat/Miss」「財務モデリング」「市場分析」など9種類に分け、専門家の正解と推論手順をもとにルーブリック評価する。評価環境はReAct系のエージェントハーネスで、Google Search、EDGAR Search、HTML解析、保存済み文書の検索取得を使える。
- **どうやって有効だと検証した？**: o3、Claude 3.7 Sonnet、o4 Mini、Gemini、Grok、GPT-4.1系、Llama系など複数モデルを同一ハーネスで評価。クラスバランス精度、素朴精度、1問あたり時間、1問あたりコストを比較した。最高性能はOpenAI o3の46.8% class-balanced accuracyで、平均コストは約$3.79、平均時間は約3.1分。
- **議論はある？**: ルーブリック評価はLLM-as-judgeに依存しており、完全な人手評価ではない。データセットは短めの文章根拠や最終出力中心で、スプレッドシートや大規模表データの複雑な操作は限定的。引用・ソースの正確性も評価対象外。さらに、商用RAGや高度な独自検索基盤を備えた実運用エージェントとは環境が異なる。
- **次に読む/試すなら**: 公開リポジトリ `vals-ai/finance-agent` を見て、公開validation setで手元モデルを評価する。EDGAR検索とHTML取得の失敗ケースを調べ、精度低下が検索・抽出・推論のどこで起きるか分解する。金融表データ・CSV・スプレッドシート処理を追加した拡張ベンチを考える。
- **キーワード**: `finance agent`, `LLM benchmark`, `SEC filings`, `EDGAR`, `LLM-as-judge`, `financial research`

## 気になったこと

- 最高モデルでも50%未満という結果は強いが、誤答の主因が検索失敗、文書読解、数値計算、ルーブリック判定のどれなのかをさらに分解したい。
- 人間専門家より速く安い一方で、金融意思決定に使うには「不確実なときに止まる能力」や引用検証が必要そう。
- 公開validation setと非公開test setの相関は高いとされるが、今後モデルが公開データに適応したときの汚染対策が重要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [bigeard2025-ks-finance-agent-benchmark-benchmarking-llms-on-real-world-f-2311a884.md](../../chat/2026-06-29/bigeard2025-ks-finance-agent-benchmark-benchmarking-llms-on-real-world-f-2311a884.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
