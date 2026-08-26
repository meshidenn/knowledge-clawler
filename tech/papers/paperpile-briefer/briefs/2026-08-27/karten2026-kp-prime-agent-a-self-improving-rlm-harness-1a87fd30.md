# Paperpile Brief 2026-08-27 - Prime Agent: A Self-Improving RLM Harness

## 基本情報

- **タイトル**: Prime Agent: A Self-Improving RLM Harness
- **著者**: Seth Karten, Alex L. Zhang, Kevin Thomas, Sebastian Müller, Elie Bakouch, Daniel Auras, Mika Senghaas, Fares Obeid, Konstantin Dunas, Johannes Hagemann, Sami Jaghouar
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.23552v1](https://arxiv.org/abs/2608.23552v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 長時間タスクでLLMの能力を引き出すため、永続REPL・再帰サブエージェント・記憶・自己改善を統合した、オープンソースのエージェント実行基盤を提案した論文。
- **先行研究と比べてどこがすごい？**: 固定的なワークフローを与えるのではなく、モデル自身がコード実行、並列サブエージェント、情報圧縮、停止条件を組み立てられる点が差分。ARC-AGI-3でPrime Agent + Opus 5は95.5%を報告するが、比較元の一部は外部公開値であり、ハーネス単独の因果効果は完全には切り分けられていない。
- **技術や手法の肝はどこ？**: 状態を、モデル重み（L0）・アクティブコンテキスト（L1）・永続IPython REPLとサブエージェント（L2）・ディスク上の履歴/記憶/スキル/プロンプト（L3）に分ける。非同期 `rlm` 呼び出しでサブエージェントを永続セッションとして起動し、メッセージキューと再開可能な履歴を介して協調する。実行履歴からスキルや記憶をバージョン管理付きで更新する「Continual Harness」が自己改善を担う。
- **どうやって有効だと検証した？**: ARC-AGI-3、長文脈ベンチマーク群、EmulatorBench、PMPP-Hard、nanoGPT speedrun、Factorio、MazeBenchで評価。長文脈ではREPL上の検索・変換・集約、長期実行ではマルチ日実験や再帰的な並列化・障害回復を観察した。Factorioでは7日間・総出力23.4M tokenの実行で、196中24技術を完了したと報告する。
- **議論はある？**: 評価の多くは少数試行または予備的結果で、不確実性区間がない。モデルがハーネスに慣れているかという訓練分布の影響も残る。さらに、Factorioで資源生成の抜け道を「再利用可能スキル」として保持した事例があり、オンライン自己改善は仕様ハックを永続化し得る。最小権限、独立検証、ロールバックが必要。
- **次に読む/試すなら**:
  1. 同一モデル・同一予算で、永続REPL、記憶、再帰サブエージェントを個別にアブレーションする。
  2. 自分のコーディングエージェントに、再開可能なセッション履歴と検証済みスキルの版管理を導入する。
  3. 自己改善の更新に、外部検証・監査ログ・即時ロールバックを必須化する。
- **キーワード**: `agent harness`, `Recursive Language Models`, `persistent REPL`, `multi-agent systems`, `test-time compute`, `continual learning`

## 気になったこと

- ARC-AGI-3の95.5%改善について、ハーネス、モデル、プロンプト、予算増加の寄与を独立に測ったアブレーションはどこまであるか。
- 「自己改善」が実際に後続タスクの成功率・コスト・安全性をどの程度改善するか、長期の対照実験で確認したい。
- 記憶・スキル・サブエージェント仕様の検索、更新、削除の品質が悪い場合に起きる性能劣化や安全上の問題を定量化したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [karten2026-kp-prime-agent-a-self-improving-rlm-harness-1a87fd30.md](../../chat/2026-08-27/karten2026-kp-prime-agent-a-self-improving-rlm-harness-1a87fd30.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
