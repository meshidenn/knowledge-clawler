# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {DuoMem}: Towards capable on-device memory agents via dual-space distillation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - DuoMem: Towards Capable On-Device Memory Agents via Dual-Space Distillation

## 基本情報

- **タイトル**: DuoMem: Towards Capable On-Device Memory Agents via Dual-Space Distillation
- **著者**: Peyman Hosseini, Ondrej Bohdal, Ahmed Alajrami, Andrea Maracani, Ignacio Castro, Matthew Purver, Mete Ozay, Savas Ozkan, Taha Ceritli
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2606.29961

## 落合陽一フォーマット

- **ひとことでいうと**: 大規模LLMエージェントの手続き記憶能力を、小型オンデバイス向けモデルへ「文脈」と「パラメータ」の両方から蒸留するDuoMemを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の手続き記憶エージェントは大規模モデル前提になりがちだが、DuoMemは4BモデルをALFWorldで成功率4.3%から77.9%まで引き上げ、72B teacherの87.1%にかなり近づけている。追加学習パラメータはLoRAで1000万未満、teacher memoryも数MB程度で、72B teacherより壁時計時間で3倍以上速い点がオンデバイス志向。
- **技術や手法の肝はどこ？**: 2つの蒸留を組み合わせる点。Context-space distillationでは、studentが作る低品質な記憶ではなく、72B teacherが成功軌跡から抽出したprocedural memoryを事前保存し、推論時に類似度検索してpromptへ入れる。Parameter-space distillationでは、teacherの成功軌跡だけを使ってstudentにLoRAを学習し、環境観測と履歴から次の行動を模倣させる。
- **どうやって有効だと検証した？**: ALFWorldのtext-based embodied decision-makingタスクで評価。標準train 3,553タスク、development 140タスク、test相当のunseen validation 134タスクを使い、Gemma/Qwen系の2B〜72Bモデルで比較している。No memory、Script、Trajectory、MemP、Context Distillationあり/なし、LoRAあり/なしをablationし、両方の蒸留を組み合わせたときに単独手法より大きく改善することを示している。
- **議論はある？**: 評価が主にALFWorldに集中しており、実ロボット、スマホ、長期継続利用で同じ効果が出るかは未検証。teacher memoryの検索にはOpenAI text-embedding-3-smallを使っており、完全なオンデバイス閉域構成とは言い切れない可能性がある。PDF抽出上、細かい表や設定値は一部崩れているため、数値の詳細は原PDF確認が必要。
- **次に読む/試すなら**: ALFWorldでQwen3-4B-Instruct + LoRA + teacher memory検索の最小再現を組む。MemP、AWM、LEGOMemとの違いを整理する。embedding検索をローカルembeddingモデルに置き換えて性能劣化を見る。
- **キーワード**: `procedural memory`, `LLM agents`, `knowledge distillation`, `LoRA`, `on-device LLM`, `ALFWorld`, `memory-augmented agents`

## 気になったこと

- teacher-generated memoryがどの程度タスク分布に依存しているか、ALFWorld以外へ移したときの汎化が気になる。
- teacher成功軌跡だけでLoRA学習する設計は合理的だが、失敗からの反省やリカバリ行動を学ばない弱点がありそう。
- 「オンデバイス」と言うなら、embedding生成、memory retrieval、LoRA適用後モデルサイズ、実測デバイス条件まで含めた端末上ベンチマークを確認したい。
- context-space distillationとparameter-space distillationの相互作用が、単純なprompt改善 + imitation learning以上のものかを追加実験で見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
