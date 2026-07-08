# Paperpile Brief 2026-07-09 - AutoMem: Automated learning of memory as a cognitive skill

## 基本情報

- **タイトル**: AutoMem: Automated learning of memory as a cognitive skill
- **著者**: Shengguang Wu, Hao Zhu, Yuhui Zhang, Xiaohan Wang, Serena Yeung-Levy
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: arXiv:2607.01224 / https://arxiv.org/pdf/2607.01224 / https://autolearnmem.github.io/

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントの外部メモリ操作を、固定アーキテクチャではなく「訓練可能な認知スキル」として扱い、足場設計とモデルのメモリ運用能力を自動改善するAutoMemを提案した論文。
- **先行研究と比べてどこがすごい？**: RAG、vector store、scratchpad、summary bufferのような固定的メモリ機構ではなく、`read`、`write`、`search`、`append`、`create`などのファイルシステム操作をタスク行動と同列のfirst-class actionにした点が核。さらに、長大なtrajectoryをmeta-LLMがレビューして、メモリscaffoldの改良と、良いメモリ操作だけを教師データ化するLoRA訓練を自動化している。Qwen2.5-32B-Instructで、メモリ最適化だけによりCrafter、MiniHack、NetHackでおおむね2〜4倍の性能改善を報告している。
- **技術や手法の肝はどこ？**: AutoMemは2段階のouter loopを持つ。第1ループではmeta-LLMが完全なepisode trace、生成されたmemory directory、agent codeを読み、prompt、file schema、validation logic、action vocabularyを更新する。第2ループでは、最終scaffold上で集めた多くのepisodeから、meta-LLMが「強化すべき良いメモリ操作」を選別し、memory specialistをLoRAで訓練する。タスク行動を担当するtask modelは凍結し、memory operation側だけを訓練する分離設計が特徴。
- **どうやって有効だと検証した？**: 長期タスクとして、Crafter、MiniHack、NetHackの3環境で評価している。各環境はprocedural generationによりepisodeごとに状態が変わり、事前知識だけでは解きにくい。固定seedでscaffold revisionを比較し、改善した revision のみ採用するgateを置いている。最終的に、Qwen2.5-32B-Instructベースのagentが、Qwen2.5-72B-Instructを上回り、Claude Opus 4.5やGemini 3.1 Pro Thinkingに近い水準に達したと報告している。ただしPDF抽出テキスト由来のため、細かな表の数値は断定しすぎない。
- **議論はある？**: 現在のメモリはepisodeごとに初期化されるepisodic memoryであり、episodeをまたぐpersistent memoryは未検証。評価対象もゲーム環境に限られ、実世界の長期作業や高リスク領域への一般化は今後の課題。さらに、3環境ごとに別々のscaffoldとmemory specialistを最適化しており、単一の汎用メモリスキルとして共有できるかは未解決。
- **次に読む/試すなら**: AutoMemのGitHub実装で、file-system memory actionのinterfaceとprompt schemaを確認する。小さな長期タスクで、task model固定・memory specialistのみ訓練する最小再現を試す。MemGPT、Memory as Action、MemLLM、Reflexion、Voyagerとの設計差分を整理する。
- **キーワード**: `LLM agent`, `metamemory`, `external memory`, `file-system memory`, `scaffold optimization`, `LoRA`, `long-horizon tasks`, `NetHack`

## 気になったこと

- meta-LLMによるtrajectory reviewのコストがどの程度で、性能改善に対して実用的な比率なのか。
- 「良いメモリ操作」の選別基準が環境依存になりすぎないか。
- task action modelを凍結してmemory specialistだけを訓練する設計は、実世界タスクでも分離可能なのか。
- persistent memoryに拡張した場合、古い記憶の忘却、矛盾、汚染をどう扱うのか。
- ゲーム以外では、どのタスクがAutoMemの最小ベンチマークとして適切か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [wu2026-vm-automem-automated-learning-of-memory-as-a-cognitive-skill-6f826678.md](../../chat/2026-07-09/wu2026-vm-automem-automated-learning-of-memory-as-a-cognitive-skill-6f826678.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
