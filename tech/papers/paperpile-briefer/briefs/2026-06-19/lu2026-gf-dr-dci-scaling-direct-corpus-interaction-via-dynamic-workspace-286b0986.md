# Paperpile Brief 2026-06-19 - DR-DCI: Scaling Direct Corpus Interaction via Dynamic Workspace Expansion

## 基本情報

- **タイトル**: DR-DCI: Scaling Direct Corpus Interaction via Dynamic Workspace Expansion
- **著者**: Yi Lu, Zhuofeng Li, Ping Nie, Haoxiang Zhang, Yuyu Zhang, Kai Zou, Wenhu Chen, Jimmy Lin, Dongfu Jiang, Yu Zhang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2606.14885](https://arxiv.org/abs/2606.14885) / [GitHub](https://github.com/EigenTom/DR-DCI)

## 落合陽一フォーマット

- **ひとことでいうと**: 巨大コーパス全体へ直接シェル検索する代わりに、検索器で関連文書を動的ワークスペースへ取り込み、その中だけを `rg` や `grep` で精査するエージェント検索方式。
- **先行研究と比べてどこがすごい？**: RAGのスケーラブルな候補発見と、Direct Corpus Interaction（DCI）の柔軟な文書横断検証を分業させた。BrowseComp-Plusで71.2%、コンテキストリセット込みで73.3%を達成し、Raw DCIなどを最大8.3ポイント上回った。100K〜10M文書でも安定し、20M文書のWiki-18評価でも6ベンチマーク平均63.0を記録した。
- **技術や手法の肝はどこ？**: 検索を最終的な閲覧UIではなく、`pull(query, topK)` による「永続ワークスペース拡張操作」として扱う点。エージェントは未解決の制約に応じて文書を追加取得し、ローカルなCLI操作で検索・比較・集計・根拠確認を行う。検索順位付きプレビューと文書横断DCIが主要な構成要素である。
- **どうやって有効だと検証した？**: BrowseComp-PlusでRaw DCI、単発取得、インターフェースの各種アブレーションと比較。FineWebの妨害文書を加えた100K〜10M文書のスケーリング実験と、20M文書のWiki-18 QAで評価した。精度だけでなく、ツール呼び出し数、処理時間、推定コスト、取得文書数も測定している。
- **議論はある？**: 性能は基盤検索器の再現率に依存し、取得候補に正解文書がなければDCIでも回復できない。主実験は特定のモデルやエージェント設定に依存しており、小型オープンモデルでの再現性は今後の課題。ランキング専用評価ではDCI-Agent-Liteを平均で上回らず、回答探索向け設計が汎用ランキングにも最適とは限らない。細かな数値はPDF抽出崩れの可能性があるため原表確認が必要。
- **次に読む/試すなら**: 1. GitHub実装で `pull` と永続ワークスペースの最小構成を再現する。2. 同じ検索器で通常RAG、Raw DCI、DR-DCIの精度・時間・コストを比較する。3. `topK`、取得タイミング、ワークスペース上限を変えたアブレーションを行う。
- **キーワード**: `agentic search`, `Direct Corpus Interaction`, `dynamic retrieval`, `workspace expansion`, `RAG`, `multi-hop QA`

## 気になったこと

- `pull` のクエリ生成失敗が最終精度へ与える影響と、検索器をBM25・dense・hybridで替えた場合の差。
- ワークスペースが増え続けた際の削除・圧縮・重複排除戦略は十分に検証されているか。
- コンテキストリセットは低信頼かつ明示的棄権の場合に有効だが、汎用的な発火条件として別データセットにも転移するか。
- Raw DCIとの比較で、タイムアウトや計算資源の条件が各方式に対して公平だったかを原表・実装で確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [lu2026-gf-dr-dci-scaling-direct-corpus-interaction-via-dynamic-workspace-286b0986.md](../../chat/2026-06-19/lu2026-gf-dr-dci-scaling-direct-corpus-interaction-via-dynamic-workspace-286b0986.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
