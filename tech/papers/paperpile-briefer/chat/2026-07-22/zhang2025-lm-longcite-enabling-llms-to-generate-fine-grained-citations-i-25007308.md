# Chat Prompt 2026-07-22

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {LongCite}: Enabling {LLMs} to generate fine-grained citations in long-context {QA}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-22 - LongCite: Enabling LLMs to generate fine-grained citations in long-context QA

## 基本情報

- **タイトル**: LongCite: Enabling LLMs to Generate Fine-grained Citations in Long-Context QA
- **著者**: Jiajie Zhang, Yushi Bai, Xin Lv, Wanjun Gu, Danqing Liu, Minhao Zou, Shulin Cao, Lei Hou, Yuxiao Dong, Ling Feng, Juanzi Li
- **年 / venue**: 2025 / Findings of the Association for Computational Linguistics: ACL 2025
- **リンク**: PDF: https://aclanthology.org/2025.findings-acl.264.pdf / DOI・arXiv・URLはメタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: 長文コンテキストQAで、LLMが回答と文単位の細粒度引用を一度に生成できるようにするため、評価ベンチマーク、データ生成パイプライン、SFT済みモデルをまとめて提案した論文。
- **先行研究と比べてどこがすごい？**: RAGは文脈欠落で回答品質が落ちやすく、post-hoc引用付与は待ち時間とパイプライン複雑性が増える。本論文は全文コンテキストを読ませたまま、文単位引用をone-passで出す設計に寄せている。LongCite-8B/9BはLongBench-CiteでGPT-4oをcitation F1で上回り、引用粒度もより細かいと報告されている。
- **技術や手法の肝はどこ？**: CoF（Coarse to Fine）パイプライン。まず長文からSelf-InstructでQAを作り、回答を使って関連chunkを検索し、chunk-level引用を付与し、そのchunk内から支持文を抽出してsentence-level引用に変換する。最後に引用が少なすぎる事例を除外し、LongCite-45kという44,600件のSFTデータを作る。
- **どうやって有効だと検証した？**: LongBench/LongBench-Chat由来の1,000件でLongBench-Citeを構築し、correctness、citation recall/precision/F1、citation lengthで評価。GPT-4oをjudgeに使い、人手評価との一致も確認している。LongCite-8B/9B、既存のproprietary model、open-source model、RAG/post-hoc戦略、標準long-context SFTとの比較・ablationを実施。
- **議論はある？**: 評価もデータ構築も強いLLMに依存しており、特にGPT-4o judgeやGLM-4によるデータ生成のバイアスは残る。LongCiteでも誤った内容や誤引用はまだ起こり得る。PDF本文上では、GovReportで引用を出さずにsummaryだけ出す失敗例も報告されており、特殊トークン強制などの実装上の工夫が必要。
- **次に読む/試すなら**: LongBench-Citeの評価プロンプトを確認して自前QAに流用する。CoFで小規模な日本語長文QA引用データを作ってみる。LongCiteモデルが実際に公開されているか確認し、RAGなしのcitation付きlong-context QAで再現実験する。
- **キーワード**: `long-context QA`, `citation generation`, `sentence-level citation`, `SFT`, `LongBench-Cite`, `CoF`, `LongCite-45k`

## 気になったこと

- GPT-4o judgeによるcitation quality評価が、曖昧な代名詞や文脈依存表現をどの程度正しく扱えるか。
- CoFのデータ生成コストと、GLM-4以外のLLMで同じ品質が出るか。
- 文単位引用のためのsentence indexingが、PDF抽出崩れ、日本語文分割、表・数式・箇条書きでどれくらい壊れるか。
- citation付きSFTが回答正確性も上げるという主張は面白いが、引用タスク特有の「証拠探索の訓練」がどこまで一般化するか確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
