# Chat Prompt 2026-07-31

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Recursive Harness Self-Improvement

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-31 - Recursive Harness Self-Improvement

## 基本情報

- **タイトル**: Recursive Harness Self-Improvement
- **著者**: Hyunin Lee, Jinglue Xu, Jeffrey Seely, Donghyun Lee, Matei Zaharia, Yujin Tang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: arXiv:2607.15524v1 / https://arxiv.org/abs/2607.15524v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agent の harness、つまり agent loop・役割・指示・agent 間通信・workflow を prompt レベルの対象として反復改善し、少ない更新回数で agent の実行品質とコスト効率を上げる RHI を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の prompt / workflow / harness search は複数候補を生成して比較する population-based search になりがちで、agent 実行と評価コストが重い。RHI は直前の harness との自己比較だけを使う trajectory-local な更新に落とし、1 iteration あたり新規 agent 実行1回・pairwise 評価1回で済む点が差分。実験では high reasoning + RHI が xhigh / max / ultracode などの test-time scaling baseline を上回るケースを示し、Opus-4.8 では ultracode 比で最大60%の推論コスト削減も報告している。
- **技術や手法の肝はどこ？**: harness を実行コードではなく prompt-level specification として表現し、agent candidates の role / instruction / contract、orchestrator-subagent workflow の hop、補助ルールを更新対象にする。各 iteration で現在の harness による出力と直前 harness による出力を LLM evaluator が pairwise 比較し、その preference history を LLM harness optimizer に渡して次の harness を作る。特に contract と hop を通じて「どの情報を agent 間で渡すか」をタスク特化に調整するのが中心。
- **どうやって有効だと検証した？**: quantitative finance、robotics、pharmaceutical ML の3領域、各10件、合計30件の synthetic open-ended ML research task で評価。各 task は complete code repository、`research_report.md`、`.png` 図、`metrics.json`、`index.json` などの成果物生成を要求する。評価は deliverable coverage、numerical/empirical rigor、reproducibility、presentation、engineering quality、task alignment を基準にした LLM-as-a-judge の pairwise comparison。Claude Sonnet 4.6、Opus 4.7、Opus 4.8 の high reasoning agent に RHI を適用し、xhigh / max / ultracode と比較している。
- **議論はある？**: 評価が synthetic task と LLM-as-a-judge に依存しており、実世界の研究開発タスクで同じ差が出るかは未検証。PDF本文上でも Opus-4.7 では output token 増加と性能向上が同時に起きており、性能差の原因を完全には分離できていない。RHI は同一モデル内の test-time scaling ceiling は上げるが、より強い base model への train-time scaling の代替にはならない。本文抽出は19ページ分までなので、後半の詳細な ablation や appendix の全情報はこの入力からは不完全。
- **次に読む/試すなら**: 1. Appendix C の harness optimizer prompt を確認して、自分の agent workflow に移植できる形か見る。2. 自分の定型 coding task で「現行 harness vs 1回改善 harness」の pairwise 評価だけを最小再現する。3. contract / hop だけを更新する ablation を作り、token 数ではなく cache read/write や実行コストが下がるか測る。
- **キーワード**: `recursive harness self-improvement`, `agent harness`, `prompt-level harness`, `multi-agent workflow`, `LLM-as-a-judge`, `test-time scaling`, `context management`, `pairwise preference`

## 気になったこと

- RHI の評価が LLM judge に寄っているので、人間評価や実行可能な unit/integration test と組み合わせた場合に同じ ranking になるか。
- harness optimizer に評価 prompt 自体は渡さない設計だが、preference history だけでどの程度評価基準に適応できるのか。
- 「contract による sparse information flow」が本当に因果要因なのか、単に良い prompt template を発見しているだけなのか。
- 実運用では1 task ごとに harness を最適化するコストと、再利用可能な domain-level harness を育てるコストの境界がどこにあるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
