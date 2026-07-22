# Chat Prompt 2026-07-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {RESOURCE2SKILL}: Distilling executable agent skills from human-created multimodal resources

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-23 - RESOURCE2SKILL: Distilling executable agent skills from human-created multimodal resources

## 基本情報

- **タイトル**: RESOURCE2SKILL: Distilling executable agent skills from human-created multimodal resources
- **著者**: Yijia Fan, Zonglin Di, Zimo Wen, Yifan Yang, Mingxi Cheng, Qi Dai, Bei Liu, Kai Qiu, Yue Dong, Ji Li, Chong Luo
- **年 / venue**: 2026 / arXiv [cs.SE]
- **リンク**: https://arxiv.org/abs/2606.29538 / PDF: https://arxiv.org/pdf/2606.29538.pdf / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: チュートリアル動画、リポジトリ、記事、参照成果物など人間が作ったマルチモーダル資源から、ソフトウェアエージェント用の再利用可能な実行可能スキルを抽出し、階層型の Skill Wiki として運用する枠組み。
- **先行研究と比べてどこがすごい？**: 既存の skill library は手書き、text/code 中心、または agent trace 由来が多いのに対し、この研究は動画に含まれる操作順序・視覚変化・暗黙的なデザイン判断まで skill 化する。7つの authoring domain で、no-skill agent に対して平均 +11.9ポイント改善し、主要な model-domain 集計 28セル中26セルで強い harness baseline を上回る。
- **技術や手法の肝はどこ？**: skill を `path, text, visual, code, metadata` のタプルとして定義し、ドメイン別 taxonomy に配置する。構築時は resource-to-skill operator が動画フレーム、コード領域、記事本文、参照画像などを抽出し、vision-capable LM で構造化 skill に蒸留する。その後、完全性、provenance、重複、modality consistency、構造的実行可能性の deterministic gate で受理する。推論時は MetaBrowse が taxonomy path を含む BM25 で候補を絞り、LM が複数 skill を選択・合成して MCP 経由で実行する。
- **どうやって有効だと検証した？**: Web、Excel、Reaper、PPT、Blender、CAD、UE5 の7ドメインで、各ドメイン80 task brief の matched benchmark を構築。GPT-5.5、GPT-5.4、GPT-5.4 Mini、GPT-5.4 Nano の4 backend で、w Skills、w/o Skills、ClaudeCode-H、Codex-H を比較した。成果物はソースではなく rendered artifact を judge に見せ、非音声は GPT-5.4 vision judge、Reaper は audio-capable GPT-4o 系 judge で評価。ablation では source mix、text/visual/code 表現、selection strategy、online acquisition の寄与も検証している。
- **議論はある？**: 評価は artifact judge に強く依存しており、人間評価も一部あるが全タスクではない。構築 operator は vision-capable LM による prompt-based distillation なので、skill 品質が基盤モデルや prompt に依存する。実行可能性 gate は「構造的に動く」ことを確認するもので、個別 benchmark task を解けることは保証しない。商用 authoring domain に寄せた設計なので、科学計算・長期対話・実世界ロボティクスなどへの一般化はメタデータおよび本文からは不明。
- **次に読む/試すなら**: Resource2Skill の公開コードを確認して skill schema と on-disk format を読む。自分の agent workflow に対して、小規模な動画/記事/コード資源から Skill Wiki を作る最小実験を組む。MetaBrowse の hierarchy-then-LM selection を、既存の RAG/skill retrieval と比較する。
- **キーワード**: `software agents`, `agent skills`, `multimodal resources`, `Skill Wiki`, `procedural knowledge`, `MCP`, `resource distillation`, `online skill acquisition`

## 気になったこと

- 動画から抽出された skill の粒度をどう決めると、再利用性と実行可能性のバランスが良いのか。
- deterministic gate だけで skill の「有用性」までどの程度担保できるのか。
- 人間が作った tutorial のライセンス、provenance、再配布可能性を実運用でどう扱うのか。
- 既存の Codex/Claude Code 用 skill 仕様に落とす場合、text/visual/code のどこまでを標準化できるのか。
- online acquisition が有効な一方で、検索結果の汚染や低品質 resource の混入をどう防ぐのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
