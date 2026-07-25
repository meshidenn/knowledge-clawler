# Chat Prompt 2026-07-26

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Are Transformers able to reason by connecting separated knowledge in training data?

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-26 - Are Transformers able to reason by connecting separated knowledge in training data?

## 基本情報

- **タイトル**: Are Transformers able to reason by connecting separated knowledge in training data?
- **著者**: Yutong Yin, Zhaoran Wang
- **年 / venue**: 2025 / ICLR 2025（metadata上は arXiv [cs.AI]）
- **リンク**: https://arxiv.org/abs/2501.15857v8 / arXiv:2501.15857v8

## 落合陽一フォーマット

- **ひとことでいうと**: 学習時には分断された知識断片しか見ていないTransformerが、テスト時にそれらをつないで多段推論できるかを、FTCTという合成タスクで検証した論文。
- **先行研究と比べてどこがすごい？**: 自然言語タスクではなく、因果グラフ上の断片学習・連鎖テストという制御可能な設定を作り、compositional reasoningが「いつ出るか」と「内部で何が起きているか」を分離して調べている。特に、few-shot CoTが訓練分布にはない完全推論パスを提示しても性能を引き出せる点を示す。
- **技術や手法の肝はどこ？**: FTCT（Fragmented at Training, Chained at Testing）。頂点を知識点、辺を加減算関係として持つ因果グラフを作り、訓練では短いchild chainだけを与え、テストでは長いcomplete chainを復元させる。few-shot CoT例が頂点順序を与え、Transformerはin-context learningとparent retrievingを組み合わせる「underlying program」を学ぶ、という解釈を置く。
- **どうやって有効だと検証した？**: 合成データFTCT上で、zero-shotとfew-shot CoTを比較し、訓練断片長とテスト連鎖長の比率であるrelative knowledge ratio、モデル層数・head数などを変えて評価している。結果としてzero-shotでは弱く、few-shot CoTで大きく改善し、relative knowledge ratioが約0.3以上、かつ少なくとも2層2head程度のmulti-layer attentionが必要だと報告している。さらにattention heatmapとlinear probingでinduction headsとattention assignmentの関与を調べている。
- **議論はある？**: 実験は合成データ中心なので、実世界のLLMや自然言語コーパスにそのまま一般化できるとは限らない。CoT例が正しい頂点順序を与えるため、完全な自律的推論というより「正しい推論形式の模倣 + 値の復元」に近い可能性がある。PDF抽出上、細かな表・式・数値の完全確認は未実施。
- **次に読む/試すなら**: FTCTのGitHub実装を動かして、relative knowledge ratioと層数/head数の相転移を再現する。CoT例の順序を壊した場合に性能がどう落ちるかを見る。自然言語のmulti-hop QAで同様の「断片学習・連鎖テスト」設定を作れるか検討する。
- **キーワード**: `compositional reasoning`, `Chain-of-Thought`, `in-context learning`, `induction heads`, `synthetic task`, `Transformer interpretability`

## 気になったこと

- few-shot CoTが与える「正しい頂点順序」がどれほど強いヒントになっているのか。
- induction headsとparent retrievingの説明が、別データ分布や自然言語タスクにも残るのか。
- FTCTのrelative knowledge ratio 0.3という閾値が、グラフ構造・ノイズ量・演算種類を変えても安定するのか。
- 実装上は、値の演算精度と頂点順序の模倣精度を分けて評価したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
