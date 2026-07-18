# Chat Prompt 2026-07-19

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Jointly generating and attributing answers using logits of document-identifier tokens

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-19 - Jointly generating and attributing answers using logits of document-identifier tokens

## 基本情報

- **タイトル**: Jointly generating and attributing answers using logits of document-identifier tokens
- **著者**: Lucas Albarede, Jose G. Moreno, Lynda Tamine, Luce Lefeuvre
- **年 / venue**: 2025 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2508.08942 / arXiv:2508.08942

## 落合陽一フォーマット

- **ひとことでいうと**: RAGで回答を生成しながら、各文がどの検索文書に依存しているかを、文書IDトークンのlogitから同時に推定するLoDITを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来の引用生成やpost-hoc attributionは、もっともらしい出典を後から付けるだけで、モデルが実際にどの文書を使ったかというfaithfulnessが弱い。LoDITは生成中の内部信号であるdocument-identifier token logitsを使い、追加の複数回推論を避けつつ、回答生成と帰属推定を同時に行う点が新しい。Trust-Align上でMIRAGEやTrust-Align fine-tuning系baselineを複数指標で上回ったと報告している。
- **技術や手法の肝はどこ？**: 検索文書ごとに特定の識別トークンを付け、回答トークン生成時にその識別トークンのlogitを見ることで、各文書の寄与をtoken-levelで推定する。さらにselection biasやtoken biasを抑えるため、回答生成とattributionをjoint fine-tuningし、token-level contributionをtop-k pooling的に集約してstatement-level attributionに変換する。
- **どうやって有効だと検証した？**: Trust-Align benchmarkを使い、ASQA、QAMPARI、ELI5の3データセットで評価。指標はF1AC、F1GR、F1GC、TRUSTなど。LoDITは特にTRUST scoreで強く、例としてmarking BAではASQA 70.86、QAMPARI 47.63、ELI5 48.94を示している。ablationではdebiasingを外すと大きく性能低下し、aggregationやlogit debiasingの設計が効いていることを確認している。latency比較ではablate-repeat型より低遅延で、KL-probability型よりTRUSTが高いとされる。
- **議論はある？**: PDF本文によると、文書数は学習時設定の5文書に近いほど性能が高く、文書数が増減すると落ちるため、context lengthへの完全な汎化は未解決。識別トークンや文書順には比較的robustとされるが、訓練設定への依存は残る。コードは「available after notification」とあり、メタデータからは現時点の再現容易性は不明。細かな数値はPDF抽出テキスト由来のため、表の原本確認が必要。
- **次に読む/試すなら**: Trust-Alignの評価定義を読む。LoDITのmarking strategyを自前RAGで再現できるか確認する。MIRAGEやContextCiteと同じ生成結果に対してattribution差分を比較する。
- **キーワード**: `RAG`, `attribution`, `faithfulness`, `document-identifier tokens`, `logits`, `Trust-Align`

## 気になったこと

- 文書IDトークンのlogitが「因果的寄与」と言える範囲はどこまでか。logit相関と実際のcontext relianceの切り分けが気になる。
- fine-tuning前提なので、black-box API型LLMやclosed modelでどこまで使えるかは不明。
- context文書数が訓練設定に依存するなら、実運用の可変長retrievalでどう安定化するかを確認したい。
- 文書IDトークンの選び方、tokenizer依存、複数token IDになった場合の扱いが実装上の重要点になりそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
