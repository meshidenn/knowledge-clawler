# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Denser $\neq$ better: Limits of on-policy self-distillation for continual post-training

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - Denser $\neq$ better: Limits of on-policy self-distillation for continual post-training

## 基本情報

- **タイトル**: Denser $\neq$ better: Limits of on-policy self-distillation for continual post-training
- **著者**: Meng Wang, Haohan Zhao, Wenzhuo Liu, Lu Yang, Geng Liu, Haiyang Guo, Guo-Sen Xie, Gaofeng Meng, Hongbin Liu, Fei Zhu
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.01763

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのcontinual post-trainingにおいて、on-policy self-distillationは本当に忘却を防ぐのかを、SDPOとGRPOの比較で検証した論文。
- **先行研究と比べてどこがすごい？**: 「on-policyなら忘却しにくい」という見方を、データ生成がon-policyであることと、更新objectiveが何を強化するかに分解した点が鋭い。SDPOは単一ドメインのspecializationでは強いが、continual learningではGRPOより忘却・collapse・driftが大きいことを示している。
- **技術や手法の肝はどこ？**: SDPOは、studentが生成したon-policy履歴に対し、より情報を持つteacherのtoken-level分布へJSDで合わせる。論文の肝は、このdense token supervisionが有用な信号だけでなく、teacher drift、CoTのノイズ、formatting artifactも各tokenで反復強化してしまうという分析。
- **どうやって有効だと検証した？**: MATH、SCIENCE、TOOLUSE、CODINGを順に学習するcontinual settingで、SDPO系とGRPOを比較。評価はAIME、Math500、GPQA、BFCLv4、LCBv6、ZLogic、MMLU-Rなど。さらにteacher EMA rate、restart-and-freeze、CoT distillation、parameter drift、response embedding shift、collapse時のJS divergenceを調べている。
- **議論はある？**: SDPOはteacherが安定し、token-level targetが信頼できる場合には速くspecializeするが、長いCoTや頻繁なteacher更新ではノイズを増幅する。特にSDPO 5%はTOOLUSE段階でほぼcollapseし、`\boxed` の反復のようなformat artifactが増幅される。PDF本文では、on-policy dataだけでは忘却抑制を保証しないと結論づけている。
- **次に読む/試すなら**: 
  1. SDPO-CLのコードで、teacher更新頻度とtoken maskを変えた最小実験を再現する。
  2. GRPOとSDPOを同じ新タスク成功率に揃え、旧タスク性能とKL driftを比較する。
  3. CoT tokenを全部distillせず、final answer周辺やschema-constrained tokenだけ重み付けする実験を見る。
- **キーワード**: `continual post-training`, `on-policy self-distillation`, `SDPO`, `GRPO`, `catastrophic forgetting`, `token-level supervision`, `teacher drift`

## 気になったこと

- SDPOの失敗はobjective由来なのか、teacher設計・token weightingでかなり救えるのか。
- 「中距離OODタスク」が最も干渉を受けるという観察を、MMD以外の距離指標でも確認したい。
- collapseの原因がformat artifactに見えるが、報酬設計・prompt形式・dataset順序の寄与をどこまで分離できているか。
- StableSDPOのrestart-and-freezeは実用的にかなり重要そうなので、標準SDPOの代替baselineとして読む価値がある。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
