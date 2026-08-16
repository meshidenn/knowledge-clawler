# Chat Prompt 2026-08-17

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Training {AI} scientists to replicate research

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-17 - Training AI Scientists to Replicate Research

## 基本情報

- **タイトル**: Training AI Scientists to Replicate Research
- **著者**: Damon Falck, Samer Sabri, Anja Surina, Thom Foster, Anya Sims, Sam Devlin, Dylan Rogers, Tantum Collins, Kaloyan Aleksiev, Louis Kirsch, Edward Hughes
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2608.13331v1](https://arxiv.org/abs/2608.13331v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 論文の欠落した実験図を再現するタスクでAIエージェントをRL学習し、コーディングエージェントを使役してより科学的に追試する27Bモデル「Faraday」を作った。
- **先行研究と比べてどこがすごい？**: 正解が固定されたベンチマークや複雑なマルチエージェント・ハーネスではなく、論文追試という曖昧な課題を、タスク別ルーブリックで評価・学習する。保持アウトのAI-for-science課題でClaude Opus 4.8とGPT-5.5を平均で上回り、テスト課題ではClaude比6%、Codex比8%の改善を報告する。
- **技術や手法の肝はどこ？**: 100本の論文から310件の図再現課題「Replica」を自動生成し、元図を伏せたPDF・60分・H200 GPUの一部という制約下で追試させる。Claude Opus 4.7が論文ごとの採点ルーブリックを生成し、Codex GPT-5.5 judgeが図の類似性、主張の再現、実験実装、計算資源の使い方、科学的誠実性を評価する。3回のjudge評価の平均とターン単位のcredit assignmentを使い、GRPOでQwen3.6-27Bをpost-trainingする。
- **どうやって有効だと検証した？**: 学習用242件・保持アウト68件で、各エージェントを8 rolloutずつ評価した。ルーブリックjudgeは人間評価との順位相関がベースラインjudgeより高く、judge間の一貫性も高いと報告する。Faradayは分布内の73%、分布外の60%の課題でClaude/Codexを上回り、人手比較でも強いFaraday rollout 41件中29件が両ベースラインより好まれた。
- **議論はある？**: 評価の中心がLLM judgeであり、人間との一致は完全ではない。人手比較はFaraday有利とjudgeが判定した事例に偏っており、平均的な人間選好までは示していない。反実仮想の「innovation」評価は20件中19件でFaraday優位だが、その課題に対するjudgeの妥当性は未検証。追試失敗が原論文の誤りを意味しない点も著者が明記している。
- **次に読む/試すなら**:
  1. Appendixのルーブリック、システムプロンプト、GRPOのablationを確認する。
  2. 自分の分野の論文で、図を隠した小規模追試タスクと人手評価を作る。
  3. LLM judgeの評価を、ランダム抽出した課題で専門家評価と再校正する。
- **キーワード**: `AI Scientist`, `paper replication`, `RL post-training`, `GRPO`, `LLM judge`, `coding agent as a tool`

## 気になったこと

- 100論文・310課題というデータ規模で、分野・発表年・学習データ汚染への頑健性がどこまで担保されているか。
- 元図を見られるjudgeが、見栄えのよい再現を過大評価せず、実験機構の忠実さを安定して判定できるか。
- 外側の27Bモデルが内側の強力なコーディングモデルを使役する効果が、ツールモデルや計算予算の変更後も再現するか。
- 実論文の追試支援に使うなら、失敗を「原研究の問題」と誤解しない運用・人間レビューが必要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
