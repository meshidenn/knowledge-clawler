# Paperpile Brief 2026-09-30 - RRSI: Regularized Recursive Self-Improvement of Agent Harnesses

## 基本情報

- **タイトル**: RRSI: Regularized Recursive Self-Improvement of Agent Harnesses
- **著者**: Peng Xia, Rujun Han, Zifeng Wang, Yanfei Chen, Yufan Zhuang, Yoonho Lee, Chengsong Huang, Han Yu, Zhongying CuiZhu, Yifei Ming, Huaxiu Yao, Burak Gokturk, Tomas Pfister, Chen-Yu Lee
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2609.24972

## 落合陽一フォーマット

- **ひとことでいうと**: エージェントのプロンプト、制御フロー、ツール、メモリなどの「harness」を自動進化させる際に、ベンチマークへの過学習を防ぐ正則化機構を導入した論文。
- **先行研究と比べてどこがすごい？**: 従来のharness evolutionは進化対象のベンチマークでは改善しても、未知タスクへの転移性能が低下しやすかった。RRSIは提案と選択の両方を制約し、最大14.1ポイントの進化対象上の改善、最大4.7ポイントのOOD改善を示した。非正則化手法よりpolicy tokenも約30%少ない。
- **技術や手法の肝はどこ？**: 主に6つの仕組みを組み合わせる。提案側では、初期は大きく後半は小さくするannealed update budget、過去の成功・失敗履歴を使うcredit assignment、未探索の構成要素を試すstructured explorationを使う。選択側では、ベンチマーク固有情報を弾くleakage critic、評価ノイズを考慮した性能下限、性能向上に見合わないtokenコストを拒否するcomplexity-aware acceptance、役に立たなくなった構成要素を削除するpruningを行う。
- **どうやって有効だと検証した？**: coding、agentic workspace、engineering designの3領域、8ベンチマークで評価した。Terminal-Bench 2.1上で進化したharnessはSWE-bench Verifiedでも1.8ポイント改善し、Harvey LAB、JobBench、GDPval、APEX-Agents、Frontier-Engなどの未見ベンチマークでも改善した。Meta-Harness、AHE、TTHE、HarnessXとの比較や、提案側・選択側正則化のablationも実施している。
- **議論はある？**: 進化対象の有限データを繰り返し利用するため、RRSI自身も評価信号やnoise band、各種正則化ハイパーパラメータに依存する。実験はfrozen backboneのharness evolutionに限定され、モデル重みを更新する自己改善や、より異なるagent architecture・tool ecosystem・長期進化への一般化は未検証。PDF抽出では数式や表のレイアウトが崩れている箇所があるため、細かな数値は原論文での確認が必要。
- **次に読む/試すなら**:
  1. `github.com/google-research/rrsi` の実装で、proposal regularizationとacceptance regularizationを個別に再現する。
  2. 自分のagent harnessに、評価ノイズ推定・変更履歴・tokenコスト制約を追加する。
  3. 進化対象と異なるタスクセットを必ず用意し、in-distribution性能ではなくtransfer性能で選択する。
- **キーワード**: `agent harness evolution`, `recursive self-improvement`, `regularization`, `out-of-distribution generalization`, `test-time optimization`

## 気になったこと

- leakage criticが「汎用的な改善」と「ベンチマーク固有の改善」をどの程度安定して区別できるか。
- LLM judgeを使うタスクでは、harnessが成果物ではなく評価者の好みに適応している可能性をどこまで排除できるか。
- tokenコストをcomplexityの代理指標にしているが、レイテンシ、ツール呼び出し回数、金銭的コストとの相関は十分か。
- どの正則化が、どのタスク領域・backbone・harness構成で効くのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [xia2026-eh-rrsi-regularized-recursive-self-improvement-of-agent-harnesse-9c229157.md](../../chat/2026-09-30/xia2026-eh-rrsi-regularized-recursive-self-improvement-of-agent-harnesse-9c229157.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
