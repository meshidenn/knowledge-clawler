# Paperpile Brief 2026-08-13 - On-Policy Self-distillation without any supervision

## 基本情報

- **タイトル**: On-Policy Self-distillation without any supervision
- **著者**: Yijiang Li, Bingyang Wang, Yijun Liang, Yunjie Tian, Di Fu, Nuno Vasconcelos
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2608.06296v2 / arXiv:2608.06296v2 / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのon-policy self-distillationを、正解ラベル・外部報酬・強い教師モデルなしに、モデル自身の複数rolloutの多数決一致だけで回すU-OPSDを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のOPD/OPSDは、強い教師モデル、ground-truth solution、環境feedbackなど外部supervisionに依存していた。本手法は「複数生成の一致」を内部confidence signalとして使い、完全にunlabeledな問題からtoken-level distillationを行う点が差分。AIME24、AIME25、HMMT25、MATH500、AMC23で、Qwen3 4B/8Bのnon-thinking modeではbaseから平均8.5%/10.7%改善し、OPSDも平均3.2%/2.3%上回ったと報告している。
- **技術や手法の肝はどこ？**: 各問題に対してモデル自身から複数rolloutを生成し、最終回答を抽出・正規化して多数決する。勝ち票の割合がself-consistency thresholdを超えた場合、その多数派回答に属するrolloutをpseudo-solutionとして使い、少数派・不一致rolloutのprefix上で、pseudo-solutionを条件にしたteacher分布をstudent分布へforward KLなどで蒸留する。つまり「自分が多数派として確信している解法」を使って、「自分が間違えた軌跡の各token判断」を修正する設計。
- **どうやって有効だと検証した？**: Qwen3の4B/8B、non-thinking/thinking mode、Qwen3-4B-Instruct-2507、Qwen3-30B-A3B-Instruct-2507を対象に、数学推論benchmarkのAIME24、AIME25、HMMT25、MATH500、AMC23で評価。base model、supervised SFT、GRPO、ground-truth付きOPSD、self-rewarding RL系と比較し、U-OPSDが多くの設定でbaseを改善し、supervised手法と同等または上回ると主張している。
- **議論はある？**: 多数決が正しいという仮定が中核なので、モデルが一貫して同じ誤答に収束する問題ではpseudo-solutionが汚染される可能性がある。数学問題のように最終回答を抽出・正規化しやすい領域では強いが、自由記述、コード、長期agent taskなどで同じ設計が効くかはメタデータおよび抽出本文からは十分には分からない。rollout数やthresholdに伴う計算コスト、pseudo-labelの品質管理も実装上の論点。
- **次に読む/試すなら**: 1. GitHub実装 `https://github.com/williamium3000/u-opsd` を確認してrollout数・threshold・KL clippingの設定を見る。2. 小さなQwen系モデルでMATH500の一部だけを使い、pseudo-solutionの正答率と学習後accuracyを分けて測る。3. 多数決が誤るケースを集め、confidence thresholdや回答抽出器の失敗が性能にどう効くか確認する。
- **キーワード**: `on-policy self-distillation`, `U-OPSD`, `self-consistency`, `pseudo-solution`, `LLM post-training`, `mathematical reasoning`

## 気になったこと

- 多数派回答が誤っている場合、token-levelに誤ったteacher信号を強く蒸留してしまうリスクをどう抑えているか。
- PDF本文ではpseudo-solutionとして「longest agreeing rollout」を使う記述があり、メタデータabstractの「shortest pseudo-solution」と食い違うため、実装側でどちらを採用しているか確認したい。
- 数学以外の、最終回答のcanonicalizationが難しいタスクで同じ仕組みが成立するか。
- rollout数Gとself-consistency threshold τの感度、計算コスト、データ効率のtrade-offを詳しく見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [li2026-qo-on-policy-self-distillation-without-any-supervision-f9dbf984.md](../../chat/2026-08-13/li2026-qo-on-policy-self-distillation-without-any-supervision-f9dbf984.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
