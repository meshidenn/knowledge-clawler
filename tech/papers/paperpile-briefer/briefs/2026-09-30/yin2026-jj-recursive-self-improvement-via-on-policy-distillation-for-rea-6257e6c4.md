# Paperpile Brief 2026-09-30 - Recursive self-improvement via on-policy distillation for reasoning

## 基本情報

- **タイトル**: Recursive self-improvement via on-policy distillation for reasoning
- **著者**: Shangjian Yin, Zehao Zhao, Kavosh Asadi, Rui Liu, Yuchen Lu, Shike Mei, Hang Cui, Luke Simon, Zhouxing Shi, Hamed Firooz
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2609.30652

## 落合陽一フォーマット

- **ひとことでいうと**: 正解付きの推論を見せる教師モデルを学生モデルと一緒に更新し続け、自己修正能力を再帰的に強化する手法を提案した論文。
- **先行研究と比べてどこがすごい？**: OPSDでは正解を見られる教師を初期モデルのまま凍結するが、本論文のDynamic Co-Evolution（DCE）は学習後のチェックポイントを次ラウンドの学生・教師の双方に使う。さらに、推論が冗長化する問題にSelf-Refined Concise Learning（SRCL）を組み合わせる。Qwen3-8Bでは、4つの数学ベンチマークのAverage@12でDCE+SRCLが65.97%に達し、OPSDを35.62ポイント上回った。
- **技術や手法の肝はどこ？**: 学生は問題だけを見てオンポリシー推論を生成し、教師は同じ推論 prefix に正解も追加して次トークン分布を出す。Forward KLで学生を教師に蒸留した後、更新済みモデルを次ラウンドの教師にする。SRCLでは、モデル自身が生成した回答を短く書き直し、正解・自然終了・短さなどで検証できた書き直しだけを追加学習する。
- **どうやって有効だと検証した？**: Qwen3の8B、4B、1.7Bを用い、AIME24、AIME25、AIME26、HMMT25でOPSD、凍結教師、EMA更新、周期更新などと比較した。DCEでは教師のEOS確率が90.4%から41.3%に下がり、反省トークンの確率が32.8%から77.4%に上昇した。また、8K推論予算でもDCE+SRCLは35.07%を達成し、単純に出力を長くするだけでは性能が改善しないことを示した。
- **議論はある？**: 正解や検証器を利用できる数学タスクが中心で、一般推論・非検証可能タスクへの有効性はメタデータからは不明。教師更新により推論能力だけでなく誤りや冗長性も再帰的に増幅する可能性がある。性能は教師への正解の提示位置やデコード設定にも依存し、長いオンポリシー生成と複数ラウンドの学習コストも大きい。外部モデルや人手によるプロセス監督との比較、より広いタスクでの再現性は追加検証が必要。
- **次に読む/試すなら**:
  1. OPSDとDCEを同一の小規模数学データセットで再現し、教師更新頻度と性能の関係を測る。
  2. SRCLの「短い・正解・自然終了」フィルタを外したアブレーションを行い、どの条件が効いているか確認する。
  3. コード生成や検証可能なエージェントタスクにDCEを適用し、数学以外でも自己修正が強化されるか試す。
- **キーワード**: `on-policy distillation`, `self-distillation`, `recursive self-improvement`, `reasoning`, `reflection`, `test-time scaling`

## 気になったこと

- DCEの改善は、教師が正解を見られることによる情報量の増加と、教師を更新する再帰効果のどちらに主に由来するのか。
- 各ラウンドの計算コストと、凍結教師・EMA教師・周期更新との総学習コスト比較は十分か。
- SRCLが短い正解を学習することで、難問に必要な探索やバックトラックまで抑制しないか。
- 4つの数学ベンチマークで得られた自己修正能力が、未知の問題形式や非数学タスクにも転移するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは?
---

## 追加で聞く

- Chat prompt: [yin2026-jj-recursive-self-improvement-via-on-policy-distillation-for-rea-6257e6c4.md](../../chat/2026-09-30/yin2026-jj-recursive-self-improvement-via-on-policy-distillation-for-rea-6257e6c4.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
