# Paperpile Brief 2026-10-01 - Shockingly simple self-retrospection improves agentic models without RL

## 基本情報

- **タイトル**: Shockingly simple self-retrospection improves agentic models without RL
- **著者**: Jonathan Light, Christopher Zhang Cui, Jeonghye Kim, Roger Creus Castanyer, Emiliano Penaloza, Zhengyan Shi, Alessandro Sordoni, Marc-Alexandre Côté, Xingdi Yuan, Minseon Kim
- **年 / venue**: 2026 / arXiv [cs.AI], arXiv:2609.35741v1
- **リンク**: https://arxiv.org/abs/2609.35741

## 落合陽一フォーマット

- **ひとことでいうと**: エージェントの行動そのものではなく、自分の試行を振り返って説明した文章だけで追加学習するROFTを提案し、SWE-bench上でRLなしに性能を改善した論文。
- **先行研究と比べてどこがすごい？**: 報酬、verifier、外部教師、行動列の教師信号を使わず、自己生成したretrospectionへのnext-token predictionだけで学習する点がシンプル。Qwen3.5-4Bで、20更新後のROFTはSWE-bench Verified 49.2%、Pro 26.8%を達成し、比較対象GRPOの48.0%、25.3%を上回ったと報告している。訓練時間もGRPOより短い。
- **技術や手法の肝はどこ？**: タスク、行動、観測、テスト結果をコンテキストとして与え、「重要な仮定・判断、根拠、修正、次回の適用条件」を自己説明させる。その説明トークンだけでfine-tuningし、次の試行では過去の説明をプロンプトに再入力しない。説明の学習結果を重みへ内在化させ、行動へ転移させる設計。
- **どうやって有効だと検証した？**: Qwen3.5-4Bを用い、SWE-rebench-767でオンライン学習し、SWE-bench VerifiedとSWE-bench Proで評価。成功・失敗が混在する問題群でGRPOと比較したほか、64回の初期試行がすべて失敗したタスクでも単一タスク学習を実施した。さらに、正しい行動と誤った行動への尤度変化、効率重視の振り返りによる試行長の変化、各種ablationを分析した。
- **議論はある？**: 実験は主にソフトウェア工学タスクとQwen3.5系に限定され、他のモデル・領域への一般化はメタデータからは不明。ROFTは約20更新で性能が飽和し、振り返りの反復化や情報量低下が原因と推測されている。自己生成の説明が誤っていても学習対象になるため、誤った自己解釈の固定化も懸念される。論文本文中にはSWE-bench ProのROFT値について26.8%と29.0%の記載が混在しており、原表・実験ログでの確認が必要。
- **次に読む/試すなら**:
  1. Appendix B・Dのプロンプトとデータ処理を使い、失敗ログだけでretrospection fine-tuningを再現する。
  2. 同一タスクで、行動loss、retrospection loss、両者併用を比較する。
  3. 自己批評の正確性と、説明が実際の次行動を改善した割合を別々に測定する。
- **キーワード**: `retrospection reinforcement`, `self-reflection`, `agentic model`, `ROFT`, `SWE-bench`, `RL-free fine-tuning`

## 気になったこと

- retroscpectionの品質を独立した検証器なしでどう担保するのか。
- 説明トークンだけの学習で、なぜ正しい行動へのcredit assignmentが生じるのか。
- 26.8%と29.0%のSWE-bench Pro結果の食い違いは、評価条件やcheckpointの違いなのか。
- 振り返りが反復化して飽和する場合、データ選択や経験の多様化で改善できるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [light2026-tb-shockingly-simple-self-retrospection-improves-agentic-model-5091764d.md](../../chat/2026-10-01/light2026-tb-shockingly-simple-self-retrospection-improves-agentic-model-5091764d.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
