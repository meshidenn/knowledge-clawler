# Chat Prompt 2026-09-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {PILOT} in the loop: Live self-improvement for long-horizon agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-02 - PILOT in the Loop: Live Self-Improvement for Long-Horizon Agents

## 基本情報

- **タイトル**: PILOT in the Loop: Live Self-Improvement for Long-Horizon Agents
- **著者**: Yang Xiao, Yusong Sun, Haoyi Wu, Wenyang Hui, Wen Da, Zhaokai Luo, Mu Chuan, Yao Hu, Wenjie Li, Chengyue Jiang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.26530](https://arxiv.org/abs/2608.26530) / [PDF](https://arxiv.org/pdf/2608.26530)

## 落合陽一フォーマット

- **ひとことでいうと**: 長時間動くエージェントを、実行担当Workerと監督担当Supervisorに分離し、実行中に軌道修正しながら得た知見をスキル・メモリへ即時蓄積する「live self-improvement」基盤PILOTを提案した。
- **先行研究と比べてどこがすごい？**: 従来の反省・自己進化は実行終了後に学習するため失敗中のrunを救えない。PILOTは、別コンテキストのSupervisorが実行中Workerを`Steer`または`Abort`でき、同時に後続run向けのharnessを更新する。Terminal-Bench 2.0では比較harnessを最大9.8ポイント上回り、6条件中5条件で首位だった。
- **技術や手法の肝はどこ？**: 双方向のライブチャネルで、Workerは進捗通知・質問・結果を送信し、Supervisorは必要箇所の軌跡を確認して次ターンへの指示投入または中断を行う。モデル重みは固定し、成功手順・プロジェクト慣習・失敗パターンを永続的なskill libraryとmemoryへ保存することで、次のWorkerが更新済みharnessを利用する。
- **どうやって有効だと検証した？**: 固定backboneのGLM-5.1とKimi-K2.6で、Terminal-Bench 2.0、SWE-bench Multilingual、SWE-bench Proを評価した。自己改善設定ではTerminal-Bench 2.0を20反復し、PILOTは初期値からGLM-5.1で+14.6ポイント、Kimi-K2.6で+12.4ポイント改善。平均出力トークンは各42.9%、47.4%減り、100万出力トークン当たりの成功評価数は110.3%、134.0%向上した。
- **議論はある？**: 反復評価は高コストで、検証は3ベンチマーク・2つのopen-weight backboneに限られる。SupervisorとWorkerに同一モデルを使っており、異種モデルの組合せにおける性能・監督品質・コストのトレードオフは未検証。また、自己改善の保持可否はrun後の検証成功に依存するため、長期の知識品質や誤ったスキル蓄積への頑健性は追加検証が必要である。
- **次に読む/試すなら**:
  - Pi Agent Harness上で、通知・質問・結果と`Steer`・`Abort`を持つ最小Supervisor-Worker構成を再現する。
  - 同一タスク群を反復し、skill更新あり・なし、live steeringあり・なしのアブレーションを行う。
  - Supervisorをより小さい／強い別モデルに替え、品質とトークンコストを比較する。
- **キーワード**: `long-horizon agents`, `live self-improvement`, `supervisor-worker`, `agent harness`, `skill memory`

## 気になったこと

- Supervisorの介入頻度・介入内容をどのように最適化すれば、過干渉によるWorkerの探索阻害を避けられるか。
- 成功run由来のスキルのみを残す設計では、失敗から得られる一般的な失敗回避知識を十分に活かせるか。
- ベンチマーク反復で得たスキルが、未見の実務タスクへどの程度転移するかを確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
