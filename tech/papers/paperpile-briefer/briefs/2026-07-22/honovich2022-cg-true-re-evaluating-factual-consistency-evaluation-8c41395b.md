# Paperpile Brief 2026-07-22 - {TRUE}: Re-evaluating factual consistency evaluation

## 基本情報

- **タイトル**: {TRUE}: Re-evaluating factual consistency evaluation
- **著者**: Or Honovich, Roee Aharoni, Jonathan Herzig, Hagai Taitelbaum, Doron Kukliansky, Vered Cohen, Thomas Scialom, Idan Szpektor, Avinatan Hassidim, Yossi Matias
- **年 / venue**: 2022 / Proceedings of the 2022 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies
- **リンク**: https://aclanthology.org/2022.dialdoc-1.19.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: テキスト生成の factual consistency 評価を、要約・対話・事実検証・言い換えをまたぐ11データセットで統一的に再評価した論文。
- **先行研究と比べてどこがすごい？**: 従来は特定タスクやデータセット内で metric を評価しがちで、system-level correlation も多かった。本論文は既存データセットを binary factual consistency label に標準化し、example-level の ROC AUC で12種類の metric を比較している点が新しい。
- **技術や手法の肝はどこ？**: grounding text に対して target text が factual に一貫しているかを二値化し、inconsistent example detection として評価する。対象は FRANK, SummEval, MNBM, QAGS, BEGIN, Q2, DialFact, FEVER, VitaminC, PAWS など。評価 metric は NLI 系、QG-QA 系、埋め込み・生成スコア系などを横断比較する。
- **どうやって有効だと検証した？**: 11データセット上で ROC AUC を測り、bootstrap resampling による有意差検定も行った。結果として、大規模 NLI 系の ANLI / SummaC Zero-Shot と、QG-QA 系の Q2 が強く、ANLI は平均 AUC 81.5、SCZS は81.4、Q2 は80.7。これらを ensemble すると単体最良から平均 AUC がさらに約4.5上がる。
- **議論はある？**: 長い grounding text では性能が落ちる。hard example には annotation error も多く、全上位 metric が失敗した80例のうち35例にラベル誤りがあった。微妙な矛盾や、対話中の personal statement を factual claim として扱うかどうかも難所。PDF本文に基づく限り、多言語・data-to-text・multimodal は対象外。
- **次に読む/試すなら**: TRUE benchmark のコードとデータ形式を確認する。自分の生成タスクで NLI 系と QG-QA 系の両方を baseline にする。長文入力と personal statement を分けて評価する小さな再現実験を作る。
- **キーワード**: `factual consistency`, `hallucination evaluation`, `NLI`, `QG-QA`, `ROC AUC`, `TRUE benchmark`

## 気になったこと

- binary label への標準化でタスク横断比較はしやすくなるが、誤りタイプ別の改善方針は見えにくくならないか。
- QG-QA と NLI の ensemble が効く理由を、エラータイプ別にもう少し分解したい。
- LLM-as-a-judge 型の factuality 評価を TRUE 上で比較すると、NLI/QG-QA baseline をどれだけ超えるのか。
- personal statement を自動的に factual / non-factual に分離する前処理が、対話評価では重要そう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [honovich2022-cg-true-re-evaluating-factual-consistency-evaluation-8c41395b.md](../../chat/2026-07-22/honovich2022-cg-true-re-evaluating-factual-consistency-evaluation-8c41395b.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
