# Paperpile Brief 2026-08-18 - DarwinX: Evolving Agent Harnesses Through Natural Selection

## 基本情報

- **タイトル**: DarwinX: Evolving Agent Harnesses Through Natural Selection
- **著者**: Yifan Zhang, Yutong Dai, Juntao Tan, Luyu Yang, Rishi Mullur, Thai Hoang, Zhiyuan Hu, James Zhu, Phil Mui, Silvio Savarese, Ran Xu, Zeyuan Chen
- **年 / venue**: 2026 / arXiv [cs.NE]
- **リンク**: [arXiv:2608.07545](https://arxiv.org/abs/2608.07545)

## 落合陽一フォーマット

- **ひとことでいうと**: LLM本体の重みを更新せず、プロンプト・ツール・スキル・制御フローからなる「agent harness」を集団進化させ、能力を継続的に高める手法 DarwinX。
- **先行研究と比べてどこがすごい？**: 単一路線の自己改善が陥る経路依存性や、あるタスクの改善が別タスクを壊す問題に対し、複数系統をアーカイブし、補完的な系統を再結合する。改善は「新しい課題を解け、既存の成功を許容範囲以上に失わない」という preserve-and-extend 契約で選ぶ。
- **技術や手法の肝はどこ？**: 各 harness 変種をベンチマーク固有の verifier で `avg@k` 評価し、改善量と回帰量から採択する。探索時は有望な小編集を広めに残し、再評価・preservation probe で厳密に確認する二段階設計。失敗分析、教師デモ、自己ロールアウト比較を共通の harness 編集インターフェースへ変換する。
- **どうやって有効だと検証した？**: 凍結した同一モデルで、Terminal-Bench 2.1 は 75.5%→83.2%、WebArena-Infinity の実タスクでは監査済み pass@1 が 43.5%→93.0%。TerminalWorld の分離済み41タスクでは 28件（68.3%）を解き、Terminal-Bench 2.1 で進化させた harness を変更せず SWE-bench Verified に移すと 84.2%（421/500）だった。WebArena では不正な軌跡も293件→17件に減った。
- **議論はある？**: 各要素の因果的寄与は未分離で、アーカイブ・親選択・再結合・推論計算量のどれが効いたかは確定していない。TerminalWorld は41件と小さく、25/41対28/41の比較は統計的に決定的ではない（McNemar p=0.45）。SWE-bench は一方向の転移のみで、in-domain進化の主張はしていない。
- **次に読む/試すなら**:
  1. 単一路線探索、アーカイブのみ、再結合ありを同一予算で比較するアブレーションを設計する。
  2. 最小構成として、スキル文書・system promptだけを編集対象にした preserve-and-extend ループを実装する。
  3. verifier のノイズ下での採択閾値と再評価回数が、回帰防止に与える影響を測る。
- **キーワード**: `LLM agent`, `agent harness`, `self-improvement`, `evolutionary search`, `population-based search`, `verification`

## 気になったこと

- 「追加的編集」とされる harness のマージが、実際にはプロンプトや制御フローの競合をどう解決するのか。
- 検証用 verifier 自体に偏り・抜け穴がある場合、preserve-and-extend がその偏りを強化しないか。
- WebArena-Infinity の大幅改善に、harness進化と実行時ガード・監査設計がそれぞれどの程度寄与したか。
- より小規模・オープンなモデルとツール群でも、同程度の再結合効果が再現するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhang2026-rs-darwinx-evolving-agent-harnesses-through-natural-selection-7053239c.md](../../chat/2026-08-18/zhang2026-rs-darwinx-evolving-agent-harnesses-through-natural-selection-7053239c.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
