# Paperpile Brief 2026-07-28 - AREX: Towards a Recursively Self-Improving agent for deep research

## 基本情報

- **タイトル**: AREX: Towards a Recursively Self-Improving agent for deep research
- **著者**: Shuqi Lu, Chaofan Li, Kun Luo, Zhang Zhang, Hui Wang, Hongwang Xiao, Zheng Liu, Lei Xiong, Jiahao Wang, Sen Wang, Xiyan Jiang, Wanli Li, Yuyang Hu, Hongjin Qian, Bingyu Yan, Ziyi Xia, Yingxia Shao, Kang Liu, Zhicheng Dou, Di He, Chaozhuo Li, Qiwei Ye, Zhongyuan Wang, Zheng Liu / AREX Team
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: arXiv:2607.21461v2, PDF: https://arxiv.org/pdf/2607.21461, Homepage: https://vectorspacelab.github.io/arex-model/, Models: https://huggingface.co/collections/BAAI/arex

## 落合陽一フォーマット

- **ひとことでいうと**: deep research agentを、単に長く検索させるのではなく、暫定回答を制約ごとに検証し、未解決点を次の調査目標に変換して再帰的に改善するAREXを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の長時間search / tool-use agentが「1本の探索軌跡を伸ばす」方向に寄りがちな一方、AREXは発見より検証が安いという非対称性に着目し、検証結果を次ラウンドの制御信号にする。4B dense版と122B-A10B MoE版で、BrowseComp、WideSearch、DeepSearchQA、HLE、GAIAなど複数ベンチで同規模baselineを上回ったと報告している。
- **技術や手法の肝はどこ？**: inner research loopで検索・閲覧・証拠統合・暫定回答を行い、outer self-improvement loopで回答を制約単位に監査する二層構造。さらに`update_context`という学習済みcontext更新toolを使い、長い履歴を「検証済み事実、候補、未解決制約、懸念、棄却候補、次の計画」に圧縮する点が核。
- **どうやって有効だと検証した？**: BrowseComp、WideSearch、DeepSearchQA、Humanity's Last Exam with Tools、GAIA、xbench-DeepSearchなどで評価。BrowseCompのablationでは、ACUなし・outer loopなしが59.6、outer loopありで69.8、ACUあり・outer loopなしで71.4、両方ありで82.5とされ、context更新と再帰的改善の両方が効くと示している。
- **議論はある？**: ベンチマーク中心の評価であり、実運用での検索環境、source quality、引用の正確性、コスト、latency、失敗時の挙動は本文からは限定的にしか分からない。自己申告confidenceをouter loopの判断に使うため、confidence calibrationの頑健性も重要な仮定。細かい数値はPDF抽出テキスト由来で、表の取りこぼしやレイアウト崩れの可能性がある。
- **次に読む/試すなら**: 1. AREXの`update_context`出力schemaを自分のdeep research workflowに移植して試す。2. BrowseComp型のmulti-constraint taskを小さく作り、outer loopあり/なしで比較する。3. confidence thresholdと「REFINE / RESTART / ACCEPT」の判定基準を実装観点で確認する。
- **キーワード**: `deep research agent`, `recursive self-improvement`, `autonomous context updating`, `tool-use agent`, `long-horizon RL`, `constraint-wise verification`

## 気になったこと

- `update_context`は外部summarizerではなくAREX自身が呼ぶ設計だが、圧縮ミスで重要証拠を落とした場合の検出方法が気になる。
- confidence scoreが高い誤答、低い正答をどの程度扱えるのか、threshold設計の詳細を確認したい。
- synthetic verified tasksとhigh-quality trajectoriesの作り方が再現性の鍵になりそう。
- 自分の論文調査agentに入れるなら、まず「未解決制約」「棄却済み候補」「次に確認するsource」を明示的に保存するだけでも効果がありそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [lu2026-vp-arex-towards-a-recursively-self-improving-agent-for-deep-resea-cee16563.md](../../chat/2026-07-28/lu2026-vp-arex-towards-a-recursively-self-improving-agent-for-deep-resea-cee16563.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
