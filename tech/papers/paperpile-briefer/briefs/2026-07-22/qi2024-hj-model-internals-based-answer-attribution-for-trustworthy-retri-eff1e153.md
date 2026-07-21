# Paperpile Brief 2026-07-22 - Model Internals-based answer attribution for trustworthy retrieval-augmented generation

## 基本情報

- **タイトル**: Model Internals-based Answer Attribution for Trustworthy Retrieval-Augmented Generation
- **著者**: Jirui Qi, Gabriele Sarti, Raquel Fernández, Arianna Bisazza
- **年 / venue**: 2024 / EMNLP 2024（メタデータ上は arXiv [cs.CL]）
- **リンク**: https://aclanthology.org/2024.emnlp-main.347.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: RAGの回答が「どの検索文書に実際に依存して生成されたか」を、LLMの内部状態とsaliencyで推定して引用付けするMIRAGEを提案した論文。
- **先行研究と比べてどこがすごい？**: NLIベースの外部検証器やself-citation promptingは、もっともらしい出典を後付けするだけで、モデルが本当に使った文脈とはズレる可能性がある。MIRAGEは生成時の予測分布変化と勾配ベース帰属を見るため、回答生成プロセスへの忠実性を狙っている。XOR-AttriQAでは人手帰属と高い一致を示し、ELI5ではself-citationと同等以上の引用品質を出した。
- **技術や手法の肝はどこ？**: 2段階。まずCTIで、文脈あり/なしの次トークン予測分布のKL divergenceを見て「文脈に敏感な生成トークン」を検出する。次にCCIで、そのトークン生成に効いた入力文脈トークンをcontrastive feature attribution、主に勾配saliencyで特定する。最後にトークン単位の帰属を文書IDへ集約し、文単位・スパン単位の引用に変換する。
- **どうやって有効だと検証した？**: 多言語extractive QAのXOR-AttriQA派生セットで、人手のanswer attributionと比較。MIRAGE CAL Top 5%は平均86.7%一致、MIRAGE EX Top 5%は83.4%一致で、翻訳付きNLI baselineの84.2%と同等以上。長文QAのELI5ではZephyrβ 7BとLLaMA 2 7B Chatを使い、TRUEによるNLI評価でself-citationと比較。Zephyrβではself-citation F1 30.6に対しMIRAGE EX Top 5%が45.6、LLaMA 2では26.0に対し27.6。
- **議論はある？**: open-weightsな生成モデルの内部状態にアクセスできることが前提なので、完全black-box APIにはそのまま使えない。ELI5評価は人手ラベルではなくTRUE NLIモデルを近似評価器にしており、NLIの脆さが結果に混ざる。self-citation専用に最適化されたモデルとの比較は限定的。PDF抽出上、細かな表記や数式は一部崩れている可能性がある。
- **次に読む/試すなら**: MIRAGEのGitHub実装を確認する。自分のRAG pipelineで、文脈あり/なしのlogits差分と勾配帰属を最小実装する。ContextCiteやPEC OREと比較して、計算コストと帰属粒度の違いを見る。
- **キーワード**: `RAG`, `answer attribution`, `MIRAGE`, `model internals`, `saliency`, `self-citation`, `faithfulness`, `XOR-AttriQA`, `ELI5`

## 気になったこと

- closed modelやAPI-onlyモデルで同じ「内部状態ベースの忠実な引用」をどこまで近似できるか。
- CTI/CCIのthreshold選択が実運用でどれくらい安定するか。
- 引用の正しさだけでなく、「引用されなかったが必要だった文書」の検出をどう評価するか。
- RAGのretrieverが誤った文書を混ぜた場合、MIRAGEが「モデルが誤文書に依存した」ことをどれだけ検出できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [qi2024-hj-model-internals-based-answer-attribution-for-trustworthy-retri-eff1e153.md](../../chat/2026-07-22/qi2024-hj-model-internals-based-answer-attribution-for-trustworthy-retri-eff1e153.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
