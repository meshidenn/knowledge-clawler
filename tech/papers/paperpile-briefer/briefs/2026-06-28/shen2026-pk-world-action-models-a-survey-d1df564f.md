# Paperpile Brief 2026-06-28 - World Action Models: A survey

## 基本情報

- **タイトル**: World Action Models: A survey
- **著者**: Qiuhong Shen, Shihua Zhang, Yue Liao, Qi Li, Zhenxiong Tan, Shizun Wang, Shuicheng Yan, Xinchao Wang
- **年 / venue**: 2026 / arXiv [cs.RO]
- **リンク**: https://arxiv.org/abs/2606.20781v1 / arXiv:2606.20781v1 / DOI: メタデータからは不明 / survey homepage: https://world-action-models.github.io/

## 落合陽一フォーマット

- **ひとことでいうと**: World Action Models（WAMs）を、単なる動画生成モデルやVLAではなく「予測された未来を行動に使う embodied predictive-action model」として定義し直し、設計空間を整理したサーベイ。
- **先行研究と比べてどこがすごい？**: VLA、world model、video generation model、action-grounded video world model、WAM の境界が曖昧になっている状況に対し、WAMを「action-facing future」という契約で切り出している点。さらに、Render-and-Decode、Latent-Only、Video-Generation-Free という3分類と、predictive substrate / backbone / action coupling / deployment regime の4軸で既存研究を比較可能にしている。
- **技術や手法の肝はどこ？**: WAMを、未来表現と未来行動の条件付き同時分布として抽象化するところ。未来をRGB動画までレンダリングするのか、VAE/VQ latentや特徴空間で止めるのか、あるいは動画生成を捨ててVLM・JEPA・幾何・affordance mapで扱うのかを分解し、行動が「予測前に入る」「同時生成される」「予測後にheadで復元される」のどこに結合するかで見る。
- **どうやって有効だと検証した？**: 新しいモデルを実験で提案する論文ではなく、サーベイとして既存WAM系研究を分類・比較している。PDF抽出範囲では、具体的な新規ベンチマーク実験や数値評価の実施は確認できず、主な検証は taxonomy、統一記法、既存手法の設計軸へのマッピング、core properties の比較による整理。
- **議論はある？**: 重要な論点は「どれだけ未来を夢見るべきか」。リッチな動画生成は解釈性や表現力を持つが、制御ループでは計算量、メモリ、レイテンシ、action label cost が重い。逆に latent や feature に寄せると高速化できるが、物理妥当性や視覚的検証性が弱くなる。加えて、interactability、causality、persistence、physical plausibility、generalization をどう評価するかが未成熟。
- **次に読む/試すなら**: 1. WAMの4軸分類表を使って、自分の関心モデルを4-tupleで整理する。2. Render-and-Decode と Latent-Only の代表例を1本ずつ読み、制御ループでのレイテンシ差を見る。3. 「generate less of the future while preserving what control requires」という設計原則で、自分のロボット/エージェント用途に必要な未来表現を切る。
- **キーワード**: `World Action Models`, `embodied AI`, `VLA`, `world models`, `video generation`, `latent prediction`, `action coupling`, `robotics`

## 気になったこと

- 「WAM」と呼ぶための最小条件は、実装上どこまで future prediction が action path に入っていればよいのか。
- Rendered future の解釈性と、latent-only の実時間性をどうトレードオフするか。
- WAMの評価指標として、動画品質ではなく action success、causality、physical plausibility をどう測るべきか。
- VLAに補助損失として future feature prediction を入れるだけで、実用上どの程度WAM的な利得が出るのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [shen2026-pk-world-action-models-a-survey-d1df564f.md](../../chat/2026-06-28/shen2026-pk-world-action-models-a-survey-d1df564f.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
