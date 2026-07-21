# Paperpile Brief 2026-07-22 - Understanding reasoning from pretraining to post-training

## 基本情報

- **タイトル**: Understanding reasoning from pretraining to post-training
- **著者**: Jingyan Shen, Ang Li, Salman Rahman, Yifan Sun, Micah Goldblum, Matus Telgarsky, Pavel Izmailov
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.16097v1 / arXiv:2607.16097v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのpretrainingが、その後のverifiable RLによるreasoning性能向上にどう効くかを、チェスを制御された実験場として定量化した論文。
- **先行研究と比べてどこがすごい？**: RL post-trainingを単独で見るのではなく、pretraining loss・pretraining tokens・RL computeをまたいだスケーリング関係として扱う点が新しい。5M〜1Bパラメータのモデル、36通りのpretraining/RL条件を振り、pretraining lossがpost-RL性能を予測すること、RL改善の傾きがpretraining tokensとおおむね線形に関係することを示している。
- **技術や手法の肝はどこ？**: チェスを「小さく制御可能なLLM reasoning環境」として使う設計。人間のLichess棋譜でpretrainingし、合成reasoning traceでSFTし、正解手順と照合できるチェスパズル環境でGRPOによるRLを行う。さらに、RL後のpolicy変化を「既に高確率だった正解手の増幅」と「SFTではほぼ出ていなかった正解手の発見」に分けて解析している。
- **どうやって有効だと検証した？**: チェス領域でモデルサイズとpretraining量、RL computeを系統的に変え、pass@1などの下流性能とpretraining lossの関係を評価した。加えて、easy/hard puzzle別にRLが正解手・誤手の確率分布をどう変えるかを分析。外部妥当性として、1B OLMo-2系モデルをmath-domain textで10B〜200B tokens事前学習し、SFT後にGSM8K/MATH/DeepScaler系データでRLする実験でも、同様の予測パターンが出ることを確認している。
- **議論はある？**: チェスは行動空間と報酬が明確なため解析しやすい一方、自然言語reasoning全般への一般化はまだ限定的。math実験は質的な追試に近く、frontier-scale LLMで同じ法則がどこまで保つかは未検証。また、RLはhard puzzleで正解手を発見する一方、誤った高確率モードも強めるため、pass@1改善が探索範囲やpass@k改善に直結しない。
- **次に読む/試すなら**: 
  1. 公開コード・モデルでpretraining lossからRL到達性能を予測するfitを再現する。
  2. 自分のreasoning taskで「RLがsharpeningしているのか、tail discoveryしているのか」をpass@kと候補分布で見る。
  3. weak pretraining checkpointからRLを始めた場合の利得飽和を確認する。
- **キーワード**: `pretraining`, `reinforcement learning`, `reasoning`, `scaling law`, `GRPO`, `verifiable rewards`, `chess`, `post-training`

## 気になったこと

- チェスで得たcompute allocation frontierが、自然言語の数学・コード・長文推論でも同じ形になるか。
- 「wrong-mode amplification」を抑えるRL objectiveやsampling strategyは何が有効か。
- 合成reasoning traceの品質や深さが、RL後のtail discoveryにどの程度効いているか。
- pass@1改善とpass@k停滞のズレを、実運用の推論時sampling設計にどう反映するべきか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [shen2026-kt-understanding-reasoning-from-pretraining-to-post-training-028733e6.md](../../chat/2026-07-22/shen2026-kt-understanding-reasoning-from-pretraining-to-post-training-028733e6.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
