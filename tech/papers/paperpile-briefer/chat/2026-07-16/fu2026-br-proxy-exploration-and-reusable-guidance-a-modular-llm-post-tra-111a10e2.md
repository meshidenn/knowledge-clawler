# Chat Prompt 2026-07-16

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Proxy exploration and reusable guidance: A modular {LLM} post-training paradigm via proxy-guided update signals

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-16 - Proxy exploration and reusable guidance: A modular LLM post-training paradigm via proxy-guided update signals

## 基本情報

- **タイトル**: Proxy exploration and reusable guidance: A modular LLM post-training paradigm via proxy-guided update signals
- **著者**: Daocheng Fu, Rong Wu, Yu Yang, Xuemeng Yang, Jianbiao Mei, Licheng Wen, Pinlong Cai, Yong Liu, Botian Shi, Yu Qiao
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.11505v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのpost-trainingで、重いprimary model自身に探索させず、軽量proxy modelで得た「更新方向」だけを抽出・再利用・転送するPUSTを提案した論文。
- **先行研究と比べてどこがすごい？**: PPO/GRPO系はpolicy explorationとalignmentが密結合で高コスト、OPDなどのdistribution matchingも強いteacher分布に依存する。PUSTはproxyの最適化前後の相対差分を信号として扱うため、弱いproxyから強いprimaryへのweak-to-strong転送、非同期生成、cache、再利用が可能になる。
- **技術や手法の肝はどこ？**: proxy初期方策とGRPO後proxy方策のtoken-level log-ratioを更新信号として抽出し、それをprimary modelのanchor方策上に移植する。さらにprimaryがすでに吸収した更新量をlog-ratioで測り、calibration coefficient λで過更新を抑える。
- **どうやって有効だと検証した？**: PDF本文によると、Qwen3 familyの1.7B/4B/8Bを使い、MathではDeepMath-103K、CodeではEurus-RL-CodeでproxyをGRPO探索し、Qwen3-8Bなどへ信号転送した。MathではPUST 4B→8Bが平均47.5で8B baseの17.3から大幅改善、Codeでも8B base平均55.9からPUST 4B→8Bで60.5へ改善。信号の再利用、推移的転送、λ感度、proxy探索品質も検証している。
- **議論はある？**: proxy由来信号はprimary自身が直接GRPOで探索した信号よりやや弱い。proxyとprimaryの能力差が大きいほどcalibrationが重要で、λが小さすぎると性能崩壊が起きる。最適λは状態やモデル差に依存し、adaptive calibrationは今後の課題。PDF抽出上、細かい表の数値はレイアウト崩れの可能性があるため過度な断定は避ける。
- **次に読む/試すなら**: PUSTのGitHub実装を確認する。小型Qwen系でproxy前後log-ratioを保存し、別モデルへの転送を最小再現する。λの固定値ではなくstate/token別adaptive calibrationを試す。
- **キーワード**: `LLM post-training`, `proxy exploration`, `PUST`, `GRPO`, `distribution matching`, `weak-to-strong transfer`, `update signal`

## 気になったこと

- proxy前後のlog-ratioを保存する場合、全vocabulary tokenを保持するのか、top-k近似で十分なのか。
- 転送信号がtask-specificにどれほど閉じているか、Math proxy信号が別reasoning taskへ効くか。
- λの最適化をvalidation sweepではなく、学習中に自動制御できるか。
- rewardがverifiableでないRLHF/RLAIF領域でも同じ設計が成立するか。
- Direct-OPDやweak-to-strong preference optimizationとの実装上・理論上の差分を追加確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
