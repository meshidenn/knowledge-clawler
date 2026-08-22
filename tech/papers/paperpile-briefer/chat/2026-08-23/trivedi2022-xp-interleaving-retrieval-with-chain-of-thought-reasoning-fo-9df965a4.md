# Chat Prompt 2026-08-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Interleaving retrieval with chain-of-thought reasoning for knowledge-intensive multi-step questions

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-23 - Interleaving retrieval with chain-of-thought reasoning for knowledge-intensive multi-step questions

## 基本情報

- **タイトル**: Interleaving retrieval with chain-of-thought reasoning for knowledge-intensive multi-step questions
- **著者**: Harsh Trivedi, Niranjan Balasubramanian, Tushar Khot, Ashish Sabharwal
- **年 / venue**: 2022（メタデータ） / ACL 2023 Long Papers（PDF記載）
- **リンク**: https://aclanthology.org/2023.acl-long.557.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: 多段階QAでは「推論してから次を検索する」べきだとして、CoT生成と文書検索を交互に行うIRCoTを提案した論文。
- **先行研究と比べてどこがすごい？**: 質問だけで一度検索するretrieve-and-readを、推論途中の文を次の検索クエリに使う反復方式へ拡張した。追加学習なしのfew-shot設定で、検索再現率を最大21ポイント、QAのF1を最大15ポイント改善し、GPT-3だけでなくFlan-T5でも有効性を示した。
- **技術や手法の肝はどこ？**: まず質問で文書を検索し、蓄積済み文書・質問・途中CoTから次の推論文を1文だけ生成する。その文をクエリに追加検索し、回答表現が出るか最大ステップ数に達するまで繰り返す。最後に集めた文書群をreaderへ渡して回答する。
- **どうやって有効だと検証した？**: HotpotQA、2WikiMultihopQA、MuSiQue、IIRCの4つの多段階QAデータセットをopen-domain設定で評価した。質問一発検索、検索なし、IRCoTを比較し、IIDだけでなくデータセットをまたぐOODプロンプト設定、GPT-3とFlan-T5系列、CoT/Direct readerの違いも検証した。生成CoTの事実誤りも最大50%削減したと報告している。
- **議論はある？**: 推論の初手が誤ると以後の検索クエリもずれる誤差伝播が残る。最大4ステップ・取得文書数などの設計は固定的で、長い推論への一般化は未検証である。比較手法とはLLM、検索コーパス、評価サンプルが異なるため、外部手法とのSOTA比較は直接比較ではない。少数の手書きCoTデモと外部検索コーパスへの依存もある。
- **次に読む/試すなら**:
  1. IRCoTの公開コードで、社内Wikiや論文コーパスに対する2-hop QAを最小再現する。
  2. CoT文そのものではなく、エンティティ・関係・不確実性を抽出した構造化クエリで検索する方式と比較する。
  3. ReAct、Self-Ask、DecomP、multi-hop dense retrievalとの公平な同一コーパス比較を設計する。
- **キーワード**: `IRCoT`, `multi-hop QA`, `chain-of-thought`, `retrieval-augmented generation`, `open-domain QA`, `hallucination`

## 気になったこと

- CoTを検索クエリに使うため、もっともらしい誤推論が検索空間を狭める問題を、信頼度推定や複数仮説の並列検索でどこまで緩和できるか。
- 検索器はベースラインとして何を使うかで結果が大きく変わる。dense retrievalやweb検索、現代のembeddingモデルでも改善幅が維持されるか確認したい。
- 手書きCoTデモの量・質への感度、推論ステップ数を動的に止める基準、検索・生成回数に伴うコストを確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
