# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Frontis-{MA1}: Training an {AI4AI} model towards recursive self-improvement in machine learning engineering

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - Frontis-MA1: Training an AI4AI Model towards Recursive Self-Improvement in Machine Learning Engineering

## 基本情報

- **タイトル**: Frontis-MA1: Training an AI4AI Model towards Recursive Self-Improvement in Machine Learning Engineering
- **著者**: Junlin Yang, Che Jiang, Yu Fu, Tianwei Luo, Can Ren, Weizhi Wang, Kaikai Zhao, Hongyi Liu, Yuxin Zuo, Yuru Wang, Yuchen Fan, Kai Tian, Zhenzhao Yuan, Xiaojian Lin, Li Sheng, Rushi Qiang, Guoli Jia, Xingtai Lv, Ermo Hua, Dianqiao Lei, Youbang Sun, Ning Ding, Bowen Zhou, Kaiyan Zhang
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.28568 / Code: https://github.com/FrontisAI/OpenRSI

## 落合陽一フォーマット

- **ひとことでいうと**: MLE、つまり機械学習エンジニアリングを実行可能なAI4AI実験場として定式化し、タスク環境・実行フィードバック付き学習・長期探索をつないだOpenMLE上で、Frontis-MA1-35Bを自己改善寄りのmeta-evolution agentとして訓練した論文。
- **先行研究と比べてどこがすごい？**: 既存のMLE agent研究が「探索harness」「実行環境」「実行フィードバックによるpost-training」の一部に寄っていたのに対し、本論文はOpenMLE-Gym、OpenMLE-ERL、OpenMLE-Evoを一体化している点が差分。MLE-Bench Liteでは、同一OpenMLE-Evo harness下でQwen3.6-35B-A3BのMedal Average 39.39%からFrontis-MA1-35Bの60.61%へ改善し、OpenMLE-Evo-Maxでは71.21%に到達したと報告している。
- **技術や手法の肝はどこ？**: Draft、Improve、Debug、Crossoverという4つの原子的なprogram-evolution operatorを、訓練時と推論時の共通インターフェースにした点。OpenMLE-ERLでは実行結果に基づくSFT/RLでoperatorを学習し、OpenMLE-Evoでは実行済み候補のexperience card / boardを使って、品質・進捗・新規性で親を選び、operatorごとに必要な記憶だけを合成して探索する。
- **どうやって有効だと検証した？**: PDF本文によると、公式22タスクのMLE-Bench Liteで、1タスク12時間・RTX 4090・12GB VRAM制限の下、3回独立実行を基本に評価している。指標はValid Rate、Medal Average、Human Rank。Frontis-MA1-35BはOpenMLE-Evoで21.67/22 valid、60.61% Medal Average、0.7647 Human Rank。OpenMLE-Evo-Maxでは22/22 valid、71.21%、0.8126。NatureBench Liteでも、モデル差し替えでMatch-SOTAが50%から70%、harness差し替えで20%から50%に上がったとする。
- **議論はある？**: PDF抽出は20ページ分で、Limitations章の詳細は本文抽出範囲から十分確認できない。見えている範囲では、評価がMLE-Bench Lite中心で、OpenMLE-Evo-Maxはbenchmark-independentな経験事前知識と非同期探索を追加しているため、純粋なモデル能力・探索設計・外部事前知識の寄与分解をさらに精査したい。GPT-5.5/5.6など未公開・時点依存の比較対象も含むため、再現可能性は公開予定のweights/code/datasetsが実際に揃うかに依存する。
- **次に読む/試すなら**: OpenRSIの公開物でOpenMLE-Evoのparent selectionとmemory synthesisを読む。小さいKaggle風タスクでDraft/Improve/Debug/Crossoverだけを再現する。NatureBench Liteでのtransfer設定を確認し、MLE以外のAutoResearchにどこまで一般化するか見る。
- **キーワード**: `AI4AI`, `recursive self-improvement`, `machine learning engineering`, `OpenMLE`, `evolutionary search`, `execution-grounded RL`, `agent post-training`

## 気になったこと

- OpenMLE-Gymの5,758タスクがどの程度実タスク多様性を持ち、評価benchmarkとの重複除去がどこまで厳密か。
- Medal Averageの改善が、モデルのoperator学習によるものか、探索予算配分とmemory設計によるものか、どのablationが一番強い根拠になるか。
- OpenMLE-Evo-Maxのcross-task priorsが、実運用ではどのくらい「経験知識の持ち込み」と「benchmark contamination」の境界に近いか。
- RSIという主張に対して、今回のループは「自己改善」よりも「実行軌跡を使ったagent post-training」に近いのではないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
