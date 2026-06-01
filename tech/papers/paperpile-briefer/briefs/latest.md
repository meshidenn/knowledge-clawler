# Paperpile Daily Brief 2026-06-01

## 今日読むべき順

1. **Toward autonomous long-horizon engineering for {ML} research** - 長時間の研究エージェントを「会話」ではなく「永続状態のシステム」として捉えているので、実装設計に直結する。
2. **{ClawMark}: A living-world benchmark for multi-turn, multi-day, multimodal coworker agents** - マルチターン・複数日・環境変化ありの評価で、現行エージェントの弱点が見える。
3. **Don't retrieve, navigate: Distilling enterprise knowledge into navigable agent skills for {QA} and {RAG}** - RAGを検索ではなく「コーパス内ナビゲーション」に置き換える発想が実務向き。
4. **{Q}-{RAG}: Long context multi-step retrieval via value-based Embedder training** - 10M token級長文コンテキストでの多段検索を埋め込み器のRLで解く。
5. **{DFlash}: Block diffusion for flash speculative decoding** - 推論高速化で6倍超のロスレス加速を主張しており、デコード系の重要候補。
6. **Why fine-tuning encourages hallucinations and how to fix it** - SFTが既存知識を壊すメカニズムと対策を扱っており、実運用のFT設計に効く。
7. **Symbolic guardrails for domain-specific agents** - ニューラル安全策ではなく記号的制約で保証可能な範囲を切り分けている。
8. **{LangFlow}: Continuous diffusion rivals discrete in language modeling** - 連続拡散LMが離散拡散に並ぶという主張で、生成パラダイムの分岐点。
9. **{AutoResearchBench}: Benchmarking {AI} agents on complex scientific literature discovery** - 科学文献探索そのものをエージェント評価にする点が、自動研究支援に直結。
10. **{WildClawBench}: A benchmark for real-world, long-horizon agent evaluation** - CLI実行環境での長期タスク評価なので、実装エージェントの足腰を測れる。

## 論文別メモ

### 1. Toward autonomous long-horizon engineering for {ML} research

- **ひとことでいうと**: AiScientistという、長時間のML研究エンジニアリングを自律実行するエージェントシステム。
- **先行研究と比べてどこがすごい？**: 会話履歴依存ではなく、File-as-Busによる永続成果物と階層オーケストレーションで性能を上げる。
- **技術や手法の肝はどこ？**: Orchestratorが段階管理し、専門エージェントが分析・計画・コード・実験証拠をファイルで再接地する。
- **どうやって有効だと検証した？**: PaperBenchとMLE-Bench Liteで評価し、File-as-Bus除去のアブレーションも実施。
- **議論はある？**: 実験環境外の汎化、失敗時の保証、長期コストはメタデータからは不明。
- **次に読む/試すなら**: File-as-Bus設計を読む。自分の研究ワークフローに成果物マップを導入する。PaperBench設定を確認する。
- **キーワード**: `long-horizon agent`, `File-as-Bus`, `ML research engineering`
- **リンク**: メタデータからは不明

### 2. {ClawMark}: A living-world benchmark for multi-turn, multi-day, multimodal coworker agents

- **ひとことでいうと**: 複数日にまたがり環境状態が変わる同僚型エージェントのベンチマーク。
- **先行研究と比べてどこがすごい？**: 静的・単発・テキスト中心の評価ではなく、メール、カレンダー、KB、スプレッドシート等の状態変化を入れる。
- **技術や手法の肝はどこ？**: 100タスク、13業務シナリオ、5つの状態付きサービス、1537個の決定的Python checker。
- **どうやって有効だと検証した？**: 7つのfrontier agent systemを評価し、最高でも厳密Task Successは20.0%。
- **議論はある？**: タスク数100の代表性、サービス環境の現実との差分はメタデータからは不明。
- **次に読む/試すなら**: checker設計を見る。自分のエージェント評価に外生的状態更新を入れる。
- **キーワード**: `agent benchmark`, `multi-day`, `stateful environment`
- **リンク**: メタデータからは不明

### 3. Don't retrieve, navigate: Distilling enterprise knowledge into navigable agent skills for {QA} and {RAG}

