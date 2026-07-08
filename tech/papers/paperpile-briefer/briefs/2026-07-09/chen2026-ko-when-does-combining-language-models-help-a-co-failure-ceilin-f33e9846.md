# Paperpile Brief 2026-07-09 - When does combining language models help? A co-failure ceiling on routing, voting, and mixture-of-agents across 67 frontier models

## 基本情報

- **タイトル**: When does combining language models help? A co-failure ceiling on routing, voting, and mixture-of-agents across 67 frontier models
- **著者**: Josef Chen
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: 複数LLMをrouting、voting、cascade、mixture-of-agentsで組み合わせても、全モデルが同じクエリで同時に間違える「co-failure」の割合が性能上限を決める、という論文。
- **先行研究と比べてどこがすごい？**: 通常よく見る平均pairwise error correlationではなく、全モデル同時失敗率 `beta` を見るべきだと主張している点。67モデル・21プロバイダを対象に、組み合わせ手法の利得が「モデル数」ではなく「失敗のずれ」に依存することを示している。
- **技術や手法の肝はどこ？**: 任意の方策がメンバーモデルの回答のうち1つを出力するなら、精度は `1 - beta` を超えられない、という上限づけ。さらにClopper-Pearson boundで、routerなどを訓練する前に有限サンプルで最大利得の証明書を出す。
- **どうやって有効だと検証した？**: メタデータ上のabstractベースでは、67のfrontier model、21プロバイダ、open-ended数学、execution-graded code、GPQA-Diamondのfree-response化などで検証。数学では観測された `beta` がGaussian copula予測より大きく、コードでもco-failureが再発すると報告している。
- **議論はある？**: PDF本文がないため詳細な実験設定・データセット構成・モデル一覧・統計処理の妥当性はメタデータからは不明。abstract上では、checkable tasksでは強いquery-level routing signalがない限り、単一最良モデルを超えるのは難しいという制約が示唆される。
- **次に読む/試すなら**: 1. PDF本文を取得して `beta` の推定方法と評価データを確認する。2. 手元のLLM ensemble評価で「全モデル同時失敗率」を計算する。3. pairwise correlationだけでensemble設計していないか既存実験を見直す。
- **キーワード**: `co-failure`, `LLM ensemble`, `routing`, `voting`, `mixture-of-agents`, `error correlation`

## 気になったこと

- `beta` を実運用ログから安定に推定するには、どれくらいのサンプル数が必要か。
- 「強いquery-level routing signal」は具体的に何を指すのか。
- 生成タスクや主観評価タスクでも同じco-failure ceilingがどこまで成立するのか。
- Self-MoAとheterogeneous ensembleの比較条件がどれほど公平か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [chen2026-ko-when-does-combining-language-models-help-a-co-failure-ceilin-f33e9846.md](../../chat/2026-07-09/chen2026-ko-when-does-combining-language-models-help-a-co-failure-ceilin-f33e9846.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
