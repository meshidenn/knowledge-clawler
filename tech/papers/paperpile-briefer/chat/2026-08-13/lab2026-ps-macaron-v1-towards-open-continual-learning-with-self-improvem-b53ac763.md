# Chat Prompt 2026-08-13

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Macaron-{V1}: Towards open continual learning with self-improvement and Mixture-of-{LoRA}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-13 - Macaron-V1: Towards Open Continual Learning with Self-Improvement and Mixture-of-LoRA

## 基本情報

- **タイトル**: Macaron-V1: Towards open continual learning with self-improvement and Mixture-of-LoRA
- **著者**: Mind Lab, Vin Bo, Asher Cai, Jingwei Cao, Song Cao, Vic Cao, Amelia Chen, Andrew Chen, Kaijie Chen ほか
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2608.09819 / arXiv:2608.09819

## 落合陽一フォーマット

- **ひとことでいうと**: デプロイ後の経験から継続的に改善するagent model familyとして、Macaron-V1を提案したシステム論文。
- **先行研究と比べてどこがすごい？**: 単一checkpointを中央集権的にpost-trainingするのではなく、frozen base model + specialist LoRA + production harnessを組み合わせ、model-harness pairをversion管理しながら改善する点が主張。Mixture-of-LoRAでchat / agent / coding / GenUIの専門adapterを分離し、1 user turnごとにroutingする。
- **技術や手法の肝はどこ？**: コアは3つ。1つ目は、744B GLM-5.2 baseや50B Qwen3.6 baseを凍結し、用途別LoRAを載せるMoL構成。2つ目は、UI4A、REPL agent harness、Harness Context Protocolを使い、harness自体を訓練・評価対象として扱うModel-Harness Co-design。3つ目は、MindForgeによるtask discovery、trajectory expansion、configuration / adapter updateを結ぶrecursive self-improvement loop。
- **どうやって有効だと検証した？**: PDF本文ではPersonal Intelligence、GenUI、general capability benchmarksでfrontier baselinesと比較すると説明されている。ただし取得PDFテキストは前半中心で、結果表や詳細スコア部分は十分に含まれていないため、細かい性能値はメタデータからは不明。本文中ではrouting loopの測定、UI4Aのtoken削減、KV reuseの影響などの部分的評価が述べられている。
- **議論はある？**: 著者自身も、継続学習によるcompounding gainとcollective intelligenceは未解決と明記している。現行評価は4つの出荷済みspecialistが中心で、異なるteamやuser由来のadapter合成、personalized adapterの品質・privacy・cross-user compositionは未検証。1 turn 1 specialist routingなので、複数意図を含む入力の分解・合成も今後課題。
- **次に読む/試すなら**: MoL harnessの実装を確認する。UI4AとREPL harnessが既存agent基盤にどう移植できるかを見る。評価section全文を読んで、Macaron ChatBench / LivingBenchの再現可能性を確認する。
- **キーワード**: `continual learning`, `Mixture-of-LoRA`, `agent harness`, `recursive self-improvement`, `GenUI`, `LoRA`

## 気になったこと

- MoLのper-turn routingは、複合タスクでどれくらい失敗するのか。
- Harness Context Protocolによるconfiguration searchとLoRA trainingの寄与をどう分離評価しているのか。
- 「open」と言いつつ、training data、evaluation harness、adapter生成過程がどこまで再現可能なのか。
- Personal Intelligence benchmarkがin-distribution寄りなら、汎用agent性能の証拠としてどこまで読めるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
