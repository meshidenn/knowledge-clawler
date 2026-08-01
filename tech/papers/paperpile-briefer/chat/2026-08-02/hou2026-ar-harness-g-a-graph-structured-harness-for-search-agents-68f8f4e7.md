# Chat Prompt 2026-08-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Harness-{G}: A graph-structured Harness for search agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-02 - Harness-{G}: A graph-structured Harness for search agents

## 基本情報

- **タイトル**: Harness-{G}: A graph-structured Harness for search agents
- **著者**: Yanning Hou, Haoyuan Chen, Sihang Zhou, Xiaoshu Chen, Xirui Liu, Duanyang Yuan, Lingyuan Meng, Quan Liu, Jian Huang
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.27652v1 / arXiv:2607.27652v1

## 落合陽一フォーマット

- **ひとことでいうと**: RLベースの検索エージェントで、自由文クエリ生成をやめ、グラフ上の有限アクション選択に置き換えることで、検索行動の学習を安定化する論文。
- **先行研究と比べてどこがすごい？**: Search-R1やGraph-R1系は、報酬設計やcredit assignmentを改善しても、自由文クエリが同じ証拠集合に収束する「retrieval-equivalence collapse」を抱える。この論文は問題を報酬ではなくpolicy-environment interfaceの構造問題として捉え、検索対象を文・エンティティ・回答のメニュー選択に変えた点が新しい。6つのQA benchmarkで、Graph-R1に対して平均F1を1.5Bで+10.74、3Bで+3.98上回ったと報告している。
- **技術や手法の肝はどこ？**: コーパスをparagraph-sentence-entityのtripartite graphとして構築し、各ステップで`Select(sentence)`、`Lookup(entity)`、`Answer`の有限メニューを環境が提示する。モデルは自然言語クエリを生成せず、環境が検証・重複除去・状態更新・決定的検索を行う。さらにStructured Non-myopic Credit（SNC）で、同一状態の代替アクションをread-only previewし、凍結answer scorerで選択アクションと代替案の差分を評価し、後続の利得を早いbridge actionにも伝播する。
- **どうやって有効だと検証した？**: 2WikiMultiHopQA、HotpotQA、MuSiQue、Natural Questions、PopQA、TriviaQAの6データセットで評価。各データセットは5,120 train、128 held-out questionを使い、EM、F1、retrieval similarity、generation evaluationを報告している。Qwen2.5の1.5B/3Bスケールで比較し、Search-R1、IGPO、R1-Searcher、Graph-R1などと比較。加えて、自由文クエリではquery form diversityが残ってもretrieval outcome diversityが急落する診断、action menuとSNCのablation、別backboneや複数RL optimizerでの安定性も確認している。
- **議論はある？**: 評価のheld-out splitが各128問と小さく、細かな数値差は過信しにくい。グラフ構築はLLM不要だが、NER、正規化、dense encoder、entity filteringの品質に依存する。有限メニュー化は探索空間を整理する一方、メニュー生成で候補から漏れた証拠には到達できない。Web検索のような動的・非構造コーパスにそのまま適用できるかは本文からは不明。
- **次に読む/試すなら**: Graph-R1との差分実装を見る。`Select/Lookup/Answer`のmenu rendererとinvalid target filterを小さなRAG corpusで再現する。SNCなしのaction menuだけでどれだけ効くかを自前QAでablationする。
- **キーワード**: `search agent`, `reinforcement learning`, `Graph RAG`, `finite action space`, `credit assignment`, `retrieval-equivalence collapse`, `SNC`

## 気になったこと

- retrieval-equivalence collapseのクラスタリング閾値や、証拠集合overlapの定義が実装上どれくらい結果に効くか。
- menu生成のcandidate recallが低い場合、自由文クエリより悪化するケースがどの程度あるか。
- entity抽出・正規化が弱い専門領域コーパス、日本語コーパス、コード検索に拡張できるか。
- SNCのfrozen answererがgold answer probabilityを見る設計なので、gold answerがないオンライン学習や実運用で何に置き換えるべきか。
- 公開コード https://github.com/7HHHHH/Harness-G の環境部分だけを既存RAG agentに移植できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
