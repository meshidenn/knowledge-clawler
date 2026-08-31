# Paperpile Brief 2026-09-01 - WikiSkill: Compiling agent experience into persistent knowledge for skill evolution

## 基本情報

- **タイトル**: WikiSkill: Compiling agent experience into persistent knowledge for skill evolution
- **著者**: Liyan Tang, Cyrus Rashtchian, Chun-Sung Ferng, Andrew Tomkins, Da-Cheng Juan, Tu Vu
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.27454](https://arxiv.org/abs/2608.27454) / [PDF](https://arxiv.org/pdf/2608.27454)

## 落合陽一フォーマット

- **ひとことでいうと**: エージェントの試行錯誤ログを永続的な「Wiki」にコンパイルし、その知識を使って再利用可能なスキルを継続進化させる枠組み。
- **先行研究と比べてどこがすごい？**: EvoSkill・Trace2Skill・SkillOptも軌跡からスキルを更新するが、学びを独立した蓄積知識として管理しない。WikiSkillは生ログ、構造化Wiki、実行スキルを分離し、却下された更新案も含む履歴を次の改善に活かす。5ベンチマーク・5モデルで既存法を平均3.3〜12.0ポイント上回ったと報告する。
- **技術や手法の肝はどこ？**: `raw/`に不変の実行軌跡を保存し、Wiki Maintainerが失敗要因・成功パターン・更新履歴を`wiki/`へ整理する。Skill ProposerがWikiと最新軌跡から`skills/`を更新し、検証セットで改善した変更だけを採用する。スキルはロールバックされてもWikiは消さず、経験を複利的に残す設計である。
- **どうやって有効だと検証した？**: 数学推論、Web検索、表計算、長文書QA、環境操作の5ベンチマークで、Qwen・Gemma・Gemini系の5モデルを評価した。進化プロセスを各手法3回ずつ実行し、テスト性能平均とpaired bootstrap testで比較している。たとえばQwen-3.5-9B＋WikiSkillは平均47.4%で、スキルなしQwen-3.6-27Bの39.4%を上回った。Wikiを使えなくするアブレーションでも性能低下が確認された。
- **議論はある？**: スキルを毎回プロンプトへ直接注入しており、スキル検索・発火の失敗は評価していない。検証性能を即時に改善しない更新を厳格に棄却するため、長期的には有益な変更を逃す可能性がある。Wikiの自動剪定も未実装で、長期運用時の肥大化、数百ステップ・数時間級の長期タスクへの有効性は未検証である。
- **次に読む/試すなら**:
  1. 自分のエージェント実行ログを不変保存し、失敗パターン・採否履歴をMarkdown Wikiへ分離する。
  2. スキル更新を検証ゲート付きの差分として管理し、却下理由も次回提案の入力に残す。
  3. スキル数が増えた条件で、WikiSkillと検索・選択機構を組み合わせて評価する。
- **キーワード**: `agent skills`, `skill evolution`, `persistent knowledge`, `agent memory`, `execution traces`, `LLM agents`

## 気になったこと

- Wikiへのアクセスを推論時に制限した方がよいという結果は、知識の参照自体が悪いというより、実行時コンテキストのノイズや過剰適合を示している可能性がある。
- Wikiのパターン記述品質を誰がどの基準で保証するか、誤った知識が長期に蓄積した場合の訂正・剪定戦略を確認したい。
- 各ベンチマーク専用にスキルを進化させているため、未知ドメインへの汎化と、実運用でのスキル検索込みの性能を検証したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [tang2026-mp-wikiskill-compiling-agent-experience-into-persistent-knowled-98ca4598.md](../../chat/2026-09-01/tang2026-mp-wikiskill-compiling-agent-experience-into-persistent-knowled-98ca4598.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
