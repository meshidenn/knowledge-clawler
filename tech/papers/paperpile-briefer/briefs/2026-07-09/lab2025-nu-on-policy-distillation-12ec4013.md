# Paperpile Brief 2026-07-09 - On-Policy Distillation

## 基本情報

- **タイトル**: On-Policy Distillation
- **著者**: Thinking Machines Lab
- **年 / venue**: 2025 / Thinking Machines Lab
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: on-policy な dense supervision が distillation に有用である、という主張を示す論文または技術記事。PDF本文がないため、abstractベースの要約。
- **先行研究と比べてどこがすごい？**: メタデータからは不明。ただしタイトルとabstractからは、固定データ上のoff-policy distillationではなく、学習中の方策・モデル分布に沿った教師信号を密に与える点が差分らしい。
- **技術や手法の肝はどこ？**: on-policyに生成・訪問される状態や出力に対して、教師モデルから密な supervision を与える設計が中心と推測される。具体的な損失関数、サンプリング方法、教師・生徒モデル構成はメタデータからは不明。
- **どうやって有効だと検証した？**: メタデータからは不明。実験設定、比較対象、タスク、評価指標はPDF本文なしでは確認できない。
- **議論はある？**: on-policy distillation は分布ずれを減らせる可能性がある一方、教師推論コスト、探索分布への依存、初期方策が悪い場合の学習不安定性が論点になりそう。実際に論文内で議論されているかは不明。
- **次に読む/試すなら**: 本文またはWebページを取得して、手法の具体的なアルゴリズムを確認する / off-policy distillationとの比較実験があるか確認する / 小さなLLMまたは方策モデルでon-policy生成データへの教師ラベル付けを再現する
- **キーワード**: `on-policy distillation`, `dense supervision`, `knowledge distillation`, `policy learning`

## 気になったこと

- “on-policy” をどの粒度で定義しているのか。生成トークン列、RL環境の状態、対話履歴のどれに対するon-policyなのか。
- dense supervision が token-level logits なのか、step-wise value/reward なのか、trajectory-level feedback なのか。
- 教師モデルを毎ステップ呼ぶ場合の計算コストと、性能向上の費用対効果。
- off-policyデータやSFTデータに対する通常のdistillationと比べた実験結果。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [lab2025-nu-on-policy-distillation-12ec4013.md](../../chat/2026-07-09/lab2025-nu-on-policy-distillation-12ec4013.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
