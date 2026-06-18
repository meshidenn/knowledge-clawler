# Chat Prompt 2026-06-19

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {ProCUA}-{SFT} Technical Report

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-19 - ProCUA-SFT Technical Report

## 基本情報

- **タイトル**: ProCUA-SFT Technical Report
- **著者**: Jaehun Jung, Ximing Lu, Brandon Cui, Muhammad Khalifa, Shaokun Zhang, Hao Zhang, Jin Xu, Amala Sanjay Deshmukh, Karan Sapra, Andrew Tao, Yejin Choi, Jan Kautz, Mingjie Liu, Yi Dong
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2606.17321](https://arxiv.org/abs/2606.17321) / [PDF](https://arxiv.org/pdf/2606.17321.pdf)

## 落合陽一フォーマット

- **ひとことでいうと**: 実デスクトップ上で実行可能性を検証しながら合成した93K件のGUI操作軌跡を、3.1M件のステップ単位SFTデータへ展開し、Computer-Use Agentの性能を大幅に改善した論文。
- **先行研究と比べてどこがすごい？**: 最大級の公開人手データAgentNetでUI-TARS 7Bを追加学習するとOSWorld成功率が26.3%から8〜10%へ低下するのに対し、ProCUA-SFTでは45.0%まで向上した。実在する複雑な文書、2,484種類のアプリ組み合わせ、長い操作系列を含み、人手データより合成データの設計品質が重要になり得ることを示した。
- **技術や手法の肝はどこ？**: 生成したタスクに「対象ファイルが存在するか」などの二値事前条件を付け、実環境とOS設定から実行可能性を判定する。SpreadsheetBenchの912ファイル、Zenodo10Kの約10Kプレゼン、OSWorld設定でデスクトップを初期化し、Kimi-K2.5を目標生成・条件判定・操作実行の全役割に共通利用する。さらに各軌跡の全ステップをprefix単位の学習例へ変換し、推論時と同じ履歴・スクリーンショット配置で学習する。
- **どうやって有効だと検証した？**: UI-TARS 1.5 7Bを1 epoch追加学習し、OSWorldで評価した。ベースモデル26.3%、AgentNet学習8〜10%に対してProCUA-SFTは44.99%を達成した。約700ステップに予算を揃えたアブレーションでは、アプリ組み合わせによるラウンドロビン選択が30.9%で、無選別27.3%、操作種別選択24.9%、複合選択25.5%を上回った。
- **議論はある？**: 改善要因として、長い軌跡、OSWorldに近いアプリ分布、キーボード中心の安定した操作などが同時に変化しており、それぞれの因果効果は十分に分離されていない。成功判定を外部評価器ではなく実行VLM自身の`terminate`出力に依存するため、誤成功や失敗軌跡の混入余地がある。同一VLMによる生成と実行は能力差を抑える一方、そのモデルの癖や能力上限をデータへ固定する。主評価がOSWorldとUI-TARS 7Bに集中しており、別モデル・OS・ベンチマークへの一般化は未検証。
- **次に読む/試すなら**: ① 公開データで成功・失敗軌跡の混入率を調べる、② UI-TARS 7Bに小規模subsetをSFTして再現性を確認する、③ アプリ組み合わせ多様性と事前条件検証を個別に除去するアブレーションを試す。
- **キーワード**: `computer-use agent`, `GUI agent`, `synthetic trajectories`, `supervised fine-tuning`, `OSWorld`, `UI-TARS`, `task grounding`, `step-prefix expansion`

## 気になったこと

- AgentNetの負の転移が、データ品質ではなく学習率・サンプル形式・コンテキスト構成の不一致から生じていないか。
- 自己申告の成功状態と、OSWorld式の外部状態検証がどの程度一致するか。
- Kimi-K2.5以外のモデルが生成した目標を混ぜることで、教師モデル固有のバイアスを減らせるか。
- 3.1M件のstep-prefixサンプル間には強い相関があるため、実効的なデータ多様性をどう評価すべきか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
