# Chat Prompt 2026-09-30

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {IterSynth}: Rethinking deep search agents via role-decoupled iterative synthesis

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-30 - IterSynth: Rethinking deep search agents via role-decoupled iterative synthesis

## 基本情報

- **タイトル**: IterSynth: Rethinking deep search agents via role-decoupled iterative synthesis
- **著者**: Xingyu Wu, Yuchen Yan, Zhengxi Lu, Siqi Chen, Xin Zhang, Aiting Liu, Chao Deng, Jie Liu, Jin Ma, Jian Shao, Jun Xiao, Yongliang Shen
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2609.29444

## 落合陽一フォーマット

- **ひとことでいうと**: 深いWeb検索を、検索方針を決めるPlannerと、証拠を要約・統合するSynthesizerに分離し、要約状態を更新しながら反復するLLMエージェントを提案した。
- **先行研究と比べてどこがすごい？**: ReAct型の単一コンテキストにおける役割混在と履歴肥大化を同時に抑えた点。Qwen3-8B版は5ベンチマーク平均50.7点で、従来の8B以下モデルを4.2ポイント上回った。
- **技術や手法の肝はどこ？**: 同一LLMを異なるプロンプトと行動制約でPlanner/Synthesizerとして動かす。Plannerは質問と現在の要約から次の検索または終了を選び、Synthesizerは検索結果から有用な事実・矛盾・未解決点を抽出して要約状態を更新する。さらに、役割別の報酬とアドバンテージを使うRole-Decoupled Policy Optimization（RDPO）で学習する。
- **どうやって有効だと検証した？**: BrowseComp、BrowseComp-ZH、GAIA、xBench-2505、xBench-2510で評価。IterSynth-SFTの平均44.1点に対し、RDPO後は50.7点となった。ReActとの統制比較や、Claude-4.5-Opusなどへのゼロショット・プロンプティング比較も実施した。
- **議論はある？**: 学習データにはQwen3.5-397B-A17Bが生成した軌跡を含むため、性能向上がアーキテクチャ自体によるのか、教師軌跡の品質によるのかは完全には切り分けにくい。RLではキャッシュ済み検索、評価ではライブ検索を使うため、分布差もある。要約が誤情報を保持・増幅する可能性、LLM judgeによる役割別報酬の妥当性、実運用時の検索コストは追加検証が必要。
- **次に読む/試すなら**:
  1. ReActとIterSynthで同一モデル・同一検索ツールを使った最小比較を行う。
  2. 要約状態に「根拠URL・確信度・未解決点」を保持させ、情報損失を測る。
  3. RDPOを使わず、Planner/Synthesizer分離だけの効果をアブレーションする。
- **キーワード**: `deep search agents`, `role-decoupled policy optimization`, `iterative synthesis`, `context compression`, `ReAct`

## 気になったこと

- Synthesizerが要約から落とした情報を後から再取得できる仕組みはあるか。
- 役割分離による追加推論回数・検索コストが、精度向上に見合うか。
- 検索結果の誤情報や矛盾を、要約状態でどの程度検出できるか。
- 5ベンチマーク以外のドメインや、最新情報を含む継続的検索で同じ効果が出るか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは?
