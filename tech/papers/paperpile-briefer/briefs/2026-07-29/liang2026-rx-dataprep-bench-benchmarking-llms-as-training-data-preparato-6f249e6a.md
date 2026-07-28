# Paperpile Brief 2026-07-29 - DataPrep-Bench: Benchmarking LLMs as Training Data Preparators

## 基本情報

- **タイトル**: DataPrep-Bench: Benchmarking LLMs as Training Data Preparators
- **著者**: Hao Liang, Qifeng Cai, Yibo Lin, Jianzhuo Du, Qifeng Xia, Sizhe Qiu, Linzhuang Sun, Meiyi Qiang, Zhaoyang Han, Xiaochen Ma, Bohan Zeng, Ruichuan An, Conghui He, Wentao Zhang
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.20465 / PDF: https://arxiv.org/pdf/2607.20465.pdf / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMやagentが「学習データを作る能力」と「学習前にデータ品質を見積もる能力」を、下流タスク性能に接続して評価する統一ベンチマーク DataPrep-Bench を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来はデータ構築手法ごとにソース、base model、学習条件、評価タスクがばらばらで比較が難しかった。本論文は6ドメイン、複数base model、同一raw source、同一fine-tuning protocol、同一下流評価で比較する。さらにデータ品質を「文章の綺麗さ」ではなく「下流学習utility」と定義し、候補データセットのスコアと実際のfine-tuning後性能のPearson相関で測る点が強い。
- **技術や手法の肝はどこ？**: 2トラック構成。Data Construction Trackではraw domain sourceからSFT用QAデータを作らせ、Dolly-15kと混ぜてbase modelをfine-tuneし下流性能で評価する。Data Quality Evaluation Trackでは候補SFTデータセットにスカラー品質スコアを付け、そのスコアが実際の下流性能をどれだけ予測するかを見る。提案baselineとして、skill層にschema、filtering、coverage、validationを持たせる Data-Construction-Skill と、候補データとdomain proxyのembedding分布間MMDを負値化する Distributional Alignment Score, DAS を出している。
- **どうやって有効だと検証した？**: General, Math, Science, Medical, Finance, Law の6ドメインで評価。Data ConstructionではQwen2.5-7BとLlama-3.1-8BをLlamaFactoryでfine-tuneし、Dolly-15k onlyを基準にDataFlow系、直接LLM生成、agent系、skill-guided agentを比較。Data Quality EvaluationではQwen2.5-7B、Llama-3.1-8B、Mistral-7B-v0.3で、17種類の既存quality/diversity evaluatorとDASを比較し、下流性能とのPearson相関を測った。DASは6ドメイン中4ドメインでcross-model correlationが最強で、Math, Science, Medicalで同時に r > 0.70 を超えたと報告されている。
- **議論はある？**: 合成domain dataを足すとDolly-15k onlyより悪化する場合が多い、という結果自体が重要な警告。単純なQA生成や表面的なquality proxyでは「学習に効くデータ」を作れていない可能性がある。DASもproxy datasetの質とtarget分布への近さに依存し、MMDによる分布近さが必ず性能順位を保存するわけではない。FinanceとLawは全metricにとって難しいとされ、PDF抽出範囲では詳細な限界節や再現性条件の全体は確認しきれていない。
- **次に読む/試すなら**: DataPrep-BenchのGitHubとHugging Face datasetを確認する。DASを自分の候補SFTデータに対して再実装し、proxy選択で相関がどれだけ変わるか試す。Data-Construction-Skillのschema/filtering/validation設計を読んで、自前のpaper-to-QA生成pipelineに移植できるか見る。
- **キーワード**: `DataPrep-Bench`, `training data preparation`, `SFT data`, `data quality evaluation`, `MMD`, `DAS`, `LLM agents`, `downstream utility`

## 気になったこと

- DASの性能がdomain proxy選択にどれだけ敏感か。proxyを少し外すと相関が崩れるのかを見たい。
- 「合成domain dataがしばしば悪化する」原因が、データ品質、分布ミスマッチ、Dolly-15kとの混合比、学習hyperparameterのどれに強く依存するのか。
- Data-Construction-Skillのvalidation utilitiesがどこまで自動でfaithfulnessやduplicateを落とせるのか。実装上はここが一番再利用価値がありそう。
- FinanceとLawでDASを含むmetricが難しい理由。専門語彙の表層一致ではなく、制度・文脈・推論形式の違いが効いている可能性がある。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [liang2026-rx-dataprep-bench-benchmarking-llms-as-training-data-preparato-6f249e6a.md](../../chat/2026-07-29/liang2026-rx-dataprep-bench-benchmarking-llms-as-training-data-preparato-6f249e6a.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