- **ひとことでいうと**: 企業文書コーパスを階層的な「ナビゲート可能スキル」に変換するRAG手法。
- **先行研究と比べてどこがすごい？**: Dense retrievalやRAPTORのように受動的に検索結果を食べるのではなく、LLMが階層を見て探索・後戻りできる。
- **技術や手法の肝はどこ？**: Corpus2Skillが文書クラスタリング、階層要約、スキルファイル化をオフラインで行う。
- **どうやって有効だと検証した？**: WixQAでdense retrieval、RAPTOR、agentic RAG baselineを全品質指標で上回ったとされる。
- **議論はある？**: 階層生成の更新コスト、誤要約が探索に与える影響はメタデータからは不明。
- **次に読む/試すなら**: 自分のObsidian/wikiコーパスを階層skill化できるか試す。
- **キーワード**: `RAG`, `Corpus2Skill`, `enterprise QA`
- **リンク**: メタデータからは不明

### 4. {Q}-{RAG}: Long context multi-step retrieval via value-based Embedder training

- **ひとことでいうと**: 多段RAGを小型LLMではなく埋め込みモデルのRLで学習する手法。
- **先行研究と比べてどこがすごい？**: multi-step retrieval用LLM fine-tuningより軽量で、大きなLLMをそのまま使いやすい。
- **技術や手法の肝はどこ？**: Embedderをvalue-basedに訓練し、次に取るべき検索ステップの価値を学ばせる。
- **どうやって有効だと検証した？**: BabiLongとRULERで最大10M token文脈までSOTAと主張。
- **議論はある？**: RL報酬設計、検索失敗時の挙動、汎用検索エンジンでの再現性はメタデータからは不明。
- **次に読む/試すなら**: GitHub実装を確認し、長文QAのretrieverだけ置換して試す。
- **キーワード**: `multi-step retrieval`, `RAG`, `embedder RL`
- **リンク**: [GitHub](https://github.com/griver/Q-RAG)

### 5. {DFlash}: Block diffusion for flash speculative decoding

- **ひとことでいうと**: ブロック拡散モデルをdraft modelに使うspeculative decoding高速化。
- **先行研究と比べてどこがすごい？**: 自己回帰draftの逐次性を避け、1 forwardで複数draft tokenを生成する。
- **技術や手法の肝はどこ？**: target modelから抽出した文脈特徴で軽量block diffusion modelを条件付ける。
- **どうやって有効だと検証した？**: 複数モデル・タスクで6倍超のlossless acceleration、EAGLE-3より最大2.5倍高速と主張。
- **議論はある？**: draft modelの学習コスト、長文・コード生成での安定性はメタデータからは不明。
- **次に読む/試すなら**: EAGLE-3比較条件を確認する。serving環境でacceptance rateを測る。
- **キーワード**: `speculative decoding`, `diffusion LLM`, `inference acceleration`
- **リンク**: メタデータからは不明

### 6. Why fine-tuning encourages hallucinations and how to fix it

- **ひとことでいうと**: SFTが事前学習知識を劣化させ幻覚を増やす原因と緩和策を調べた論文。
- **先行研究と比べてどこがすごい？**: hallucinationを単なる出力問題ではなく、continual learning由来の知識干渉として扱う。
- **技術や手法の肝はどこ？**: self-distillationで出力分布のdriftを正則化し、必要に応じて一部パラメータを凍結する。
- **どうやって有効だと検証した？**: 新知識学習と既存知識保持の両面で実験し、干渉仮説を検討。
- **議論はある？**: どのモデルサイズ・データ領域で有効かの詳細はメタデータからは不明。
- **次に読む/試すなら**: SFT時にpretrained knowledge probeを評価セットへ入れる。self-distillation正則化を試す。
- **キーワード**: `SFT`, `hallucination`, `continual learning`
- **リンク**: メタデータからは不明

### 7. Symbolic guardrails for domain-specific agents: Stronger safety and security guarantees without sacrificing utility

- **ひとことでいうと**: ドメイン特化エージェントに記号的ガードレールを入れ、安全性を保証する研究。
- **先行研究と比べてどこがすごい？**: neural guardrailでは保証しにくいポリシー要件を、実行時制約として明示的に扱う。
- **技術や手法の肝はどこ？**: 80ベンチマークを調査し、保証可能なpolicy requirementを分類してsymbolic guardrailで実装。
- **どうやって有効だと検証した？**: τ²-Bench、CAR-bench、MedAgentBenchで安全性・セキュリティ・成功率を評価。
- **議論はある？**: 抽象的ポリシーを具体制約へ落とす人手コストは残る。
- **次に読む/試すなら**: 自分のエージェントのツール権限をpolicy requirementに分解する。
- **キーワード**: `agent safety`, `symbolic guardrails`, `policy enforcement`
- **リンク**: [GitHub](https://github.com/hyn0027/agent-symbolic-guardrails)

### 8. {LangFlow}: Continuous diffusion rivals discrete in language modeling

- **ひとことでいうと**: 連続拡散言語モデルをFlow Matchingとして再設計し、離散拡散に匹敵させる研究。
- **先行研究と比べてどこがすごい？**: embedding-space DLMの弱さを、評価境界・ノイズスケジュール・self-conditioningで詰めている。
- **技術や手法の肝はどこ？**: Bregman divergenceでFlow Matchingと接続し、ODE-based NLL boundとlearnable Gumbel noise schedulerを導入。
- **どうやって有効だと検証した？**: LM1B、OpenWebTextでPPL/Gen.PPLを評価し、zero-shot transferでも一部AR baseline超え。
- **議論はある？**: 大規模事前学習や実運用レイテンシでの比較はメタデータからは不明。
- **次に読む/試すなら**: diffusion decodingの速度と品質のトレードオフを見る。
- **キーワード**: `continuous diffusion`, `language modeling`, `Flow Matching`
- **リンク**: [GitHub](https://github.com/nealchen2003/LangFlow)

### 9. {AutoResearchBench}: Benchmarking {AI} agents on complex scientific literature discovery

- **ひとことでいうと**: AIエージェントの科学文献探索能力を測るベンチマーク。
- **先行研究と比べてどこがすごい？**: 一般Webブラウジングではなく、科学概念の理解と文献情報の細粒度利用を要求する。
- **技術や手法の肝はどこ？**: target paperを段階的に探すDeep Researchと、条件を満たす論文集合を集めるWide Researchの2系統。
- **どうやって有効だと検証した？**: 詳細な評価結果はメタデータからは不明。
- **議論はある？**: 正解集合の網羅性、検索API依存、時点依存性が課題になりそう。
- **次に読む/試すなら**: 自分のliterature agentにDeep/Wideの2タスクを分けて評価する。
- **キーワード**: `scientific literature discovery`, `AI agents`, `benchmark`
- **リンク**: メタデータからは不明

### 10. {WildClawBench}: A benchmark for real-world, long-horizon agent evaluation

- **ひとことでいうと**: CLI harness上で現実的な長期タスクを評価するエージェントベンチマーク。
- **先行研究と比べてどこがすごい？**: 合成サンドボックスや短期タスクではなく、実際のランタイムに近い環境を狙う。
- **技術や手法の肝はどこ？**: native-runtime benchmarkとして長い作業、ツール実行、最終回答だけでない検証を扱う。
- **どうやって有効だと検証した？**: 具体的な評価結果はメタデータからは不明。
- **議論はある？**: 環境再現性、セキュリティ、実行時間コストが論点。
- **次に読む/試すなら**: SWE系だけでなく自分のCLI作業ログを評価タスク化する。
- **キーワード**: `long-horizon agent`, `CLI`, `benchmark`
- **リンク**: メタデータからは不明

## 横断メモ

- 今日の中心は、RAG単体よりも「検索・記憶・スキル・オーケストレーション」を組み合わせた長期エージェント設計。
- 評価の潮流は、単発QAから、状態変化・複数日・マルチモーダル・実ランタイムへ移っている。
- 推論高速化では、speculative decodingとdiffusion/parallel draftが強い流れ。
- Fine-tuning/RL系では、冷スタート、知識干渉、token/trajectory credit assignmentが共通課題。
- 違和感として、2026年論文が多く、DOI/arXiv IDが空のものも多いため、正式版確認なしに強く断定しない方がよい。

## そのまま聞ける質問

- この論文群で最初に読むべき1本は？
- 実装に落とすならどこから試すべき？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- このままチャットで聞くためのプロンプト: [chat/2026-06-01.md](../chat/2026-06-01.md)
- ローカルで続けて聞く例: `codex exec "chat/2026-06-01.md を読んで、気になる点を深掘りして"`
