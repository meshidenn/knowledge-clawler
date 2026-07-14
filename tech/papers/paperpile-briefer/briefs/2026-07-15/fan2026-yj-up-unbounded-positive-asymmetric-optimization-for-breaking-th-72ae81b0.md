# Paperpile Brief 2026-07-15 - {UP}: Unbounded Positive Asymmetric Optimization for breaking the exploration-stability dilemma

## 基本情報

- **タイトル**: {UP}: Unbounded Positive Asymmetric Optimization for breaking the exploration-stability dilemma
- **著者**: Chongyu Fan, Pengfei Liu, Jingjia Huang, Sijia Liu, Yi Lin
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: arXiv:2607.06987, https://arxiv.org/pdf/2607.06987, Project Page: https://chongyu-fan.netlify.app/posts/up/

## 落合陽一フォーマット

- **ひとことでいうと**: LLM reasoning向けRLで、正解ロールアウトには上限クリップなしの安定な更新をかけ、不正解ロールアウトには従来のクリップを残すことで、探索と安定性のトレードオフを崩そうとする論文。
- **先行研究と比べてどこがすごい？**: GRPO/DAPO/GSPOなどのimportance sampling系RLは、純粋なISだと勾配爆発し、clipすると低確率だが正しい推論経路を早く潰す。論文はProbability Capacityという概念でこの制約を定式化し、positive advantage側だけをunboundedにする設計を提案している。UP-GRPOは5つの推論ベンチマーク平均Pass@1で61.31%を出し、GSPOの60.15%など11 baselineを上回ったと報告している。
- **技術や手法の肝はどこ？**: positive advantageでは通常の比率 `pi_theta / pi_old` をやめ、stop-gradientを使った自己アンカー `pi_theta / sg(pi_theta)` に置き換える点。これによりforward値は1に近いが、勾配はREINFORCE型の `A * grad log pi_theta` になり、`pi_old` が小さいときのIS比率爆発を避けつつ、上限clipで正解経路の強化が止まらない。negative advantageでは従来のDAPO/GRPO/GSPOのclipを残し、誤った経路を過剰に叩いて不安定化するのを防ぐ。
- **どうやって有効だと検証した？**: PDF本文を主根拠にすると、Qwen3-14B-BaseでDAPOとUP-DAPOを比較し、AIME24でAvg@32が47.71から51.15、Maj@32が58.36から60.88、Best@32が80.49から81.79に改善したと報告。Qwen3-8BではGRPO系を含む11 baselineと比較し、AIME24、AMC23、MATH500、Minerva、OlympiadBenchの平均Pass@1でUP-GRPOが最高。さらにQwen3-30B-A3B-BaseのMoEでUP-GSPO、Qwen3-VL-8B-InstructのGeometry3KでUP-GRPOを試し、性能改善とKL divergenceの安定を示している。
- **議論はある？**: 限界として、実験は主にQwen3系、数学・幾何推論タスク、verl/vLLM実装に寄っている。stop-gradient自己アンカーが他モデル系列、長期学習、大規模RLHF、安全性報酬、非二値的・ノイジーなrewardで同じように効くかは本文だけでは未検証。数値はPDF抽出テキスト由来のため、細かい表記崩れの可能性はある。
- **次に読む/試すなら**: UP-GRPOのlossを既存GRPO実装に最小差分で入れて、positive advantage分岐だけclipを外す。/ DAPOの `epsilon_high = inf` との違いをgradient normとKLで再現確認する。/ ASPO、W-REINFORCE、TOPRとの設計差を比較する。
- **キーワード**: `LLM reinforcement learning`, `GRPO`, `DAPO`, `GSPO`, `importance sampling`, `stop-gradient`, `asymmetric optimization`, `exploration-stability dilemma`

## 気になったこと

- positive advantageを「正しいロールアウト」とみなす前提が、部分点・ノイズの多いreward modelでも成立するか。
- `sg(pi_theta)` 自己アンカーは実装上かなり簡単そうだが、mixed precisionやsequence-level probability計算で数値安定性の注意点があるか。
- KLが低いままentropyが上がるという観測が、どの粒度のentropy測定に依存しているのか。
- 上限clipを外す対象をtoken単位にするかsequence単位にするかで、長文推論の長さバイアスがどう変わるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [fan2026-yj-up-unbounded-positive-asymmetric-optimization-for-breaking-th-72ae81b0.md](../../chat/2026-07-15/fan2026-yj-up-unbounded-positive-asymmetric-optimization-for-breaking-th-72ae81b0.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
