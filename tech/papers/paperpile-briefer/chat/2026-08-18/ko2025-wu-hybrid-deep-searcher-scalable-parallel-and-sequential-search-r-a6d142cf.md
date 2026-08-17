# Chat Prompt 2026-08-18

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Hybrid deep searcher: Scalable parallel and sequential search reasoning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-18 - Hybrid deep searcher: Scalable parallel and sequential search reasoning

## 基本情報

- **タイトル**: Hybrid deep searcher: Scalable parallel and sequential search reasoning
- **著者**: Dayoon Ko, Jihyuk Kim, Haeju Park, Sohyeon Kim, Dahyun Lee, Yongrae Jo, Gunhee Kim, Moontae Lee, Kyungjae Lee
- **年 / venue**: 2026 / ICLR 2026（arXiv:2508.19113v3）
- **リンク**: https://arxiv.org/abs/2508.19113v3

## 落合陽一フォーマット

- **ひとことでいうと**: 検索を「並列に広く集める → 根拠を明示的に統合する → 次の逐次検索へ進む」構造として教師あり学習し、検索回数・ターン数を増やすほど性能が伸びるDeep Researchエージェントを作った。
- **先行研究と比べてどこがすごい？**: 単一クエリ逐次検索は証拠の網羅性が低く、並列検索だけの手法は取得結果を統合しにくいという問題に対し、両者を接続した。RL中心の既存手法に対し、2,111本の教師あり軌跡だけで、5ベンチマークすべてで最高性能を報告する。FanOutQAではF1が既存最良比で+15.9、BrowseCompの選定部分集合では+9.2。
- **技術や手法の肝はどこ？**: HDS-QAは、単跳質問から中心エンティティと関連質問を抽出し、独立した複数の情報を必要とする並列hop質問を作り、それを元質問に組み込んで逐次hopも必要な問題にする。Qwen3-32Bが生成した「思考 → 複数クエリ → 検索結果 → 証拠統合」の軌跡を用い、Qwen3-8Bをfine-tuneする。推論時には複数クエリを同時発行し、検索結果を統合してから次の検索判断を行う。
- **どうやって有効だと検証した？**: MuSiQue、FanOutQA、FRAMES、MedBrowseComp、BrowseComp†でSearch-o1、Search-R1、R1-Searcher、DeepResearcher、RAG-R1と比較した。BrowseComp†では、検索ターン上限を1から8へ増やすとF1が4.0から15.1、検索API呼出し上限を2から16へ増やすと3.4から15.1へ伸長した。証拠被覆率もMuSiQue/FanOutQA/FRAMESで40.7/61.0/55.8と最良を報告している。
- **議論はある？**: 学習データは自動生成された1,987問・2,111成功軌跡で、質問テンプレートが「並列hop＋逐次hop」を核にしているため、実世界のより多様な探索計画への一般化には留保がある。検索にはJina API、要約には主にQwen3-32Bを用いており、検索品質・API依存・要約器の影響を完全には切り分けていない。GRPO追加学習は正答率を少し改善する一方、ターン数も増え、効率指標AUCは改善しない場合がある。
- **次に読む/試すなら**:
  1. HDS-QAの生成パイプラインと公開データを確認し、実運用コーパスで同様の軌跡を作れるか試す。
  2. 並列クエリ数、統合タイミング、検索予算を制御した小規模アブレーションを行う。
  3. 検索結果の統合を要約器任せにせず、根拠の重複除去・引用追跡・矛盾検出を加える。
- **キーワード**: `deep research`, `RAG`, `test-time scaling`, `parallel search`, `multi-hop QA`, `supervised fine-tuning`

## 気になったこと

- HDS-QAで最終回答が正しかった軌跡のみを採用しており、失敗軌跡や検索ノイズへの頑健性はどこまで学べているか。
- BrowseComp†はo3＋Web検索で5分以内に解ける150問の部分集合であり、全BrowseCompへの一般化と評価選定バイアスを確認したい。
- 並列検索の幅を増やした際、証拠統合時のコンテキスト長・重複情報・矛盾情報がどの程度ボトルネックになるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
