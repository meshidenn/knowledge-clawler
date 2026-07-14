# Paperpile Brief 2026-07-15 - UniClawBench: A universal benchmark for proactive agents on real-world tasks

## 基本情報

- **タイトル**: UniClawBench: A universal benchmark for proactive agents on real-world tasks
- **著者**: Zhekai Chen, Chengqi Duan, Kaiyue Sun, Bohao Li, Yuqing Wang, Manyuan Zhang, Xihui Liu
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: arXiv:2607.08768 / https://arxiv.org/pdf/2607.08768 / https://github.com/HKU-MMLab/UniClawBench

## 落合陽一フォーマット

- **ひとことでいうと**: 実世界環境で動くproactive agentを、能力別・マルチターン・閉ループで評価するベンチマークUniClawBenchを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のWebArenaやOSWorld系のようなsandboxed/static/single-turn評価ではなく、live Docker環境、実ブラウザ、ローカルファイル、GUIアプリを使う。さらに「office」「research」のようなシナリオ分類ではなく、Skill Usage、Exploration、Long-Context Reasoning、Multimodal Understanding、Cross-Platform Coordinationの5能力に分解して失敗原因を見やすくしている。
- **技術や手法の肝はどこ？**: executor agent、hidden supervisor agent、user simulator agentの3役閉ループ評価。supervisorだけが隠しrubricとground truthを見て細粒度checkpointで評価し、user simulatorには粗い進捗信号と可視trajectory/artifactだけを渡すことで、自然なフィードバックを出しつつ評価基準の漏洩を防ぐ設計。
- **どうやって有効だと検証した？**: 英中バイリンガル400タスクを構築し、OpenClaw、EDICT、Nanobotなど複数agent framework上で、GPT-5.4、Claude Opus-4.8、Kimi-2.6などのモデルを比較。Pass RateとAverage Score、token使用量、supervision cycleごとの改善を測定している。本文では、framework選択がmodel選択以上に性能へ影響する場面があり、long-contextとmultimodalが主要なボトルネックだと報告している。
- **議論はある？**: タスク数は400件で手作業設計のため規模と偏りに限界がある。live環境評価は現実的だが不安定性を持つ。LLM-based supervisor/user simulatorによる評価バイアスも残る。PDF抽出本文からは、rubricの妥当性や人手評価との一致度の詳細までは十分に断定できない。
- **次に読む/試すなら**: UniClawBenchのGitHubを確認してtask YAMLとeval_rule.mdの実装形式を見る。OpenClaw/EDICT/Nanobotの差分を読み、framework設計がPRとASにどう効くか整理する。自分のagentに近いタスクを1つ選び、hidden checkpoint方式で最小評価を再現する。
- **キーワード**: `proactive agents`, `agent benchmark`, `closed-loop evaluation`, `real-world tasks`, `multimodal agents`, `long-context reasoning`, `cross-platform coordination`

## 気になったこと

- hidden supervisorの評価がどの程度安定しているか、同一trajectoryに対するjudge varianceを確認したい。
- live webやGUIを使う評価で、日次変動や外部サービス変更をどうversion管理しているかが重要。
- framework差がmodel差より大きいという主張は強いので、frameworkごとのtool interface、memory、trajectory保持、sub-agent handoff設計を比較したい。
- 400タスクのライセンス、再配布可能なfixture、外部サービス依存の範囲を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [chen2026-ef-uniclawbench-a-universal-benchmark-for-proactive-agents-on-r-0d6448cc.md](../../chat/2026-07-15/chen2026-ef-uniclawbench-a-universal-benchmark-for-proactive-agents-on-r-0d6448cc.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
