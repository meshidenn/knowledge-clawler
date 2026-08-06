# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {SkillJack}: Persistent Skill Backdoors in Self-Evolving Agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - SkillJack: Persistent Skill Backdoors in Self-Evolving Agents

## 基本情報

- **タイトル**: SkillJack: Persistent Skill Backdoors in Self-Evolving Agents
- **著者**: Zonghao Ying, Xiangfan Wu, Huiyu Wu, Xing Zheng, Huangsheng Cheng, Xiaorong Shi, Jing Guo
- **年 / venue**: 2026 / arXiv [cs.CR]
- **リンク**: https://arxiv.org/abs/2608.03509 / PDF: https://arxiv.org/pdf/2608.03509.pdf / Code: https://github.com/Tencent/AI-Infra-Guard/research/skilljack

## 落合陽一フォーマット

- **ひとことでいうと**: 自己進化型LLM Agentが過去の経験を再利用可能な「skill」に変換する過程を悪用し、毒入り経験を永続的なバックドアskillとして残せることを示した論文。
- **先行研究と比べてどこがすごい？**: 既存のmemory poisoningやretrieval poisoningは、毒入り記録が後で検索されることに依存する。一方SkillJackは、経験そのものではなく、経験から抽出されたskillが別アーティファクトとして保存・ルーティングされる点を攻撃面として定式化している。元記録を削除しても派生skillが残る「persistence isolation」を実験的に示した点が新しい。
- **技術や手法の肝はどこ？**: 攻撃者はskill libraryを直接書き換えず、経験コーパスにpoisoned trajectoryを入れるだけにする。trajectoryは露骨な悪意ではなく、「backup」「archive」「diagnostic」「unified management」など正当そうな業務フレームで包み、抽出器が有用な手順として保存しやすい形にする。これにより、抽出後のskillでは悪意ある意図が中和された表現に変換され、検出器をすり抜けやすくなる。
- **どうやって有効だと検証した？**: SkillXとAnything2Skillの2系統で評価。AppWorld形式の150 trajectoriesを用い、65件の機能的に偽装したpoisoned trajectories、65件の直接的な悪意表現baseline、20件のclean trajectoriesを比較した。PDF本文によると、SkillXではLLM judgeの検出率がraw trajectoryでは98.5%だったのに対し、抽出skillでは11.4%まで下がった。攻撃成功率はSkillXで56.2%、Anything2Skillで89.2%。また、元のpoisoned recordを削除した後も80.0%のskill-mediated attackが残存した。
- **議論はある？**: 実験はDeepSeek-v4-flash単一モデルで、成功判定も主にrouting-levelのproxy detectorと小規模なcode-generation checkに依存している。実サービス上での実行確認ではない。また、防御評価は探索的で、より多様なagent設計、モデル、実データ、live execution環境での再現性は未検証。PDF抽出テキスト上では、細かい表や図の完全な読み取りには限界がある。
- **次に読む/試すなら**: 1. SkillX / Anything2Skillのskill抽出・保存・削除ライフサイクルを確認する。 2. 自分のagent実装で「元memory削除時に派生skillも失効するか」をテストする。 3. provenance付きskill registryと、抽出後skillに対するbehavior-aware検査を試作する。
- **キーワード**: `LLM agents`, `self-evolving agents`, `skill extraction`, `memory poisoning`, `backdoor`, `provenance`, `agent security`

## 気になったこと

- skillの安全性を「抽出前の経験」ではなく「抽出後の実行可能アーティファクト」で検査する仕組みが必要。
- provenance-awareなskill lifecycle管理、特に「このskillはどのtrajectoryから派生したか」を失わない設計が重要。
- sanitizeやsummarizeが安全化ではなく、むしろ悪意の表面だけを薄めるwhitewashingになり得る点は、RAGやlong-term memory設計にも波及しそう。
- ルーティングの誤発火、つまりbenign queryでpoisoned skillが選ばれる条件を追加で調べたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
