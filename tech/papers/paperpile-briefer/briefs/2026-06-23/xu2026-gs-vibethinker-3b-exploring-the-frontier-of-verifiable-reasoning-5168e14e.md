# Paperpile Brief 2026-06-23 - VibeThinker-3B: Exploring the frontier of verifiable reasoning in small language models

## 基本情報

- **タイトル**: VibeThinker-3B: Exploring the frontier of verifiable reasoning in small language models
- **著者**: Sen Xu, Shixi Liu, Wei Wang, Jixin Min, Yingwei Dai, Zhibin Yin, Yirong Chen, Xin Zhou, Junlin Zhang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2606.16140 / GitHub: https://github.com/WeiboAI/VibeThinker / Hugging Face: https://huggingface.co/WeiboAI/VibeThinker-3B

## 落合陽一フォーマット

- **ひとことでいうと**: 3Bパラメータの小型言語モデルでも、数学・コードのような「検証可能な推論」ならフロンティア級モデルに近い性能まで到達できることを示した技術報告。
- **先行研究と比べてどこがすごい？**: VibeThinker-1.5Bの延長として、単に小型モデルでも推論できるという主張から一歩進み、3B規模でAIME26 94.3、CLR併用で97.1、LiveCodeBench v6 Pass@1 80.2、LeetCode近時コンテストで96.1% acceptanceという強い結果を出している。DeepSeek V3.2、GLM-5、Kimi K2.5、Gemini 3 Proなど桁違いに大きいモデル群と、少なくとも検証可能タスクでは同じ性能帯に入るという点が主張の核。
- **技術や手法の肝はどこ？**: Qwen2.5-Coder-3B baseを起点に、Spectrum-to-Signal Principleに基づく段階的ポストトレーニングを行う。具体的には、広範囲SFT、難問・長CoTへのカリキュラムSFT、数学・コード・STEM向けのmulti-domain RL、MGPO、Long2Short Math RL、offline self-distillation、Instruct RLを組み合わせる。さらに推論時にはClaim-Level Reliability Assessment（CLR）で、検証可能な数学問題の回答信頼性を上げる。
- **どうやって有効だと検証した？**: AIME25/26、HMMT25、BruMO25、IMO-AnswerBench、LiveCodeBench v6、OJBench、GPQA-Diamond、IFEval、IFBenchなどで評価。特に競技数学・コード生成・命令追従を広く比較し、3Bモデルとしては非常に高い性能を示した。加えて、2026-04-25〜2026-05-31のLeetCode weekly/biweekly contestsでPython one-shot生成を評価し、123/128、96.1% acceptanceを報告している。
- **議論はある？**: 主張は「3Bが汎用大規模モデルを置き換える」ではなく、「検証可能推論は小型モデルに圧縮可能」というもの。GPQA-Diamondでは70.2、CLR後72.9で、大型モデルとの差が残るため、知識集約型・オープンドメイン能力には限界がある。データ汚染対策や評価プロトコルは述べられているが、PDF抽出テキストからは学習データ規模、教師モデル依存、CLRの計算コスト、完全な再現手順の細部は十分には確認できない。
- **次に読む/試すなら**: VibeThinker-1.5B論文を読んでSpectrum-to-SignalとMGPOの元設計を確認する。VibeThinker-3BのHugging FaceモデルでAIME風・LeetCode風の小規模再現評価を回す。CLRがどの程度の追加推論コストで性能を上げているかを実装・検証する。
- **キーワード**: `small language model`, `verifiable reasoning`, `post-training`, `reinforcement learning`, `self-distillation`, `test-time scaling`, `AIME`, `LiveCodeBench`

## 気になったこと

- Parametric Compression-Coverage Hypothesisは魅力的だが、どの能力が「parameter-dense」で、どの能力が「parameter-expansive」なのかを測る操作的定義が必要。
- CLRの詳細なアルゴリズム、サンプリング回数、追加計算量、失敗ケースを確認したい。
- LeetCode評価は強いが、問題選定・公開リーダーボードとの整合・プロンプト条件の差でどこまで比較可能かを見たい。
- 小型モデルが高性能化するほど、SFT/RLの教師モデルや合成データ由来の能力移転をどう評価するかが重要になる。
- GPQA-Diamondの差分を見ると、知識集約型タスクを外部検索やRAGで補った場合にどこまで大型モデルとの差が縮まるかが気になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [xu2026-gs-vibethinker-3b-exploring-the-frontier-of-verifiable-reasoning-5168e14e.md](../../chat/2026-06-23/xu2026-gs-vibethinker-3b-exploring-the-frontier-of-verifiable-reasoning-5168e14e.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
