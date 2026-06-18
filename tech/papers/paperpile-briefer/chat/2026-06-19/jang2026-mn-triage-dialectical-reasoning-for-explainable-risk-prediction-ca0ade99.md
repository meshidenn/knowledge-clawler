# Chat Prompt 2026-06-19

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {TRIAGE}: Dialectical reasoning for explainable risk prediction on irregularly sampled medical time series with {LLMs}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-19 - TRIAGE: Dialectical Reasoning for Explainable Risk Prediction on Irregularly Sampled Medical Time Series with LLMs

## 基本情報

- **タイトル**: TRIAGE: Dialectical Reasoning for Explainable Risk Prediction on Irregularly Sampled Medical Time Series with LLMs
- **著者**: Hyeongwon Jang, Gyouk Chu, Changhun Kim, Joonhyung Park, Hangyul Yoon, Eunho Yang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2606.09030](https://arxiv.org/abs/2606.09030) / [GitHub](https://github.com/HyeongWon-Jang/TRIAGE)

## 落合陽一フォーマット

- **ひとことでいうと**: 不規則に観測される医療時系列について、LLMに「悪化」と「安定」の両方の根拠を別々に考えさせることで、説明文と患者間で比較可能な連続リスクスコアを同時に生成する手法。
- **先行研究と比べてどこがすごい？**: 従来は、answer token確率による連続スコアは説明を持たず、推論文を生成する方式は結論への事前コミットによって確率が0/1付近に偏る「risk polarization」を起こしていた。TRIAGEは対立する転帰ごとの根拠を併記し、最終tokenの暗黙確率からリスクを読むことで両者を両立した。GRU-D比で平均AUPRCを相対3.3%改善し、全ベンチマークで最良の校正性能を示した。
- **技術や手法の肝はどこ？**: 観測された値だけを患者プロンプトへ直列化し、各転帰を仮定したoutcome-specific rationaleを個別生成する。結論を文章で要約せず、`Final Decision`直後の転帰token logitsをsoftmaxしてリスクにする。学習は、強いLLMが作成した非捏造・転帰別根拠によるSFTと、患者間の正負リスク分離を報酬化したGRPOによるself-refinementの2段階。推論文はRL、最終decision tokenは交差エントロピーで最適化する。
- **どうやって有効だと検証した？**: P12、P19、MIMIC-IIIの3つの二値分類ベンチマークで、GRU-D、STraTS、KEDGNなど8種の医療時系列モデルとzero-shot LLMを比較。TRIAGE SFT+RLは平均順位1.58で、平均ECEをSFTから80%、Brier scoreを49%削減した。変数を最大50%欠落させた評価でも概ね頑健だった。P12の200症例では、3種類のLLM judgeによるIDEA評価が7.744点となり、post-hoc説明の6.474点を約20%上回った。
- **議論はある？**: 評価は二値分類のみで、多クラス・多ラベルへの一般化は未検証。根拠文生成のためGRU-Dなどより学習・推論コストが高い。説明品質は臨床家ではなくLLM judgeで評価され、生成根拠に誤りやバイアスが残る可能性がある。また、強いLLMが生成したSFTデータへの依存、施設間・分布外データでの校正、実運用での臨床的有用性も未検証。
- **次に読む/試すなら**: 1. 公開コードでP12のAnswer-only、One-sided、TRIAGEを最小比較する。2. decision tokenの確率分布とECEを可視化し、risk polarizationの再現性を確認する。3. 臨床家評価や施設外データを用いた説明精度・校正性能の検証方法を調べる。
- **キーワード**: `irregularly sampled medical time series`, `clinical risk prediction`, `dialectical reasoning`, `risk calibration`, `risk polarization`, `LLM`, `GRPO`, `explainable AI`

## 気になったこと

- 転帰別根拠を生成する強いLLMの医学知識や癖が、最終モデルの説明とリスク推定へどの程度継承されるのか。
- 根拠の順序を入れ替えるaugmentationだけで、順序依存性を十分に除去できているか。
- LLM judgeで改善した説明が、臨床家の意思決定速度や精度も実際に改善するか。
- 多クラス転帰では根拠数と推論コストが増えるため、候補転帰の選択や階層化が必要ではないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
