# Paperpile Brief 2026-09-07 - OfficeQA Pro: An enterprise benchmark for end-to-end grounded reasoning

## 基本情報

- **タイトル**: OfficeQA Pro: An enterprise benchmark for end-to-end grounded reasoning
- **著者**: Krista Opsahl-Ong, Arnav Singhvi, Jasmine Collins, Ivan Zhou, Cindy Wang, Ashutosh Baheti, Owen Oertell, Jacob Portes, Sam Havens, Erich Elsen, Michael Bendersky, Matei Zaharia, Xing Chen
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2603.08655](https://arxiv.org/abs/2603.08655) / [コード](https://github.com/databricks/officeqa)

## 落合陽一フォーマット

- **ひとことでいうと**: 大規模で雑多な企業文書を検索・読解・計算して正答する「grounded reasoning」を、米国財務省の約100年分の資料で測るベンチマーク。
- **先行研究と比べてどこがすごい？**: 長文QAや金融QAの一部能力ではなく、PDF解析・検索・表の読解・複数資料をまたぐ定量分析までを一気通貫で測る。89,000ページ・2,600万超の数値から成る現実的なコーパスで、厳密な自動採点を可能にした点が新しい。
- **技術や手法の肝はどこ？**: 133問のProセットは、単なる知識想起で解ける問題を除外し、複数文書の探索、改訂値の照合、表の解釈、回帰などの分析を必要とするよう設計されている。構造化文書表現（`ai_parse_document`）を与えると、PDFを直接扱うより平均で16.1%の相対性能向上が得られた。
- **どうやって有効だと検証した？**: Claude Opus 4.6、GPT-5.4、Gemini 3.1 Pro Previewを各社のエージェント実装で評価し、パーサ、表形式、検索戦略、test-time scalingをアブレーションした。全文書を与えた場合でも最新エージェントの平均正答率は34.1%で、最強条件でも48.1%、構造化解析後で最大56.4%にとどまる。人手アノテータとの速度・精度比較も行っている。
- **議論はある？**: 財務省資料という単一ドメインへの偏りがあり、他の企業データへどこまで一般化するかは未検証。問題作成時点のモデルで難度フィルタをしているため、将来モデルのパラメトリック知識による汚染も起こりうる。構造化パースへの依存が大きく、パーサ誤りが検索・計算へ連鎖する。PDF全文条件では平均回答時間も23.6分と実運用には重い。
- **次に読む/試すなら**:
  - 公開コードで、PDF入力と構造化入力の精度・レイテンシ差を再現する。
  - revision-aware retrievalと表のHTML表現を組み合わせ、失敗の主因が検索・抽出・計算のどこかを分解する。
  - 自分の業務文書で、単一正解かつ自動採点可能な小規模版OfficeQAを作る。
- **キーワード**: `grounded reasoning`, `enterprise benchmark`, `document parsing`, `agent evaluation`, `retrieval`, `table reasoning`

## 気になったこと

- パーサ選択だけで最大22ポイントの精度差が出るという結果は、LLM本体より文書前処理が支配的な局面を示す。どのレイアウト・OCR誤りが最も下流性能を壊すか確認したい。
- 22%の問題は外部Web検索も要するため、文書内グラウンディングと外部事実の信頼性・版管理をどう両立させるかが重要。
- exact match中心の評価は金融業務には妥当だが、途中根拠の引用正確性や監査可能性を別途測る必要がある。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [opsahl-ong2026-sh-officeqa-pro-an-enterprise-benchmark-for-end-to-end-gr-a15026ff.md](../../chat/2026-09-07/opsahl-ong2026-sh-officeqa-pro-an-enterprise-benchmark-for-end-to-end-gr-a15026ff.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
