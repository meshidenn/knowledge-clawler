# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- The mirage of optimizing training policies: Monotonic inference policies as the real objective for {LLM} reinforcement learning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - The mirage of optimizing training policies: Monotonic inference policies as the real objective for LLM reinforcement learning

## 基本情報

- **タイトル**: The mirage of optimizing training policies: Monotonic inference policies as the real objective for LLM reinforcement learning
- **著者**: Jing Liang, Hongyao Tang, Yi Ma, Yancheng He, Weixun Wang, Xiaoyang Li, Ju Huang, Wenbo Su, Jinyi Liu, Yan Zheng, Jianye Hao, Bo Zheng
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2606.29526 / arXiv:2606.29526

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのRL post-trainingでは「training policy」を良くしても、実際にrollout/deploymentで使う「inference policy」が良くなるとは限らないので、inference policyの単調改善を直接目標にすべきだと主張し、MIPI/MIPUを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存研究はtraining-inference mismatchをoff-policy補正、sample filtering、LR decay、FP16/低精度系のsystem改善として扱うことが多い。本論文はそれを「目的関数のズレ」として捉え直し、training側の改善ではなくinference側の改善を受理基準に入れる。FP8-quantized rolloutという高mismatch条件で、Qwen3-4B平均66.71%、Qwen3-1.7B平均53.97%と、比較手法より平均性能と安定性を改善した。
- **技術や手法の肝はどこ？**: 中核は Monotonic Inference Policy Improvement (MIPI)。training policyをπ、inference policyをμとして、通常の `J(π_k+1) - J(π_k) >= 0` ではなく、`J(μ_k+1) - J(μ_k) >= 0` を狙う。実装として Monotonic Inference Policy Update (MIPU) を提案し、Step 1でsampler-referenced candidate updateを作り、Step 2で同期後candidateをinference-side gap proxy `T_post` によりaccept/rollbackする。
- **どうやって有効だと検証した？**: FP8-quantized rolloutでQwen3-1.7BとQwen3-4BをRL training。訓練データはDAPO-Math-17k由来およびDeepMath-103K由来のfiltered examples。評価はMATH-500、AIME24、AMC23、Minerva Math、OlympiadBenchのpass@1。Baseline GRPO、MIS、LR-decayと比較し、さらにStep 1 only、Step 2 only、full MIPUのablationを実施。random rollbackとの比較で、Step 2の効果が単なるupdate削減ではなく、inference gap signalに依存することも確認している。
- **議論はある？**: 実験はmoderate-scale modelsに限定され、大規模モデルや多様なRL systemで同じmismatch patternが出るかは未検証。Step 2のpost-update gap proxyは有効な一実装だが、より効率的な推定器、強いacceptance criterion、gapを直接使うoptimizationなどは今後の課題。PDF本文ベースでは、細かな数式・表の一部は抽出崩れがあるため、数値の扱いは慎重に見るべき。
- **次に読む/試すなら**: MIPUのStep 2だけを既存GRPO/RLVR pipelineに最小実装して、FP8/vLLM rollout時のrollback率とscore安定性を見る。TIS/MIS/LR-decayとの組み合わせで、どのmismatch条件に効くか比較する。`T_post` proxyの計算コストとvalidation batch設計を確認する。
- **キーワード**: `LLM RL`, `training-inference mismatch`, `MIPI`, `MIPU`, `GRPO`, `FP8 rollout`, `inference policy`, `rollback`

## 気になったこと

- inference-side gap proxy `T_post` はvalidation batch依存なので、batch selectionやreward noiseにどれくらい敏感か。
- Step 2のrollbackはcheckpoint/sync運用コストがありそうで、実システムではthroughput低下との trade-off が重要。
- FP8 rolloutで顕著な効果が出ているが、FP16 rolloutや同一engine構成などmismatchが小さい条件での利益はどの程度残るのか。
- deploymentで使うinference engineを途中で変えた場合、MIPI/MIPUの保証やproxyは再調整が必要そう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
