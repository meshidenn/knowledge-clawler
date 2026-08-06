# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Are the financial reasoning from {LLMs} credible? A real world test over long-horizon statements

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - Are the financial reasoning from LLMs credible? A real world test over long-horizon statements

## 基本情報

- **タイトル**: Are the financial reasoning from {LLMs} credible? A real world test over long-horizon statements
- **著者**: Xinke Tong, Xuanming Zhang, Tianyi Tang, An Yang, Jiatu Hu, Guojie Lin, Zhenzhen Shi, Lingfeng Zeng, Boyu Yang, Bing Zhao, Hu Wei, Lin Qu, Dayiheng Liu
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.28661v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMが金融財務諸表を本当に構造的に推論できるのかを、長文の未切り出し財務諸表を使う新ベンチマーク `FININDICES` で検証した論文。
- **先行研究と比べてどこがすごい？**: 従来の金融ベンチマークは多肢選択、短い表、単発QAが中心だったが、この研究は最大32K tokensの実務的な財務諸表コンテキストで、単一指標計算と複数期間・複数指標の表生成を評価する。時間方向の累計解除、stock/flowの口径合わせ、中国会計基準に基づく勘定科目分類まで問う点が強い。
- **技術や手法の肝はどこ？**: 829社、384種類の金融指標、28報告期間からデータを合成し、財務諸表抽出、コンテキスト構築、指標アラインメント、QA生成を自動化している。さらに、隣接期間を混ぜる distractor や、必要情報を意図的に欠落させて `Insufficient information` を要求する adversarial trap を入れ、表面的な式当てでは解けないようにしている。
- **どうやって有効だと検証した？**: 640件の専門家検証済みテストセットで、一般LLMや金融特化モデルを評価している。PDF本文によると、式ヒントを外すと性能が大きく落ち、例として Gemini-3.1-Pro は table task で 70.70% から 38.22% に低下する。SFTでは zero-hint 条件で Single +8.54%、Table +3.82% の改善が報告されている。
- **議論はある？**: 主な限界は、財務推論の失敗を `Knowledge Bottleneck` と `Structural Bottleneck` に分けている点。前者は式や会計分類を暗記しているように見えても、ヒントなしでは脆いこと。後者は、単独指標なら解けるモデルでも、JSON/HTML/table形式で複数指標を同時に出すと推論能力が落ち、隣接列の誤取得や浅い算術ショートカットに流れること。データ生成は自動化されているため、専門家検証済みとはいえ、生成パイプライン由来の偏りや中国財務諸表・中国会計基準への依存は確認が必要。
- **次に読む/試すなら**: `FinIndices` データセットを取得して、自分が使うLLM/agentで式ヒントあり・なしを比較する。金融agentの中間処理に、期間・口径・単位の検証ステップを明示的に入れる。表生成タスクを単一セル推論に分解した場合と、一括生成した場合の精度差を測る。
- **キーワード**: `financial reasoning`, `LLM benchmark`, `FinIndices`, `long-context`, `table reasoning`, `temporal reasoning`, `caliber alignment`, `SFT`

## 気になったこと

- `FININDICES` が中国会計基準に強く寄っている場合、US GAAP / IFRS / 日本基準で同じボトルネックがどの程度再現するか。
- Table-Indexでの性能低下は、モデル能力の問題なのか、出力形式制約を強く課しすぎたことによる decoding 問題なのか。
- SFTで改善したとあるが、未知企業・未知指標・別会計基準への汎化性能は本文だけでは十分に断定できない。
- 実務投入するなら、LLM単体よりも、式ライブラリ、勘定科目マッピング、期間変換、単位変換を外部モジュール化したほうが堅そう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
