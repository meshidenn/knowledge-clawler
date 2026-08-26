# Paperpile Brief 2026-08-27 - One success isn't reliability: Thinkingbox, a sandbox and benchmark for agents in stateful business workflows

## 基本情報

- **タイトル**: One success isn't reliability: Thinkingbox, a sandbox and benchmark for agents in stateful business workflows
- **著者**: Zhuochun Li, Youngmin Ko, Ali Keramati, Nicola Ferri, Susana Palmaz Lopez Pelaez, Liang-Chun Tsai, Calvin Wang, Mirco Milletari, Tuhin Kundu, Vadim Smolyakov, Kjartan Ólafsson, Tommy Guy
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.19741](https://arxiv.org/abs/2608.19741) / [PDF](https://arxiv.org/pdf/2608.19741.pdf) / [実装](https://github.com/microsoft/thinkingbox)

## 落合陽一フォーマット

- **ひとことでいうと**: 状態を変える実務エージェントは「一度成功した」だけでは不十分であり、正しい副作用を繰り返し再現できるかを測るためのMCP対応サンドボックスと507件のベンチマークを提案した論文。
- **先行研究と比べてどこがすごい？**: 単一の応答やtool callの正しさではなく、最終バックエンド状態・余計な副作用・必要に応じた対話内容を実行可能な判定器で評価する。5業務領域をまたぎ、20回反復で「成功経路を発見できること」と「毎回成功する信頼性」を分離して測定した点が新しい。
- **技術や手法の肝はどこ？**: Thinkingboxは、模擬ユーザー、隔離されたMCP互換ツールセッション、エージェント、副作用抽出器、判定器を一つのループに統合する。各タスクを初期状態・ユーザー目標・ツール・ユーザー方策・隠れた実行チェックからなるPOMDPとして扱い、最終状態と実行履歴から正誤を判定する。正しい状態遷移でも誤ったレコード更新や不要な更新があれば失敗となる。
- **どうやって有効だと検証した？**: 小売、旅行・宿泊、自動車保険、ネオバンク社内IT、コンサルティングIT/HRの5領域・507ワークフローで、12のproprietary/open-weightモデルを各20回試行した。最強モデルはpass@1で65.36%、少なくとも1回成功したタスクは91.12%だった一方、20回すべて成功したのは25.25%で、発見可能性と信頼性の大きな隔たりを示した。
- **議論はある？**: 507件中477件は最終状態と副作用のみを評価するため、ユーザーへの説明が誤っていても状態遷移が正しければ成功になり得る。タスクは非公開の業務ケースをもとにした合成データであり、実企業業務の代表標本ではない。また、模擬ユーザーと30件の応答rubricの判定には固定のGPT-5.4-mini系が用いられ、実ユーザーの曖昧さ・非協力性・目標変更や、同一モデル系列による相性は十分に検証されていない。
- **次に読む/試すなら**:
  - Thinkingboxを用いて、自分のエージェントで「最終状態＋副作用なし」を満たす回帰テストを作る。
  - pass@1だけでなく、同一タスクの反復成功率（all-*k* success）を運用指標に追加する。
  - τ-bench、AppWorld、MCP-Benchと比較し、評価対象の状態性・対話性・MCP対応の差を整理する。
- **キーワード**: `LLM agents`, `stateful workflows`, `MCP`, `agent benchmark`, `reliability`, `tool use`, `executable evaluation`

## 気になったこと

- 最強モデルが何か、モデルごとの失敗モード差、プロンプト・温度・最大ターン数への感度を確認したい。
- 20回すべて成功しない主因が、情報収集、policy遵守、ツール引数、状態更新順序のどれかをタスク難度別に見たい。
- 実運用で重要な「ユーザー説明の正確さ」を477件にも広げた場合、評価順位と成功率がどの程度変化するか気になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [li2026-fz-one-success-isn-t-reliability-thinkingbox-a-sandbox-and-benchm-32de95eb.md](../../chat/2026-08-27/li2026-fz-one-success-isn-t-reliability-thinkingbox-a-sandbox-and-benchm-32de95eb.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
