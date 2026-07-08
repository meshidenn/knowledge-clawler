# Paperpile Brief 2026-07-09 - Forget, then recall: Learnable compression and selective unfolding via gist sparse attention

## 基本情報

- **タイトル**: Forget, then recall: Learnable compression and selective unfolding via gist sparse attention（PDF本文上の題名: Simplified Sparse Attention via Gist Tokens）
- **著者**: Yuzhen Mao, Michael Y. Li, Emily B. Fox
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2604.20920

## 落合陽一フォーマット

- **ひとことでいうと**: 長文コンテキストを gist token で一度圧縮し、質問時に関連する chunk だけを選んで raw token として「展開」する sparse attention 手法 SSA / H-SSA を提案した論文。
- **先行研究と比べてどこがすごい？**: H2O、StreamingLLM、Quest などの推論時 KV-cache 選択とは違い、gist token を continued pretraining で学習し、chunk の要約と routing signal の両方に使う。NSA や MoBA 系の learnable sparse attention に近い効果を、追加アーキテクチャなしで実現する点が強い。LongBench と RAG で圧縮率 8x〜32x の範囲において、圧縮ベースラインや推論時 sparse attention より概ね高性能と報告している。
- **技術や手法の肝はどこ？**: 入力を chunk に分け、各 chunk の後ろに gist token を挿入する。学習時は attention mask で過去 raw token への直接アクセスを制限し、モデルに chunk 情報を gist token へ詰め込ませる。推論時は現在 query と gist key の内積で chunk relevance を計算し、top-k chunk だけを選択して、その gist token と対応 raw token を attention context に戻す。さらに gist-of-gist による H-SSA で coarse-to-fine selection を行い、長い文脈に対する階層的アクセスを狙う。
- **どうやって有効だと検証した？**: Qwen2-7B-Instruct を使った LongBench、Llama3.2-1B を使った RAG benchmark で評価している。比較対象は Full attention、Full-PT / Full-FT、ActBeacon、UniGist、KVLink、H2O、StreamingLLM、Quest など。LongBench では SSA が圧縮率 8x/16x/32x で多くの圧縮ベースラインを上回る。RAG では finetuning 後の SSA が高い平均性能を示し、KV-cache reuse 設定でも KVLink / UniGist を上回る。効率面では H100 上で、長文 decode 時に Flash-Decoding に対して最大 3.37x の end-to-end decoding speedup を報告している。
- **議論はある？**: PDF本文からは、continued pretraining だけでは RAG の query relevance を十分学べず、finetuning が重要になることが示唆される。top-k 選択や chunk size、圧縮率、GQA 構造への依存もあり、設定依存性は残る。gist token が本当に何を保持しているかの解釈性、未知ドメイン・極端に長い文脈・複雑な推論タスクでの頑健性は追加確認が必要。実装面では専用 kernel や KV-cache 管理が性能に効くため、論文通りの速度改善を再現するには環境依存が大きい。
- **次に読む/試すなら**: 1. GitHub 実装で gist token の attention mask と selective unfolding の実装を確認する。2. 自分の RAG workload で chunk size / top-k / compression ratio を振って最小再現実験をする。3. UniGist、KVLink、MoBA、NSA との設計差分を比較する。
- **キーワード**: `sparse attention`, `gist token`, `context compression`, `selective unfolding`, `long-context LLM`, `KV-cache`, `RAG`, `hierarchical attention`

## 気になったこと

- メタデータ上のタイトルと PDF 本文上のタイトルが異なるため、arXiv v2 で題名が変更された可能性がある。
- gist token の学習に必要な continued pretraining コストが、実運用でどの程度許容されるか確認したい。
- selective unfolding の top-k が誤るケース、特に複数 chunk にまたがる証拠が必要な推論での失敗例を見たい。
- 既存モデルへ後付けする場合、どの程度の token budget / 学習量で効果が出るのかが実装上の焦点になりそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [mao2026-ph-forget-then-recall-learnable-compression-and-selective-unfold-cddda4a1.md](../../chat/2026-07-09/mao2026-ph-forget-then-recall-learnable-compression-and-selective-unfold-cddda4a1.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
