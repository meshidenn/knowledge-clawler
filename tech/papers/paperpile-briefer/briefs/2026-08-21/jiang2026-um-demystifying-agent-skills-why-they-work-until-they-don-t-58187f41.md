# Paperpile Brief 2026-08-21 - Demystifying Agent Skills: Why They Work—Until They Don’t

## 基本情報

- **タイトル**: Demystifying Agent Skills: Why They Work—Until They Don’t
- **著者**: Zhiyuan Jiang, Fangrui Huang, Hanwen Xing, Xander Wu, Yipeng Gao, Rui Cao, Mengdi Wang, Shilong Liu, Yijiang Li
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.14036](https://arxiv.org/abs/2608.14036) / [PDF](https://arxiv.org/pdf/2608.14036)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントの「Skill」は知識を足す仕組みというより、過去の試行錯誤を圧縮して実行手順を安定化する「手続き的アンカー」として効く、という実証研究。
- **先行研究と比べてどこがすごい？**: 最終成功率だけでSkillの有効性を測る従来評価から進み、表現形式・成功/失敗ラベル・フレームワーク間転移・検索難度を切り分けた。対応条件ではWorkflow Memoryより6.06ポイント高く、成功メカニズムの65.7%を手続き的アンカリング、明示的な知識注入を4.5%と分類している。
- **技術や手法の肝はどこ？**: 同じ実行軌跡を、直接的なWorkflow Memoryと標準化した`SKILL.md`形式のSkillへそれぞれ蒸留し、条件を揃えて比較する。さらにSkillあり/なしの対応軌跡を分析し、8,135試行記録と240件のオープンコーディングから、3カテゴリ・12種類のSkill利用モードを整理した。
- **どうやって有効だと検証した？**: Terminal-Bench 2.0、Terminal-Bench Pro、SkillsBenchで、Codex/GPT系とGemini CLI/Gemini系を用いて評価した。検索実験では候補Skill数と類似・非類似の妨害Skillを変え、埋め込み検索、明示選択、実行時利用を独立に測定した。候補数が5から100へ増えると実行中の正確なSkill利用のprecisionは29.6%から3.3%へ下がる一方、下流のタスク成功率は必ずしも連動しなかった。
- **議論はある？**: 評価対象は主に端末・ツール利用ベンチマークであり、長期Web操作やオープンエンドな協働へは未検証。モデルとエージェント基盤の組合せも限定的で、分類は全記録の約3%に相当するサンプルの人手コーディングに基づく。Skillは文脈不適合、過度に脆い仮定、表層的な呼び出し、適応不足で失敗しうる。
- **次に読む/試すなら**:
  - 自分のエージェントで、生ログ型メモリと圧縮した手順型Skillを同一タスク群で比較する。
  - 検索のtop-1精度だけでなく、「どのSkillをどう参照して成功したか」を実行軌跡から評価する。
  - 類似Skillが混ざる大規模Skillプールで、適応・選択・検証を分離したアブレーションを行う。
- **キーワード**: `LLM agents`, `agent skills`, `procedural memory`, `skill retrieval`, `trajectory analysis`

## 気になったこと

- 正解Skillそのものを呼ばなくても成功するなら、Skill単位の正解ラベルではなく「提供された手続き的要素」の粒度で評価すべきではないか。
- Skillの圧縮率、記述テンプレート、実行可能コードの有無のどれが「手続き的アンカー」としての効力を左右するかを確認したい。
- 失敗軌跡をどの程度混ぜるとSkillが改善され、どの段階でノイズや誤誘導に転じるかを、タスク難度別に見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [jiang2026-um-demystifying-agent-skills-why-they-work-until-they-don-t-58187f41.md](../../chat/2026-08-21/jiang2026-um-demystifying-agent-skills-why-they-work-until-they-don-t-58187f41.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
