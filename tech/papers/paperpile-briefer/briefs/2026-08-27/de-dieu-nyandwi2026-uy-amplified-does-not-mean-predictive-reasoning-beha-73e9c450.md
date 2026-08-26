# Paperpile Brief 2026-08-27 - Amplified does not mean predictive: Reasoning behaviors in thinking models

## 基本情報

- **タイトル**: Amplified does not mean predictive: Reasoning behaviors in thinking models
- **著者**: Jean de Dieu Nyandwi, Leena Mathur, Yonatan Bisk, Robert Hawkins, Graham Neubig
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.13760v1](https://arxiv.org/abs/2608.13760v1)

## 落合陽一フォーマット

- **ひとことでいうと**: Thinking modelが増やす「熟考らしい振る舞い」は、正答と最も強く結び付く振る舞いとは限らないことを、15,282件の推論トレースで示した論文。
- **先行研究と比べてどこがすごい？**: 推論の長さや正答率ではなく、各行動の出現有無による正答率差を`Behavioral Lift`として定量化した。自己修正・仮説検証・不確実性の表明はthinking訓練で増える一方、高Liftなのは確信度の較正・知識整合性・自己認識だった。
- **技術や手法の肝はどこ？**: LLM/VLM共通の9行動分類と、失敗後にも正答へ戻れる度合いを測る`Recovery Rate`を導入した点。`Lift(b)=P(correct|bあり)-P(correct|bなし)`で、頻出行動と正答に関連する行動を切り分ける。
- **どうやって有効だと検証した？**: 15個の公開モデル、6ベンチマーク、LLM/VLMの推論トレース15,282件をGPT-4oで注釈し、別judgeモデル・人手確認・同一問題内の複数サンプル比較・注釈ノイズ耐性で検証した。確信度較正のLiftはVLMで+72.2%、LLMで+79.6%だった一方、不確実性表明は両方で負のLiftだった。
- **議論はある？**: Liftは因果効果ではなく相関であり、正しい推論経路に乗っていることの結果を測っている可能性がある。また可視CoTは内部計算を忠実に表さない場合があり、LLM-as-judge由来の系統的な注釈バイアスも残る。モデル間で推論時の生成設定が異なる点も比較上の留保になる。
- **次に読む/試すなら**: 1. 高Lift行動（較正・知識整合性・自己認識）を促す推論プロンプトを既存タスクで比較する。 2. 正答のみでなく、失敗率とRecovery Rateを評価指標に加える。 3. 高Lift行動を直接報酬化するprocess supervisionを因果的に検証する。
- **キーワード**: `reasoning models`, `chain-of-thought`, `Behavioral Lift`, `confidence calibration`, `process supervision`, `LLM-as-judge`

## 気になったこと

- 確信度較正が高Liftなのは原因なのか、良い推論がすでに成立している際の観測信号なのか。
- thinking/instruct間でデコード設定・最大生成長が異なるため、行動差のどこまでを訓練効果と見なせるか。
- 高Lift行動を明示的に強化した訓練が、正答率・頑健性・推論長をどう変えるか。
- LogiQA2ではinstructモデルが上回るため、タスク特性ごとに「考えるべきか」を切り替える制御が必要ではないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [de-dieu-nyandwi2026-uy-amplified-does-not-mean-predictive-reasoning-beha-73e9c450.md](../../chat/2026-08-27/de-dieu-nyandwi2026-uy-amplified-does-not-mean-predictive-reasoning-beha-73e9c450.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
