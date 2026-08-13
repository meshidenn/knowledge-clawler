# Paperpile Brief 2026-08-14 - ScientistOne: Towards Human-Level Autonomous Research via Chain-of-Evidence

## 基本情報

- **タイトル**: ScientistOne: Towards Human-Level Autonomous Research via Chain-of-Evidence
- **著者**: Rui Meng, Bhavana Dalvi Mishra, Jiefeng Chen, Chun-Liang Li, Palash Goyal, Mihir Parmar, Yiwen Song, Yale Song, Rajarishi Sinha, Parthasarathy Ranganathan, Burak Gokturk, Jinsung Yoon, Tomas Pfister
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2605.26340](https://arxiv.org/abs/2605.26340)

## 落合陽一フォーマット

- **ひとことでいうと**: 自律研究エージェントが出す「もっともらしいが検証不能な論文」を防ぐため、主張を根拠へ追跡可能にするChain-of-Evidence（CoE）と、それを設計段階から組み込んだScientistOneを提案した論文。
- **先行研究と比べてどこがすごい？**: 解探索の性能だけでなく、引用・数値・手法記述が根拠、実行ログ、コードへ接続しているかを評価対象にした点が新しい。75本・5システムの監査では全ベースラインに系統的な不整合を見つける一方、ScientistOneは幻覚引用0/337、スコア検証12/12、手法–コード整合14/15を報告し、5つのADRS課題でも人間専門家以上の性能を主張する。
- **技術や手法の肝はどこ？**: CoEは主張を引用・数値・方法・結論に分け、それぞれに必要な証拠連鎖を定義する。ScientistOneは、(1) 最大100本の全文PDFを辿る文献調査、(2) 並列Explore-Exploitによる解法探索と評価ログ保存、(3) 文中の各主張に根拠アーティファクトを紐づけるPaper WriterとClaim Verifier、の3段でこれを実装する。
- **どうやって有効だと検証した？**: ADRSの5課題で、ScientistOneと4つの既存自律研究システムを各15論文、計75論文で比較した。監査はスコア再現、仕様違反、参考文献の実在、方法記述とコードの整合性の4項目。加えてMLE-Benchの5課題とParameter Golfで汎化を試し、金・銀相当の成績や、当時のParameter GolfでのSOTA相当スコアを報告している。
- **議論はある？**: 監査の強みは構造的整合性であり、科学的な新規性・正しさそのものは保証しない。引用検証も主に「文献が実在するか」で、引用先が主張を本当に支持するかの文単位検証は未解決。評価は決定的な採点器を持つシステム最適化課題に偏り、生物・材料・理論などへの一般化、監査の見逃し率、ベースラインの調整公平性にも限界がある。
- **次に読む/試すなら**:
  - CoEの4種類の主張を、自分の研究パイプラインの成果物・ログ・コードへ対応付ける。
  - 既存のAI生成レポートに4つのIntegrity Auditを適用し、最も多い不整合を測る。
  - 引用の「実在確認」から「主張支持の文単位検証」へ拡張する設計を試す。
- **キーワード**: `autonomous research agent`, `Chain-of-Evidence`, `provenance`, `claim verification`, `research integrity`, `ADRS`

## 気になったこと

- Claim Verifierが、数値・コード・引用をどの粒度で照合し、失敗時に論文本文をどのように修正するのか。
- 4項目の監査で通っても、探索過程のデータリークやベンチマーク過適合をどこまで検出できるのか。
- 文献の実在性ではなく、「その引用が当該主張を支持する」という含意まで自動検証する際の精度・コスト。
- Parameter GolfのSOTAは2026-04-27時点の比較であり、現在のランキングを意味しない点。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [meng2026-oq-scientistone-towards-human-level-autonomous-research-via-cha-bcc6f673.md](../../chat/2026-08-14/meng2026-oq-scientistone-towards-human-level-autonomous-research-via-cha-bcc6f673.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
