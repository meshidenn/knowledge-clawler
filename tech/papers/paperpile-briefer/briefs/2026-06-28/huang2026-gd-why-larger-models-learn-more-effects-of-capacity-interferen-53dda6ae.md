# Paperpile Brief 2026-06-28 - Why larger models learn more: Effects of capacity, interference, and rare-task retention

## 基本情報

- **タイトル**: Why larger models learn more: Effects of capacity, interference, and rare-task retention
- **著者**: Jing Huang, Daniel Wurgaft, Rachit Bansal, Laura Ruis, Naomi Saphra, David Alvarez-Melis, Andrew Kyle Lampinen, Christopher Potts, Ekdeep Singh Lubana
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2605.29548

## 落合陽一フォーマット

- **ひとことでいうと**: 大きいモデルが小さいモデルより多くを学ぶ理由を、表現力だけでなく「データ分布内の希少・複雑タスクを保持できるか」という学習ダイナミクスから説明した論文。
- **先行研究と比べてどこがすごい？**: スケーリング則や創発能力の議論を、単なるサンプル効率や表現可能性ではなく、タスク頻度・複雑性・勾配干渉・記憶保持の問題として分解している。合成回帰タスクで理論的に示し、さらに OLMo 4M〜4B パラメータの事前学習実験で同じ傾向を確認している。
- **技術や手法の肝はどこ？**: タスクごとの特徴の「効用」を `頻度 × スペクトル重要度` と見なし、幅の小さいモデルは高頻度・低複雑性タスクの特徴で容量を使い切ると整理する点。大きいモデルでは共通タスクを十分に説明した後、その勾配が弱くなり、希少タスクの更新が上書きされにくくなる。
- **どうやって有効だと検証した？**: まず複数の線形回帰タスク混合で、幅を変えた student model がどの頻度・複雑性の特徴を保持するかを解析・実験した。次に Dolma v1.7 に比較タスクと modular addition タスクを制御頻度で注入し、OLMo 4M, 20M, 300M, 1B, 4B を事前学習。大きいモデルほど低頻度タスクを学び、タスク特徴が表現に現れ、非タスク勾配との干渉が小さいことを示した。
- **議論はある？**: 著者自身も、これはスケーリングの完全な説明ではなく、表現力やサンプル効率の説明と補完的だとしている。実証は注入タスク中心で、より大規模・過学習気味の言語モデル、自然発生タスク、極端な頻度範囲では未検証。PDF本文抽出からは、実装コードや再現用設定の完全性は不明。
- **次に読む/試すなら**: 1. 注入タスク頻度を上げることがモデルサイズ増加の代替になるか小規模実験で試す。 2. 自分の事前学習データで「希少だが欲しい能力」を定義し、頻度と保持を測る。 3. OLMo 実験の設定詳細と appendix を確認する。
- **キーワード**: `scaling laws`, `gradient interference`, `rare-task learning`, `task frequency`, `OLMo`, `data mixture`

## 気になったこと

- 希少タスクを「頻度」だけでなく、自然言語データ中の多様な表面形をまたいでどう同定するか。
- データミックス調整で希少タスクを増やす方が、モデルサイズを増やすより効率的になる境界条件。
- 「記憶保持が抽象化学習を助ける」という主張と、望ましくない memorization / privacy risk のトレードオフ。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [huang2026-gd-why-larger-models-learn-more-effects-of-capacity-interferen-53dda6ae.md](../../chat/2026-06-28/huang2026-gd-why-larger-models-learn-more-effects-of-capacity-interferen-53dda6ae.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
