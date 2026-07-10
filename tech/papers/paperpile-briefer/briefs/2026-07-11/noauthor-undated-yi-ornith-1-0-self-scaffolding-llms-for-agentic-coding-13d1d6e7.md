# Paperpile Brief 2026-07-11 - Ornith-1.0: Self-scaffolding {LLMs} for agentic coding

## 基本情報

- **タイトル**: Ornith-1.0: Self-scaffolding {LLMs} for agentic coding
- **著者**: メタデータからは不明
- **年 / venue**: 年はメタデータからは不明 / DeepReinforce
- **リンク**: DOI・arXiv・URLはいずれもメタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: agentic coding task向けに、自己改善するopen-source LLMファミリ「Ornith-1.0」を提案している論文。PDF本文がなく、要約はabstractベース。
- **先行研究と比べてどこがすごい？**: 「self-improving」「self-scaffolding」を掲げ、単なるコード生成モデルではなく、エージェント的なコーディング作業に特化したモデル群である点が新規性と思われる。ただし、既存モデルとの性能差や具体的な比較対象はメタデータからは不明。
- **技術や手法の肝はどこ？**: 肝は、LLMがagentic codingに必要な足場かけを自己生成・自己改善する仕組みにあると推測される。具体的な学習手順、データ生成、評価ループ、scaffoldの定義はメタデータからは不明。
- **どうやって有効だと検証した？**: 実験・ベンチマーク・比較対象・定量結果はメタデータからは不明。
- **議論はある？**: PDF本文がないため、限界や失敗例は不明。特に、自己改善ループの再現性、評価データへの過適合、agentic codingでの安全性、実タスクでの安定性は確認が必要。
- **次に読む/試すなら**: Ornith-1.0の公式リポジトリやモデルカードを探す。agentic coding benchmarkでの評価結果を確認する。self-scaffoldingの具体的なデータ生成・訓練手順を読む。
- **キーワード**: `agentic coding`, `self-improving LLM`, `self-scaffolding`, `open-source model`, `coding agent`

## 気になったこと

- 「self-scaffolding」がプロンプト生成、ツール利用計画、コード修正ループ、学習データ生成のどれを指すのか。
- SWE-bench、LiveCodeBench、terminal-based coding taskなどで既存open modelと比較しているか。
- 自己改善に使ったデータや評価環境が公開されているか。
- open-source model familyとして、重み・学習コード・データ生成パイプラインのどこまで公開されているか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [noauthor-undated-yi-ornith-1-0-self-scaffolding-llms-for-agentic-coding-13d1d6e7.md](../../chat/2026-07-11/noauthor-undated-yi-ornith-1-0-self-scaffolding-llms-for-agentic-coding-13d1d6e7.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
