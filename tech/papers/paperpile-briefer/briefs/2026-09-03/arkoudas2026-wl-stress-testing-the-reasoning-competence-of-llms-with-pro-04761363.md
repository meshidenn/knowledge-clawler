# Paperpile Brief 2026-09-03 - Stress-Testing the Reasoning Competence of LLMs With Proofs Under Minimal Formalism

## 基本情報

- **タイトル**: Stress-Testing the Reasoning Competence of LLMs With Proofs Under Minimal Formalism
- **著者**: Konstantine Arkoudas, Serafim Batzoglou
- **年 / venue**: 2026 / arXiv [cs.LO]（2025年 EMNLP Findings 論文の拡張技術報告）
- **リンク**: [arXiv:2605.12524](https://arxiv.org/abs/2605.12524)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMを最終解答の正誤ではなく、機械検証可能な「証明」そのものによって評価するベンチマーク `PROOFGRID` を提案した論文。
- **先行研究と比べてどこがすごい？**: 数学・推論ベンチマークで見落とされがちな「正答だが推論は誤り」を切り分ける。最小限の形式言語 NDL を使い、人手やLLM審判に依存せず、証明のどこで推論が破綻したかを再現可能に測れる。
- **技術や手法の肝はどこ？**: 証明生成・証明検査・証明マスキング・欠損ステップ補完の15タスクを設計し、軽微な表記ゆれを許容しつつ最初の本質的エラーを特定する計測付き proof checker を構築した。さらに、生成した証明と孤立した推論判断の整合性を測る **Epistemic Stability Index（ESI）**、IRT・Wright map・Fisher情報量に基づく識別力分析を導入する。
- **どうやって有効だと検証した？**: 2024年後半以降の公開・非公開を含む24モデルを全タスクで評価した。基礎タスクでは最前線モデルが高性能だが、グローバルな組合せ推論や低レベルの証明合成を要する難問は未解決だと報告する。モデル間の性能差やエラー種別も分析した。
- **議論はある？**: NDLや命題論理中心の評価が、実世界の数学・科学推論へどこまで一般化するかは未検証である。また「外部ソルバに容易に委譲できない」ことを設計目標にする一方、プロンプト・推論予算・ツール利用の条件で結果がどの程度変わるかはPDF抽出範囲からは不明。
- **次に読む/試すなら**:
  - PROOFGRIDのタスクと checker を入手し、自分の利用モデルで再評価する。
  - 正答率と証明妥当性・ESIを並べ、正答の根拠が安定しているか確認する。
  - 自分の領域の形式検証タスクに、proof masking／gap-filling を転用する。
- **キーワード**: `LLM reasoning`, `formal proof`, `benchmark`, `natural deduction`, `mechanical verification`, `item response theory`

## 気になったこと

- 難問での失敗は、証明計画の失敗と形式記法の実行ミスのどちらが主因か。
- ESIが低いモデルは、再プロンプト・自己検証・外部チェッカーでどこまで改善するか。
- NDLで測る流動性知能的な推論能力が、定理証明支援や科学的仮説検証の実務性能とどれほど相関するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [arkoudas2026-wl-stress-testing-the-reasoning-competence-of-llms-with-pro-04761363.md](../../chat/2026-09-03/arkoudas2026-wl-stress-testing-the-reasoning-competence-of-llms-with-pro-04761363.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
