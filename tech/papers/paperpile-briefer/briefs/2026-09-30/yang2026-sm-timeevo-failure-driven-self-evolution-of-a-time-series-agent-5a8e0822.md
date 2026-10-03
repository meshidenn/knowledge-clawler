# Paperpile Brief 2026-09-30 - TimeEvo: Failure-driven self-evolution of a time series agent

## 基本情報

- **タイトル**: TimeEvo: Failure-driven self-evolution of a time series agent
- **著者**: Jie Yang, Yan Zheng, Jiarui Sun, Xiran Fan, Junpeng Wang, Liang Wang, Zelin Xu, Qinghua Liu, Zhengyu Fang, Yiwei Cai, Philip S. Yu
- **年 / venue**: 2026 / arXiv [cs.AI]（arXiv:2609.27277）
- **リンク**: https://arxiv.org/abs/2609.27277

## 落合陽一フォーマット

- **ひとことでいうと**: 時系列QAエージェントの失敗を分類し、足りない数値計測ツールを自動生成・検証して、壊すより直す場合だけツールライブラリに追加する自己進化手法。
- **先行研究と比べてどこがすごい？**: 人手設計の21ツールはタスクによって性能を改善・悪化させ、異常検知では全バックボーンで5.8〜8.8ポイント低下した。一方、TimeEvoは空のライブラリから開始し、10タスク・3バックボーンすべてで改善し、プールした改善幅は+1.5〜+14.7ポイントだった。単純なSelf-Refineのように平均スコアだけを見るのではなく、正解を壊した数（harm）と誤答を直した数（helped）を別々に評価する点が新しい。
- **技術や手法の肝はどこ？**: ①失敗を「ツールが誤用された失敗」と「必要なツールがない失敗」に分けてクラスタリング、②各クラスタを根本原因・必要な計測・適用範囲・反適用範囲を含むmeasurement contractに変換、③LLMに判定ではなく数値証拠だけを返すPythonツールを合成させる、④個別ツールの事前フィルタと、既存ライブラリとのpaired admission gateを通過した候補だけを採用する、という構成。推論時も対象外の質問にはツールを適用せず、既存回答をデフォルトとして保護する。
- **どうやって有効だと検証した？**: TemporalBench、TimeSeriesExam、Time-MQA、MMTS-Bench、TSAQAなど6ソースの10タスクで、train/validation/testを系列単位で分離し、3種類のLLMバックボーンと比較した。改善例として、フーリエ変換の候補を目視で選び誤答したケースを残差計算ツールで修正し、履歴と予測区間の分散を計算せず「不明」と答えたケースをMAD差分ツールで修正した。安価なモデルで成長させたライブラリを強いモデルへ移植しても改善した。
- **議論はある？**: in-scopeの質問では依然として害が起こり得るため、ゲートは無害性を保証しない。また、失敗クラスタリング、契約設計、ツール合成をLLMに依存し、反復的な検証コストも発生する。評価は選択肢付きの時系列QAと凍結エージェントが中心で、自由形式の分析、長期運用、異なるデータ分布で同様に有効かはメタデータからは不明。論文自体もarXiv preprintであり、独立再現の状況は不明。
- **次に読む/試すなら**:
  1. TimeEvoのコードを取得し、空ライブラリからの最小ラウンドを再現する。
  2. `helped` と `harmed` を分けたpaired gateを、自分のLLMエージェント評価に導入する。
  3. 時系列以外のツールエージェントで、失敗クラスタから証拠生成器を作れるか試す。
- **キーワード**: `failure-driven self-evolution`, `time series agent`, `evidence-only tools`, `paired admission gate`, `silent harm`

## 気になったこと

- 複数ラウンドで生成されたツールが、古いツールとの相互作用によって性能を悪化させないか。
- validationでのhelped/harmed判定が、テスト分布や自由形式回答でも安定するか。
- ツール合成・実行・検証に必要なLLMコストと、手作業でツールを設計するコストの比較。
- ツールを増やすのではなく、既存ツールのREFINE・RESCOPE・RETIREを選ぶ基準がどの程度再現的か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yang2026-sm-timeevo-failure-driven-self-evolution-of-a-time-series-agent-5a8e0822.md](../../chat/2026-09-30/yang2026-sm-timeevo-failure-driven-self-evolution-of-a-time-series-agent-5a8e0822.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
