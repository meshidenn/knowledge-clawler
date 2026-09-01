# Chat Prompt 2026-09-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {TTPO}: Test-Time Policy Optimization

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-02 - TTPO: Test-Time Policy Optimization

## 基本情報

- **タイトル**: TTPO: Test-Time Policy Optimization
- **著者**: Aozhe Wang, Zhengxi Lu, Jianze Wang, Shangke Lv, Ying Liu, Weiming Lu, Jun Xiao, Yueting Zhuang, Hua Yang, Qianglong Chen, Yongliang Shen
- **年 / venue**: 2026 / arXiv [cs.CL]（Preprint）
- **リンク**: [arXiv:2608.27448](https://arxiv.org/abs/2608.27448) / [PDF](https://arxiv.org/pdf/2608.27448) / [Code](https://github.com/ZJU-REAL/TTPO)

## 落合陽一フォーマット

- **ひとことでいうと**: 正解ラベルなしのTest-Time Trainingで、多数決と一致する軌跡は自己蒸留し、不一致な軌跡だけをRLで罰することで、誤った疑似ラベルへの過適合を抑えるTTPOを提案した。
- **先行研究と比べてどこがすごい？**: TTRLのような多数決ベースRLは誤った多数派を強化しうる一方、疑似ラベルをそのまま自己蒸留に使うと誤りが全トークンへ広がる。TTPOはこの非対称性を利用し、正例にはOPSD、負例にはGRPOを割り当てる。ラベルなしで、5つの数理競技ベンチマークにおいてラベル教師ありOPSDと同等以上を報告している。
- **技術や手法の肝はどこ？**: 各問題から複数のrolloutを生成し、多数決回答と一致する集合を正例、不一致集合を負例に分割する。正例は疑似回答を特権情報として与えたteacherとのforward KLで蒸留し、studentのエントロピーとteacher–student乖離が低い既学習トークンは重みを下げる。負例はGRPOの負のadvantageで抑制しつつ、確信度が高く低確率な異常トークンだけをマスクして罰する。
- **どうやって有効だと検証した？**: Qwen3-1.7B/4B/8BをLoRAで学習し、AIME 2025/2026、HMMT 2025/2026、BRUMO 2025でAvg@12を評価した。純粋なTTTではQwen3-1.7Bが平均38.0%から45.2%へ向上し、TTRL（40.2%）とOPSD-TTT（41.9%）を上回ると報告する。トークン重み付け・マスクのablation、異なるベンチマークで学習して別ベンチマークへ評価するcross-task実験も行っている。
- **議論はある？**: 多数決品質に依存し、rollout数が少ない場合や全rolloutが誤答となる難問では教師信号自体が劣化する。対象は最終回答を抽出・照合しやすい数理問題に限られ、コード生成や自由形式推論への一般化は未検証。RLと蒸留の比率も固定であり、学習進行に応じた最適な動的制御は今後の課題である。
- **次に読む/試すなら**:
  - TTRL、OPSD、OPSD-TTTの原論文と比較し、疑似ラベルの誤りが各方式でどこまで伝播するか整理する。
  - 小規模な数学データで、正例のみ蒸留・負例のみRL・TTPOを比較する最小ablationを再現する。
  - 多数決の一致率やanswer-clusterの分散を用いた、低信頼時の更新停止・RL比率調整を試す。
- **キーワード**: `test-time training`, `test-time policy optimization`, `on-policy self-distillation`, `GRPO`, `pseudo-label`, `mathematical reasoning`

## 気になったこと

- 「疑似ラベルが誤っていても不一致rolloutの多くは誤答」という経験的性質は、モデル規模・問題難度・サンプリング温度が変わっても維持されるか。
- 多数派と一致する正例にも誤答が含まれる場合、answer-conditioned teacherによる蒸留がどの程度「無害」といえるか。
- 評価問題そのものをTTTに使う設定では、計算予算やrollout数を含む実運用上の公平な比較条件を追加で確認したい。
- 数式回答の同値判定や最終回答抽出の失敗が、疑似ラベル品質と報告性能へ与える影響を知りたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
