# Paperpile Brief 2026-07-15 - Long-horizon-terminal-bench: Testing the limits of agents on long-horizon terminal tasks with dense reward-based grading

## 基本情報

- **タイトル**: Long-horizon-terminal-bench: Testing the limits of agents on long-horizon terminal tasks with dense reward-based grading
- **著者**: Zongxia Li, Zhongzhi Li, Yucheng Shi, Ruhan Wang, Junyao Yang, Zhichao Liu, Xiyang Wu, Anhao Li, Yue Yu, Ninghao Liu, Lichao Sun, Haotao Mi, Leowei Liang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.08964 / PDF: https://arxiv.org/pdf/2607.08964.pdf / Project: https://zli12321.github.io/LHTB/

## 落合陽一フォーマット

- **ひとことでいうと**: 長時間・多数ステップのterminal agent能力を、最終成否だけでなくsubtask単位のdense rewardで測るベンチマーク Long-Horizon-Terminal-Bench を提案した論文。
- **先行研究と比べてどこがすごい？**: Terminal-Bench系の短時間・binary gradingでは見えない「途中まで進んだが完了できない」状態を測れる点が主な差分。46タスク、9カテゴリにまたがり、実験再現、software engineering、multimodal analysis、interactive games、scientific computingなどを含む。17 frontier model評価では、最強のGrok 4.5でも `R >= 0.95` で28.3%、完全達成 `R = 1.0` で19.6%に留まり、長期実行がまだ強いボトルネックであることを示している。
- **技術や手法の肝はどこ？**: 各タスクをDocker/Harbor形式のterminal-only環境として用意し、自然言語指示、関連ファイル、ツール、oracleまたはsimulatorを含める。評価は最終状態に対して、意味のあるsubtask集合をbinary / continuous / episode-aggregating checkで採点し、重み付き正規化reward `R` を返す。public checkは低重み、hidden stress caseを高重みにして、表面的なhard-codeでは高得点を取りにくくしている。
- **どうやって有効だと検証した？**: GPT-5系、Grok、Gemini、DeepSeek、Qwen、Kimi、GLM、MiniMax、Doubao、Hy3など17モデルを46タスクで評価。平均で1タスクあたり9.79M tokens、239 episodes、88.9分、推定$10.8を消費。dense rewardにより、全runの6.4%だけが `R >= 0.95` でpassする一方、62.8%はpartial progressを持つこと、さらにnear-missやfalse finishをbinary評価より明確に分析できることを示した。
- **議論はある？**: 90分timeout下では未解決runの79%がtimeoutで、失敗の中心は局所的な実行ミスより「長期計画を完了に変換する能力」の不足とされる。一方で、task設計・hidden verifier・コスト見積もり・モデル名や価格の時点依存性には注意が必要。PDF抽出本文からは、人間専門家との直接比較や、各タスクの独立した外部妥当性評価の詳細は十分には確認できない。
- **次に読む/試すなら**: LHTBのproject pageとtask harnessを確認する。自分のagentに対してtimeout、early exit、near-missを分けてログ化する。既存評価をbinary pass/failだけでなくsubtask rewardに分解できるか試す。
- **キーワード**: `long-horizon agents`, `terminal benchmark`, `dense reward`, `partial credit`, `agent evaluation`, `self-verification`, `timeout`, `Harbor`, `Terminal-Bench`

## 気になったこと

- hidden verifierがどの程度「実務的な正しさ」を代表しているのか。
- dense rewardのsubtask設計に作成者バイアスが入り、モデルランキングを左右していないか。
- agent改善として、推論能力よりも状態管理、進捗推定、予算配分、final verification loopのどれが最も効くのか。
- Grok 4.5が高性能かつ比較的cost-efficientに見える理由が、model能力なのかharness適合なのかを切り分けたい。
- 自分のterminal agent評価でも、false finishを検出する停止判定ベンチを作れそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [li2026-mn-long-horizon-terminal-bench-testing-the-limits-of-agents-on-lo-ce51b811.md](../../chat/2026-07-15/li2026-mn-long-horizon-terminal-bench-testing-the-limits-of-agents-on-lo-ce51b811.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
