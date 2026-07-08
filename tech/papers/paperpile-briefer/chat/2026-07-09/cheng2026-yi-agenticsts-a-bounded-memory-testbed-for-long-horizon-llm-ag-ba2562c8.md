# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {AgenticSTS}: A Bounded-Memory Testbed for Long-Horizon {LLM} Agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - AgenticSTS: A Bounded-Memory Testbed for Long-Horizon LLM Agents

## 基本情報

- **タイトル**: AgenticSTS: A Bounded-Memory Testbed for Long-Horizon LLM Agents
- **著者**: Xiangchen Cheng, Yunwei Jiang, Jianwen Sun, Zizhen Li, Chuanhao Li, Xiangcheng Cao, Yihao Liu, Fanrui Zhang, Li Jin, Kaipeng Zhang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2607.02255 / https://github.com/AlayaLab/AgenticSTS

## 落合陽一フォーマット

- **ひとことでいうと**: 長期タスクを行うLLM agentのmemoryを、過去ログの蓄積ではなく「型付きretrievalで毎回promptを再構成する bounded memory contract」として設計し、Slay the Spire 2で検証するtestbedを作った論文。
- **先行研究と比べてどこがすごい？**: ReAct/Reflexion系の履歴追加型、MemGPT/Mem0系の外部memory、Voyager系のskill libraryを、単なる実装部品ではなく「各decisionが何を見られるか」という評価可能なcontractに落としている点。L1 protocol、L2 schema、L3 rules、L4 episodic summaries、L5 strategic skillsを分離し、各layerをablationできる。298本のtrajectory、condition tag、frozen memory/skill snapshot、prompt record、分析scriptを公開しているのも再分析しやすい。
- **技術や手法の肝はどこ？**: 各decisionでraw cross-decision transcriptをappendせず、fresh user messageを型付きslotから組み立てる。slotは固定protocol、状態schema、game rule retrieval、episode memory、triggered skillの5層。これによりcontext長がrun長に比例して肥大化せず、どのmemory layerが効いたかを切り分けやすくしている。
- **どうやって有効だと検証した？**: Slay the Spire 2を長期・確率的・閉ルールのbenchmarkとして使い、固定A0で5条件×10 gameのablationを実施。no-store baselineは3/10勝、L5 skill layerを入れた条件では6/10勝が観測された。ただしFisher exact p≈0.37で、統計的に決定的ではなく方向性のある結果として扱っている。加えてGemini/Qwen/DeepSeekを使ったcross-backbone probe、A6-A8までのascension ladder probe、token auditも報告している。
- **議論はある？**: 最大の弱点はsample sizeが小さく、勝率差の統計的主張が弱いこと。bounded contractがaccumulating-context設計より優れるかは同一codebaseでのmatched比較が未実施。対象はSilent 1キャラクター中心で、game versionや他characterへの一般化も限定的。training-freeかつsingle-gameなので、連続制御・visual input・multi-agent・fine-tuning・cross-game transferにはまだ広がっていない。
- **次に読む/試すなら**: 1. GitHubとHugging Face datasetを見て、condition tagとanalysis scriptでA0 ablationを再計算する。 2. 同じharnessにaccumulating-context baselineを1行追加して比較する。 3. L5 skillのtrigger設計がどれだけ手作業/seed依存かを確認する。
- **キーワード**: `LLM agent`, `bounded memory`, `typed retrieval`, `long-horizon agent`, `Slay the Spire 2`, `agent memory`, `skill library`, `ablation`

## 気になったこと

- L5 strategic skillの有効性が見えているが、skillの作成・更新・trigger条件がどれだけ人手設計に依存しているかを詳しく確認したい。
- 3/10→6/10は面白いが、n=10/cellでは揺れが大きいので、公開trajectory以外に追加runしたとき同じ傾向が残るかが重要。
- accumulating-context baselineを同じcodebase・同じmodel・同じseed分布で作ると、bounded memoryの本当の差分が見えそう。
- Slay the Spire 2は閉ルール環境なので、web taskやsoftware engineering taskのようなopen-ended環境にそのまま移るかは未検証。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
