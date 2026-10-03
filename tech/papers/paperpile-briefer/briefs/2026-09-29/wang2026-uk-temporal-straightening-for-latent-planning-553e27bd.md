# Paperpile Brief 2026-09-29 - Temporal Straightening for Latent Planning

## 基本情報

- **タイトル**: Temporal Straightening for Latent Planning
- **著者**: Ying Wang, Oumayma Bounou, Gaoyue Zhou, Randall Balestriero, Tim G. J. Rudner, Yann LeCun, Mengye Ren
- **年 / venue**: 2026 / ICML 2026（PMLR 306、arXiv:2603.12231）
- **リンク**: https://arxiv.org/abs/2603.12231

## 落合陽一フォーマット

- **ひとことでいうと**: JEPA型ワールドモデルの潜在表現に軌道の曲率正則化を加え、勾配ベースの潜在計画を安定化する手法を提案した。
- **先行研究と比べてどこがすごい？**: DINOv2などの視覚表現は意味的には強い一方、計画には不要な情報や曲がった幾何を含む。時間方向の軌道をstraightenすることで、ユークリッド距離を実行可能軌道上の測地距離に近づけ、CEMなどの探索に頼らず勾配法で高い成功率を得る。4環境の実験で、従来表現に対して多くの設定で10%以上、論文全体ではopen-loopで20〜60%、MPCで20〜30%の改善を報告している。
- **技術や手法の肝はどこ？**: 連続する潜在差分 \(v_t=z_{t+1}-z_t\) と \(v_{t+1}=z_{t+2}-z_{t+1}\) のcosine similarityを最大化し、局所的な軌道曲率を下げる。予測損失と組み合わせて、エンコーダ・アクションエンコーダ・予測器を共同学習する。stop-gradientによるcollapse対策も利用する。
- **どうやって有効だと検証した？**: Wall、PointMaze UMaze、PointMaze Medium、PushTで、DINOv2特徴、投影器、ResNetを比較。open-loopおよびMPCの勾配降下計画を評価し、潜在軌道の曲率、距離と測地距離の整合性、損失地形、成功率を分析した。例えばDINOv2 patch＋projectorでは、Wallのopen-loop成功率が80.0%から90.67%、UMazeが44.0%から94.0%に向上した。
- **議論はある？**: 主な検証は2Dシミュレーション環境と比較的短い計画 horizonに依存する。長期予測では誤差の累積と軌道ドリフトが依然として大きい。また、対称なユークリッド目標コストを前提としており、非対称・不可逆なダイナミクスにはquasimetricなど方向性を持つコストが必要になり得る。線形ダイナミクスでは理論保証があるが、非線形予測器への一般化は未解決である。
- **次に読む/試すなら**:
  1. 公式コードを使い、DINOv2 patch特徴＋projectorに曲率損失を追加してUMazeで再現する。
  2. 曲率係数 \(\lambda\) と特徴次元を変え、成功率・計画時間・予測誤差のトレードオフを測る。
  3. 長期計画で、局所的なspatial costとglobal aggregation costを併用する。
- **キーワード**: `latent planning`, `temporal straightening`, `JEPA world model`, `curvature regularization`, `gradient-based planning`

## 気になったこと

- 曲率を下げることで、計画に必要な幾何は改善する一方、複雑な接触運動や分岐するダイナミクスを過度に直線化していないか。
- 成功率向上が曲率正則化そのものによるのか、学習可能なprojectorやencoderによる暗黙のstraighteningによるのかを、より厳密に分離できるか。
- 実環境の画像・ロボットデータや、長期・高次元タスクでも同じ効果が得られるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [wang2026-uk-temporal-straightening-for-latent-planning-553e27bd.md](../../chat/2026-09-29/wang2026-uk-temporal-straightening-for-latent-planning-553e27bd.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
