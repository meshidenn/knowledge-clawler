# Paperpile Brief 2026-08-14 - Not worth another token: Marginal value estimation for efficient deep research agents

## 基本情報

- **タイトル**: Not worth another token: Marginal value estimation for efficient deep research agents
- **著者**: Harshitha Kolukuluru, Reshma Ashok, Kirat Arora, Evan William Ciccarelli, Nischal Ashok Kumar, Lunyiu Nie, Franck Dernoncourt, Samyadeep Basu, Ryan A. Rossi, Nedim Lipka
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.08389](https://arxiv.org/abs/2608.08389) / [PDF](https://arxiv.org/pdf/2608.08389.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: Deep Research Agentが集める証拠の「次の1トークンに払う価値」を推定し、探索・取得・最終合成のどこで枝刈りすべきかを実測した論文。
- **先行研究と比べてどこがすごい？**: 文脈圧縮を最終プロンプト直前だけでなく、Pre-Retrieval・Post-Retrieval・Pre-Synthesisの3地点に分けて比較した。スコア関数そのもの以上に「いつ刈るか」が重要で、Post-RetrievalのMMRはベースライン比でトークンを約69.5%削減しつつ品質をほぼ維持した。
- **技術や手法の肝はどこ？**: 各候補の周辺価値を、クエリとの関連性・既存文脈との冗長性・多様性・被覆性・トークンコストから採点する。MMR、幾何学的新規性（GRN）、Centroid Drift、DPP、部分モジュラ被覆、LLM judge、学習済みquery controllerを、段階ごとに適用する。
- **どうやって有効だと検証した？**: GPT-Researcherを基盤に、DeepResearchGymの100クエリで比較。品質、KPR+KPC、Citation Recall、ノード数、総トークン、実行時間を測定した。3段MMRは375.4kから100.1kトークンへ削減（約73.3%減）。一方、品質・根拠性・効率の最適解は一致しなかった。
- **議論はある？**: 評価は固定パイプライン・100件サンプル・LLM judgeに依存し、品質順位はベンチマークやjudgeで変わりうる。攻めた枝刈りは反証、少数意見、重要な留保を消す危険があり、Citation Recallや人間の監査を併用すべき。
- **次に読む/試すなら**:
  - 自分のAgentでPost-Retrieval MMRを導入し、トークン・レイテンシ・引用被覆の3指標を計測する。
  - 品質重視なら、早期のCentroid Driftと最終段のSubmodular Coverageの二段構成を比較する。
  - 削減率だけで採用せず、枝刈りで失われた反証ソースを監査する評価セットを作る。
- **キーワード**: `deep research agents`, `context pruning`, `marginal value estimation`, `MMR`, `agent efficiency`, `retrieval-augmented generation`

## 気になったこと

- MMRの閾値・λや最終コンテキスト予算を、タスク難度や失敗コストに応じてどう自動調整するか。
- KPR+KPCがベースラインを超えない一方でLLM judge上の品質が上がるケースは、簡潔で読みやすいが根拠を落とした報告を高く評価していないか。
- 実運用で重要な「少数説・反証・最新情報」の保持を、関連性・冗長性以外の基準で保証できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [kolukuluru2026-zv-not-worth-another-token-marginal-value-estimation-for-4b8ad2d6.md](../../chat/2026-08-14/kolukuluru2026-zv-not-worth-another-token-marginal-value-estimation-for-4b8ad2d6.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
