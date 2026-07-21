# Chat Prompt 2026-07-22

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {LongCite}: Enabling {LLMs} to generate fine-grained citations in long-context {QA}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-22 - LongCite: Enabling LLMs to Generate Fine-grained Citations in Long-Context QA

## 基本情報

- **タイトル**: LongCite: Enabling LLMs to Generate Fine-grained Citations in Long-Context QA
- **著者**: Jiajie Zhang, Yushi Bai, Xin Lv, Wanjun Gu, Danqing Liu, Minhao Zou, Shulin Cao, Lei Hou, Yuxiao Dong, Ling Feng, Juanzi Li
- **年 / venue**: 2024 / arXiv [cs.CL]、PDF本文上では Findings of ACL 2025
- **リンク**: https://aclanthology.org/2025.findings-acl.264.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: 長文コンテキストQAで、LLMが回答と同時に文単位の細かい引用を生成できるようにするため、評価ベンチマーク、データ生成パイプライン、SFT済みモデルをまとめて提案した論文。
- **先行研究と比べてどこがすごい？**: RAGやpost-hoc引用付与は、文脈欠落による回答品質低下、複雑なパイプラインによる遅延、chunk単位の粗い引用が問題だった。本研究は全文を読ませたうえで、回答とsentence-level citationをone-passで出す設計にし、LongBench-CiteでLongCite-8Bが平均citation F1 72.0、LongCite-9Bが69.2を達成し、GPT-4oの65.6を上回った。引用長もGPT-4oの220 tokenに対し、LongCite-8Bは85、LongCite-9Bは91で、より細かい。
- **技術や手法の肝はどこ？**: CoF（Coarse to Fine）パイプライン。まずSelf-Instructで長文からQAを作り、回答文を使って関連chunkを検索し、LLMでchunk-level citationを付ける。その後、引用chunkを前後に拡張して完全な文に分割し、LLMに支持文のspanを抽出させ、sentence-level citationへ変換する。最後に、引用付きstatementが少なすぎるデータを除外する。この流れでLongCite-45kを構築し、GLM-4-9BとLlama-3.1-8BをSFTしてLongCite-9B/8Bを作る。
- **どうやって有効だと検証した？**: LongBenchとLongBench-Chat由来の1,000件からLongBench-Citeを作り、correctness、citation recall、citation precision、citation F1、citation lengthで評価した。GPT-4oをjudgeに使い、さらにLongBench-Chat上の150応答、1,064 statements、909 citationsを人手評価して、GPT-4o評価がALCEより人間評価と高く一致することも確認している。
- **議論はある？**: LongCiteでもhallucinationや誤引用は残る。SFTデータ生成はGLM-4という強いproprietary modelに依存しており、完全な再現性や独立性には課題がある。評価もGPT-4o judge依存で、自己バイアスやfunctional sentenceを悪用した評価ハックの可能性がある。PDF抽出からは、実運用時のレイテンシ、コスト、ドメイン外性能、引用が本当にユーザー検証を改善するかの詳細は限定的。
- **次に読む/試すなら**: LongCite-45kとモデルが公開されているか確認する。手元のRAG/long-context QAで、chunk citationとsentence citationの検証コストを比較する。CoFを既存QAデータに適用して、自前ドメインで引用付きSFTデータを作れるか試す。
- **キーワード**: `long-context QA`, `citation generation`, `sentence-level citation`, `SFT`, `RAG`, `LongBench-Cite`, `CoF`, `LongCite-45k`

## 気になったこと

- CoFで生成した引用は、LLMが作ったQAに対してどれだけ人間の検証に耐えるのか。
- GPT-4o judgeに依存しないcitation quality評価をどう作れるか。
- 実装するなら、sentence indexing、引用spanの正規化、引用不能statementの扱いがかなり重要そう。
- 日本語論文やPDF抽出が崩れた文書でも同じ精度が出るか。
- LongCite型SFTと通常のRAGを組み合わせると、引用精度と回答品質はさらに上がるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
