# Paperpile Brief 2026-08-27 - Beyond the stability-exploration dilemma: Environmental regularization for LLM policy optimization

## 基本情報

- **タイトル**: Beyond the stability-exploration dilemma: Environmental regularization for LLM policy optimization
- **著者**: Xianlei Zhou, Xiangdi Meng, Yu He, Tianyu Qi, Shuyan Guan, Xianli Zhang, Jian Zhang, Xin Li, Qika Lin, Jun Liu
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.23311v2](https://arxiv.org/abs/2608.23311v2), [実装](https://github.com/AlibabaResearch/ERPO)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのRL方策最適化で、応答側のPolicy-KLではなく入力クエリ側の分布を正則化するERPOを提案し、探索を保ちながら学習安定性を高める論文。
- **先行研究と比べてどこがすごい？**: PPO/GRPOのPolicy-KLは応答の探索も直接縛るのに対し、ERPOは学習クエリの尤度分布と事前RL参照分布のQuery-KLを制約する。追加forward passなしで既存のGRPO/PPO/REINFORCE系に組み込め、6つの数理推論ベンチマークでGRPOを上回った。
- **技術や手法の肝はどこ？**: 現在モデルと参照モデルにおける各クエリの対数尤度差からQuery-KLを推定し、その勾配をクエリ尤度にのみ流す。加えて、参照モデル上で典型的なクエリを重視する静的なクエリ重みを使い、更新分散を抑える。応答のscore functionにはQuery-KLの直接勾配を流さない設計が要点。
- **どうやって有効だと検証した？**: Qwen2.5-Math 7B/32BをMATH Level 3–5でRL学習し、AIME24/25、AMC、MATH500、Minerva、OlympiadBenchで評価した。温度0.1〜1.5を横断してAvg@32・Pass@32・Pass@1を測定し、Avg@32は平均で6.2%改善したと報告する。訓練と推論の精度差も、GRPOの6.47%からERPOの3.14%へ低減した。
- **議論はある？**: 実験対象は主に数学推論とQwen系モデルであり、対話・コード生成・多言語・一般的なinstruction-followingへの転移は未検証。また、Query-KLが「応答探索を損なわない」という構造的主張と、実際の最終性能・探索挙動の因果をより広い設定で切り分ける必要がある。
- **次に読む/試すなら**: 1. 既存GRPO実装で参照クエリ尤度をキャッシュし、Query-KLのみを置換する最小実験を行う。2. 高温度rollout時のPass@1と訓練・推論ギャップをGRPOと比較する。3. DAPO/RLOOやコード生成報酬へ移植して一般性を検証する。
- **キーワード**: `ERPO`, `Query-KL`, `RLVR`, `GRPO`, `LLM policy optimization`, `数学推論`, `学習安定性`

## 気になったこと

- 「クエリ分布」の定義・推定が、固定データセット上のクエリ尤度とどこまで一致するかを確認したい。
- Query-KL係数αやクエリ重みが、データセットの偏り・長文プロンプト・領域外入力にどの程度敏感か。
- 高温度での安定化が、真の探索改善なのか、単に低確率クエリへの更新を抑えた効果なのかを分離して見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhou2026-yn-beyond-the-stability-exploration-dilemma-environmental-regul-f5345ed9.md](../../chat/2026-08-27/zhou2026-yn-beyond-the-stability-exploration-dilemma-environmental-regul-f5345ed9.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
