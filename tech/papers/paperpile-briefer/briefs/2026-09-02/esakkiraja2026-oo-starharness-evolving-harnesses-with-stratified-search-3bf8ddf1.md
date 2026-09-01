# Paperpile Brief 2026-09-02 - StarHarness: Evolving Harnesses with Stratified Search for Enterprise Environments

## 基本情報

- **タイトル**: StarHarness: Evolving Harnesses with Stratified Search for Enterprise Environments
- **著者**: Esakkivel Esakkiraja, Denis Akhiyarov, Vikas Yadav, Sai Rajeswar, Patrice Bechard, Sridhar Nemala, Sagar Davasam
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.24804](https://arxiv.org/abs/2608.24804)

## 落合陽一フォーマット

- **ひとことでいうと**: モデルの重みを変えず、プロンプト・ツール定義・スキル・MCP・サブエージェント構造などの「ハーネス」を探索的に進化させ、企業環境でのLLMエージェント性能を大幅に改善する手法。
- **先行研究と比べてどこがすごい？**: 単なるプロンプト最適化ではなく、実行可能なエージェント基盤全体を対象にする。探索用・選択用・hold-out用のタスクを分離し、探索への過適合を抑えつつ、GPT/Qwen間でも再進化なしに転移することを示した。
- **技術や手法の肝はどこ？**: ベースラインの失敗モード、スコア、verifier通過率でタスクを層化し、小さな探索プールを構成する。候補パッチはスコープ検査・smoke test・単一タスクでの改善確認を通過してから、提案者に隠した選択セットで評価される。改善した変更だけを採用し、失敗候補は元に戻す。
- **どうやって有効だと検証した？**: ITBench SRE（40件）、EnterpriseOps-Gym ITSM（103件）、AutomationBench Finance（100件）で評価。GPT-5.4では既定ハーネス比で、それぞれ40.0→75.0%、23.3→43.7%、57.1→83.2%へ改善した。hold-outタスクでも+15.1〜+31.7ポイントの改善を報告し、Qwenおよび別GPTモデルにも転移した。
- **議論はある？**: ベンチマーク別のハーネスと評価環境への依存が強く、実運用環境への一般化は未検証。比較対象とはハーネス構成・ツール・実行方策が異なるため、各要素の因果的寄与は切り分けられていない。探索コスト、変更の保守性、guardrailの十分性も今後の検証課題。
- **次に読む/試すなら**:
  - 自分のMCP／業務エージェントで、失敗トレースを失敗類型ごとに層化して小規模なハーネス改善ループを作る。
  - ツール引数の正規化、空値除去、完了条件・状態依存の明示といった「interface repair」を先に手動で試す。
  - タスク単位のhold-outと、モデル間での凍結ハーネス転移評価を導入する。
- **キーワード**: `agent harness`, `harness evolution`, `enterprise agents`, `MCP`, `tool use`, `stratified search`, `LLM agents`

## 気になったこと

- PDF本文に基づく要約。選択セットの規模、探索反復ごとの計算コスト、乱数シードごとの分散は本文抽出範囲からは不明。
- 「タスクID分岐や正解ハードコード禁止」の検査が、暗黙的なベンチマーク過適合をどこまで防げるか確認したい。
- 改善がハーネス固有の知識追加によるものか、単純なツールAPI設計修正によるものかを、要素別アブレーションで見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [esakkiraja2026-oo-starharness-evolving-harnesses-with-stratified-search-3bf8ddf1.md](../../chat/2026-09-02/esakkiraja2026-oo-starharness-evolving-harnesses-with-stratified-search-3bf8ddf1.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
