# Chat Prompt 2026-09-01

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Why pretraining fails to share cross-lingual knowledge

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-01 - Why pretraining fails to share cross-lingual knowledge

## 基本情報

- **タイトル**: Why pretraining fails to share cross-lingual knowledge
- **著者**: Adam Gaber, Uriel Dolev, Elisabeth Fittschen, Bobby Cheng, Yuval Marton, Leshem Choshen
- **年 / venue**: 2026 / alphaXiv
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: 多言語LLMの知識転移が弱い主因は、言語ごとに分断されたtoken spaceにあり、翻訳を介して共有token spaceへ写すだけでも改善できることを示した研究。
- **先行研究と比べてどこがすごい？**: 多言語知識転移の弱さを観測するだけでなく、同一言語を語彙だけ分離した二重コピーとして事前学習する統制実験で、tokenの非共有そのものが知識の隔離を生むことを切り分けた。翻訳による共有token space化で、native-language learning efficiencyを最大12.6%、ベースラインの14倍まで回復したと報告する。
- **技術や手法の肝はどこ？**: 同じテキスト・同じtoken分割を用いながらtoken ID空間だけを互いに分離し、意味やデータ分布ではなく語彙表現の分断が転移を阻害するかを検証する。改善策は単語単位の翻訳で言語を共通のtoken空間へ対応付けるという単純な設計である。
- **どうやって有効だと検証した？**: 360Mおよび7BパラメータのLLMを事前学習し、標準的な介入後も残るクロスリンガル知識一般化の弱さを評価した。詳細な評価タスク、データセット、比較条件はPDF本文がないためメタデータからは不明。
- **議論はある？**: 単語単位翻訳が形態論的に豊かな言語、語順が大きく異なる言語、低資源言語にも同程度に効くかは不明。共有token spaceの改善が真の概念共有なのか、単なる表層的な語彙整合の効果なのかも追加検証が必要である。PDF本文が未取得のため、再現設定や数値の詳細は確認できない。
- **次に読む/試すなら**:
  1. 共有語彙・共有subword・翻訳対応語彙を比較する最小の二言語事前学習実験を行う。
  2. token共有率と知識転移性能の関係を連続的に測定する。
  3. transliteration、辞書対応、埋め込み整列など翻訳以外の共有空間化手法と比較する。
- **キーワード**: `cross-lingual knowledge transfer`, `multilingual LLM`, `token space`, `pretraining`, `tokenization`

## 気になったこと

- 報告された「native-language learning efficiency」の定義、評価指標、12.6%の分母を確認したい。
- 単語単位翻訳がtokenizer以前の処理なのか、学習データ変換なのか、推論時にも必要なのかを確認したい。
- 言語間で文字体系や形態的類似性が異なる場合にも、token space分離の効果が支配的かを検証したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
