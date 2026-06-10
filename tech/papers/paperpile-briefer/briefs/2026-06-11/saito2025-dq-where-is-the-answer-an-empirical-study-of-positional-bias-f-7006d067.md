# Paperpile Brief 2026-06-11 - Where is the answer? An empirical study of positional bias for parametric knowledge extraction in language model

## 基本情報

- **タイトル**: Where is the answer? An empirical study of positional bias for parametric knowledge extraction in language model
- **著者**: Kuniaki Saito, Chen-Yu Lee, Kihyuk Sohn, Yoshitaka Ushiku
- **年 / venue**: 2025 / Proceedings of the 2025 Conference of the Nations of the Americas Chapter of the Association for Computational Linguistics: Human Language Technologies (Volume 1: Long Papers)
- **リンク**: DOI・arXiv・URLはメタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: 言語モデルからパラメトリック知識を取り出すとき、回答の「位置」によって性能や挙動が偏るかを実証的に調べた論文。PDF本文がないため、内容はタイトルとメタデータベース。
- **先行研究と比べてどこがすごい？**: メタデータからは不明。ただしタイトルからは、単に知識抽出性能を見るのではなく、回答候補や文脈内での位置バイアスに焦点を当てている点が差分と思われる。
- **技術や手法の肝はどこ？**: メタデータからは不明。おそらく、言語モデルに知識を答えさせるプロンプトや評価設定で、正解の配置位置を変えたときの出力変化を比較している可能性がある。
- **どうやって有効だと検証した？**: メタデータからは不明。実験対象モデル、データセット、評価指標、比較条件はPDF本文または公式ページ確認が必要。
- **議論はある？**: PDF本文がないため不明。位置バイアスの定義、プロンプト依存性、モデルサイズ依存性、データセット依存性、実運用での影響範囲が確認ポイント。
- **次に読む/試すなら**: 1. ACL Anthologyなどで本文を取得する。2. 正解位置を前方・中央・後方にずらす簡単なQA実験を手元のLLMで再現する。3. “positional bias”, “parametric knowledge”, “knowledge extraction” 周辺の関連研究を探す。
- **キーワード**: `positional bias`, `parametric knowledge`, `language model`, `knowledge extraction`, `empirical study`

## 気になったこと

- 「Where is the answer?」が、入力文脈内の正解位置なのか、選択肢順序なのか、生成系列内の回答位置なのかを確認したい。
- パラメトリック知識抽出における位置バイアスが、RAGやlong-context QAの位置バイアスと同じ現象として扱われているのかが気になる。
- どのモデル群で検証しているか、特にdecoder-only LLM、instruction-tuned model、closed model間で傾向が変わるかを見たい。
- 評価が知識そのものの有無と、プロンプト形式への感度をどの程度切り分けているかを確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [saito2025-dq-where-is-the-answer-an-empirical-study-of-positional-bias-f-7006d067.md](../../chat/2026-06-11/saito2025-dq-where-is-the-answer-an-empirical-study-of-positional-bias-f-7006d067.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
