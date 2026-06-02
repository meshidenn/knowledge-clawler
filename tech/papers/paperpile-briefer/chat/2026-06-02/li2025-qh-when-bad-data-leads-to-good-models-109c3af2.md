# Chat Prompt 2026-06-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- When bad data leads to good models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-02 - When bad data leads to good models

## 基本情報

- **タイトル**: When bad data leads to good models
- **著者**: Kenneth Li, Yida Chen, Fernanda Viégas, Martin Wattenberg
- **年 / venue**: 2025 / arXiv [cs.LG]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLM事前学習において「有害データは悪い」と単純に考えるのではなく、事後学習や制御まで含めると、有害データが毒性概念をより制御しやすい表現にする可能性を示した論文。
- **先行研究と比べてどこがすごい？**: データ品質を事前学習単体で評価せず、pre-training と post-training の共設計として捉え直している点が新しい。毒性データを増やすとベースモデルの生成毒性は上がるが、線形に分離しやすい表現になり、後段の detoxification でより良いトレードオフが得られると主張している。
- **技術や手法の肝はどこ？**: toy experiment でデータ構成が表現空間の特徴ジオメトリに与える影響を調べ、さらに clean/toxic data の比率を変えた Olmo-1B モデルを比較する。毒性概念がどれだけ絡み合わず、線形に扱えるかを見て、inference-time intervention などの制御手法と接続している。
- **どうやって有効だと検証した？**: clean/toxic data の比率を制御した Olmo-1B の事前学習実験を行い、Toxigen と Real Toxicity Prompts で評価している。detoxifying techniques として inference-time intervention (ITI) を適用し、生成毒性の低減と一般能力の維持のトレードオフを比較している。
- **議論はある？**: 有害データを増やすこと自体はベースモデルの毒性を上げるため、制御手法が失敗した場合のリスクがある。Olmo-1B と毒性タスク中心の結果が、より大規模なモデルや別種の有害性、実運用の安全性に一般化するかはメタデータからは不明。毒性データの収集・管理・公開に関する倫理的負荷も論点になる。
- **次に読む/試すなら**: Olmo-1B での toxic/clean 比率設計と評価設定を確認する。ITI の介入方向がどう学習・抽出されているかを読む。毒性以外の概念、例えばバイアスや機密情報漏洩にも同じ現象が出るかを探す。
- **キーワード**: `LLM pretraining`, `data quality`, `toxic data`, `detoxification`, `representation geometry`, `inference-time intervention`, `Olmo-1B`

## 気になったこと

- 「有害データが多いほど毒性概念が線形分離しやすい」という結果が、どの層・どの表現で観測されたのか。
- 一般能力の維持はどのベンチマークで測っているのか。
- 有害データを増やすことによる memorization や jailbreak 耐性への影響は検証されているのか。
- ITI 以外の post-training、例えば RLHF、DPO、SFT でも同じトレードオフ改善が出るのか。
- 「bad data may lead to good models」という主張が、毒性以外の安全性カテゴリにも拡張できるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
