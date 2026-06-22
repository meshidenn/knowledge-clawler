# Paperpile Brief 2026-06-23 - LegalHalluLens: Typed hallucination auditing and calibrated multi-agent debate for trustworthy legal AI

## 基本情報

- **タイトル**: LegalHalluLens: Typed hallucination auditing and calibrated multi-agent debate for trustworthy legal AI
- **著者**: Lalit Yadav, Akshaj Gurugubelli
- **年 / venue**: 2026 / arXiv [cs.AI], AIWILD at ICML 2026
- **リンク**: https://arxiv.org/pdf/2606.18021

## 落合陽一フォーマット

- **ひとことでいうと**: 法務AIの幻覚を、単一の平均エラー率ではなく「数値・時制・義務/権利・事実」の型別と、過剰主張か見落としかという方向性で監査し、その診断を使って多エージェント討論パイプラインを校正する論文。
- **先行研究と比べてどこがすごい？**: 既存の法務LLM評価は幻覚率や法的推論精度をまとめて測りがちだが、本論文は契約抽出において失敗タイプごとの偏りを可視化する。さらに Risk Direction Index, RDI により、同じ約52%の幻覚率でも「義務を過剰に発明するモデル」と「義務を見落とすモデル」を分けて比較できる点が新しい。
- **技術や手法の肝はどこ？**: CUADの契約条項を4カテゴリに分け、検出誤りと内容矛盾を分離して測る。RDIは `extra_condition` と `missing_condition` の比率差から、発明寄りか省略寄りかを符号付きスカラーで表す。さらに Skeptic, Supporter, Re-extractor, Arbiter, Verifier, Judge の6ロールからなる討論パイプラインを作り、型別の失敗傾向に応じて質問や追加/削除ゲートを非対称に調整する。
- **どうやって有効だと検証した？**: CUAD v1.0の510契約、41条項タイプ、合計249,252 clause-level instancesで4モデルを3回評価。数値・義務系が時制系より約38〜40ポイント高く失敗する型別ギャップを確認した。別途120契約のサブセットで gemma-4-26B-A4B ベースの討論パイプラインを評価し、fabricated detections を45%削減し、複数の重み付けランキングで商用APIに近い、または上回る結果を示した。
- **議論はある？**: 評価対象はCUAD風の英語US商業契約に限られる。HalTP, HalGen, RDIはいずれも gemini-2.5-flash のLLM judgeに依存しており、人間専門家による検証は今後の課題。討論パイプラインも1つのバックボーンと120契約サブセットでの評価なので、一般化には追加実験が必要。最良構成でも検出条項内容の矛盾率は58.6%と高く、自律運用ではなく人間レビューの補助として位置付けるべき。
- **次に読む/試すなら**: CUAD上で自分の契約抽出プロンプトに型別HalTPとRDIを追加する / Judge出力を人手でサンプリング検証する / LegalHalluLensのGitHub実装とプロンプトを確認して最小再現実験を作る
- **キーワード**: `legal AI`, `hallucination auditing`, `CUAD`, `Risk Direction Index`, `multi-agent debate`, `contract extraction`

## 気になったこと

- RDIは方向性の比較には有用だが、法的リスクの実害をどこまで表すかは別問題に見える。
- LLM judge依存の評価で、特に obligation/scope/missing condition のラベルがどれくらい安定するかを確認したい。
- 討論パイプラインの改善が「討論」由来なのか、「型別ゲートと検証ルール」由来なのかを切り分ける ablation が重要。
- 日本法・日本語契約・非CUAD条項に移したとき、4カテゴリ分類がそのまま使えるかを検証したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yadav2026-ll-legalhallulens-typed-hallucination-auditing-and-calibrated-df00b669.md](../../chat/2026-06-23/yadav2026-ll-legalhallulens-typed-hallucination-auditing-and-calibrated-df00b669.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
