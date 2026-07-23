# Paperpile Brief 2026-07-24 - AutoIndex: Learning Representation Programs for Retrieval

## 基本情報

- **タイトル**: AutoIndex: Learning Representation Programs for Retrieval
- **著者**: Sam O'Nuallain, Nithya Rajkumar, Ramya Narayanasamy, Hanna Jiang, Shreyas Chaudhari, Andrew Drozdov
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: https://arxiv.org/abs/2607.18603 / PDF: https://arxiv.org/pdf/2607.18603.pdf / Code: https://github.com/auto-index/autoindex

## 落合陽一フォーマット

- **ひとことでいうと**: 検索器そのものではなく、検索器に渡す文書表現、つまりchunk・正規化・強調・再編成を「実行可能な前処理プログラム」として学習するAutoIndexを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のRAG/IR最適化がretriever、reranker、prompt、固定chunk設定を調整しがちな中で、AutoIndexはBM25を固定したまま、index前の文書変換コードを最適化対象にしている。CRUMB 8タスクすべてでfull-document BM25よりRecall@100を改善し、平均でRecall@100 +8.4%、nDCG@10 +8.3%、最大でRecall@100 +30.5%、nDCG@10 +43.6%を報告。
- **技術や手法の肝はどこ？**: Analysis Agentが現在のindexでの検索失敗を、`bm25_retrieve`・`read_file`・`grep_search`のようなread-only toolで診断し、Code Agentがその診断とsearch historyをもとにPythonの前処理プログラム候補を生成する。各候補は実際にcorpusへ適用され、indexを作り直し、validation Recall@100で採否を決める。検索スコアはchunk単位からsource document単位へMaxPで集約する。
- **どうやって有効だと検証した？**: CRUMBの8つの複雑検索タスクで、BM25とindex backendを固定して評価。baselineはfull-document BM25と、利用可能なsplitではCRUMBの512 BERT-token passage corpus。qwen3-coder版では5 iteration、各iterationで4候補、3 seedを使い、held-out queryで評価した。ablationでは1 iteration、search historyなし、Analysis Agentなしも比較し、full pipelineが8/8 splitでRecall@100を改善した。
- **議論はある？**: 主評価は固定BM25かつRecall@100中心なので、dense/hybrid/reranker環境で同じだけ効くかは未検証に近い。StackExchangeでQwen3-Embedding-0.6Bに転用した単発実験はあるが、広範な検証ではない。候補ごとにindex再構築が必要で計算コストも重い。validationに適応したプログラムがheld-outや別corpusへどこまで汎化するかも今後の課題。
- **次に読む/試すなら**: 自分のRAG corpusで、retrieverを変えずに「title追加」「section reweighting」「LaTeX/boilerplate除去」を小さくablationする。CRUMBとAutoIndex codeを見て、前処理プログラム候補のinterfaceを再現する。BM25だけでなくdense retrieverに同じrepresentation programを流用して効果を見る。
- **キーワード**: `information retrieval`, `RAG`, `BM25`, `document representation`, `program synthesis`, `index optimization`, `chunking`, `CRUMB`

## 気になったこと

- validation queryに基づくprogram searchが、どの程度corpus固有の過適合になるのか。
- index再構築コストを抑えるために、sampled corpusで粗評価してからfull validationする設計がどこまで効くか。
- learned representation programを別datasetへtransferした場合の劣化幅。
- 「追加chunkはMaxPなので基本有利」という前提は、BM25のcollection statistics変化や候補pool競合でどの程度崩れるか。
- DOIはメタデータからは不明。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [onuallain2026-zn-autoindex-learning-representation-programs-for-retrieva-f84cf9eb.md](../../chat/2026-07-24/onuallain2026-zn-autoindex-learning-representation-programs-for-retrieva-f84cf9eb.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
