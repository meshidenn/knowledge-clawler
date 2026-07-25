# Paperpile Brief 2026-07-26 - Harness Handbook: Making Evolving Agent Harnesses Readable, Navigable, and Editable

## 基本情報

- **タイトル**: Harness Handbook: Making Evolving Agent Harnesses Readable, Navigable, and Editable
- **著者**: Ruhan Wang, Yucheng Shi, Zongxia Li, Zhongzhi Li, Yue Yu, Junyao Yang, Kishan Panaganti, Haitao Mi, Dongruo Zhou, Leoweiliang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: arXiv:2607.13285 / PDF: https://arxiv.org/pdf/2607.13285 / Project: https://ruhan-wang.github.io/Harness-Handbook/

## 落合陽一フォーマット

- **ひとことでいうと**: agent harnessの変更時に「どの振る舞いがどのコードで実装されているか」を自動で対応付ける、behavior-centricなドキュメント表現 Harness Handbook と、その上を段階的に探索する BGPD を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のrepository map、code search、long-context処理はファイル・関数・モジュール中心だが、この研究は変更要求が本来記述する「振る舞い」から実装箇所へ橋を架ける点が差分。CodexとTerminus-2の2つのopen-source harnessで、Handbook-assisted planningはplan qualityのwin rateを上げつつplanner tokenを削減した。
- **技術や手法の肝はどこ？**: Harness HandbookはL1 system overview、L2 component overview、L3 unit deep diveの3階層で、実行ステージ・状態・依存関係・入力出力・例外処理・source locatorを整理する。構築は静的解析でcall graph、state access、functions tableなどを抽出し、LLMでbehavioral structuringする。BGPDは高レベルのbehaviorから関連stage、unit、source locatorへ段階的に開示し、候補箇所が現行sourceにまだ対応しているかも検証する。
- **どうやって有効だと検証した？**: CodexとTerminus-2から各30件、合計60件のbehavior-driven modification requestを作り、BaselineとHandbook-Assistedを比較。plannerはDeepSeek-V4-Proベース、評価はGPT-5.5、Opus 4.8、DeepSeek-V4-Proの3 judge。plan quality、localization accuracy、planner tokenを評価し、Codexではwin rateが28.3%から38.3%、Terminus-2では26.7%から45.6%へ向上。token使用量はCodexで12.7%、Terminus-2で8.6%減った。
- **議論はある？**: 評価対象は2つのagent harnessに限られるため、他の大規模・閉源・多言語harnessへの一般化は未検証。Handbook生成自体にLLMを使うので、初期生成品質、stage skeleton、source locatorの同期維持が性能に効く。細かい数値はPDF抽出テキスト由来なので表の読み取り誤差には注意が必要。
- **次に読む/試すなら**: 1. ProjectページとarXiv PDFでBGPD prompt templateを確認する。2. 自分のagent harnessに対して「behavior localizationが難しい変更要求」を10件ほど作り、手動mapと比較する。3. 既存のrepository mapやcode indexとHandbookをどう併用できるか試す。
- **キーワード**: `agent harness`, `behavior localization`, `repository understanding`, `coding agents`, `static analysis`, `LLM-assisted structuring`, `progressive disclosure`

## 気になったこと

- Handbook生成・更新のコストが、実運用でどれくらいの頻度なら許容できるか。
- source locatorがfreezeされた場合、再同期の失敗をどう開発者に見せるのがよいか。
- 「behavior」の粒度を誰がどう決めるのか。seed skeletonがある場合とない場合で品質差が大きそう。
- CodexやTerminus-2以外の、plugin-heavyまたはevent-drivenなagent harnessでも同じ効果が出るか。
- 実装するなら、まずはfile-as-leaf modeで既存repoに軽量なHandbookを作るのが現実的そう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [wang2026-zj-harness-handbook-making-evolving-agent-harnesses-readable-na-9f70edb6.md](../../chat/2026-07-26/wang2026-zj-harness-handbook-making-evolving-agent-harnesses-readable-na-9f70edb6.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
