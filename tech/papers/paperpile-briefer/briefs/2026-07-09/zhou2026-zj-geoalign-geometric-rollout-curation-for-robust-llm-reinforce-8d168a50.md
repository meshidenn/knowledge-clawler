# Paperpile Brief 2026-07-09 - GEOALIGN: Geometric Rollout Curation for Robust LLM Reinforcement Learning

## 基本情報

- **タイトル**: GEOALIGN: Geometric Rollout Curation for Robust LLM Reinforcement Learning
- **著者**: Ting Zhou, Zhenqing Ling, Yiyang Zhao, Ying Shen, Daoyuan Chen
- **年 / venue**: 2026 / arXiv [cs.LG], ICML 2026 proceedings 記載あり
- **リンク**: arXiv:2606.26917 / https://arxiv.org/pdf/2606.26917

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのオンラインRLで、報酬は高いが更新方向がバッチ多数派と食い違う rollout を幾何的に検出し、安定な同一prompt内サンプルで置き換える手法 GEOALIGN を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のPF-PPO、PAR、PODS、Seed-GRPOなどは主に報酬値・不確実性・サンプル選別で「寄与の大きさ」を調整するが、本論文は hidden state 上の「方向の一貫性」を信頼性信号として使う。per-sample gradient や追加 backward なしの forward-pass only で、報酬ハックやノイズに由来する高報酬外れ値を狙い撃ちする点が新規。
- **技術や手法の肝はどこ？**: 同一prompt内で報酬順に winner/loser のペアを作り、最終token付近の hidden state 差分を「改善方向」とみなす。その方向を小さな3層MLP projectorで低次元・報酬順序に敏感な空間へ写し、報酬差で重み付けした batch consensus prototype を作る。各 rollout について prototype からの cosine deviation を累積した GDI（Geometric Deviation Index）を計算し、KDEで高GDIの long-tail 外れ値を検出して、同一prompt内の安定サンプルに置換する。
- **どうやって有効だと検証した？**: Qwen3-1.7B / 4B を対象に、数学推論では DAPO-Math-17k と binary verified reward、RLHFでは HH-RLHF と ArmoRM reward を使い、GRPO上のplug-inとして評価。Math平均では Qwen3-1.7B で 40.44、4Bで 55.94 とベースライン群を上回り、HH-RLHF平均スコアでも 1.7Bで 0.8885、4Bで 0.8894。報酬を意図的に5%/10%破壊する実験でも、GEOALIGNが最も性能低下に強く、破壊されたrolloutが高GDI領域に集中することを示している。
- **議論はある？**: hidden state の方向一貫性が実際の policy gradient variance とどこまで厳密に対応するかは理論的には未完成で、論文自身も future work としている。評価は主にQwen3系、GRPO、2タスクに限定されるため、他モデル・他RLアルゴリズム・より複雑な報酬設計への一般化は追加検証が必要。PDF本文上ではコード公開先は示されているが、再現に必要な計算資源は8×A100級で軽くない。
- **次に読む/試すなら**: Trinity-RFT上の実装を確認し、GDI計算と置換処理だけを小規模GRPO実験に移植する。既存のrollout filtering手法と、報酬値ベースではなく方向ベースで検出されるサンプルの違いを可視化する。hidden state層・pooling方法・projectorなしの場合でGDIの安定性を再検証する。
- **キーワード**: `LLM reinforcement learning`, `GRPO`, `rollout curation`, `directional inconsistency`, `reward hacking`, `latent geometry`, `RLHF`

## 気になったこと

- GDIで検出される外れ値が、本当に「悪い推論」なのか、それとも少数だが有益な探索方向を消している可能性はないか。
- projectorを各iterationで50step学習する設計は「軽量」とされているが、rollout生成以外のボトルネックが大きい環境では無視できるか。
- binary rewardで同点が多い場合、preference pairが作れないpromptをskipする設計が、学習初期や難問領域でどの程度効くのか。
- 置換ではなく zero-weighting / dropping / advantage clipping と組み合わせた場合の実装上の安定性を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhou2026-zj-geoalign-geometric-rollout-curation-for-robust-llm-reinforce-8d168a50.md](../../chat/2026-07-09/zhou2026-zj-geoalign-geometric-rollout-curation-for-robust-llm-reinforce-8d168a50.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
