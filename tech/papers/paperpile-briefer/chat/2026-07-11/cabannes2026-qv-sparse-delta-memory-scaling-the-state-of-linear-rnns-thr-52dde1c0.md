# Chat Prompt 2026-07-11

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Sparse Delta Memory: Scaling the state of linear {RNNs} through sparsity

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-11 - Sparse Delta Memory: Scaling the state of linear RNNs through sparsity

## 基本情報

- **タイトル**: Sparse Delta Memory: Scaling the state of linear RNNs through sparsity
- **著者**: Loïc Cabannes, Pierre-Emmanuel Mazaré, Gergely Szilvasy, Matthijs Douze, Maria Lomeli, Ilze Amanda Auzina, Justin Carpentier, Gabriel Synnaeve, Hervé Jégou
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.07386v1 / arXiv:2607.07386v1 / Code: https://github.com/facebookresearch/sparse-delta-memory

## 落合陽一フォーマット

- **ひとことでいうと**: Linear RNN / linear attention の固定計算量という利点を保ったまま、状態メモリを疎アクセス化して巨大化する Sparse Delta Memory（SDM）を提案した論文。
- **先行研究と比べてどこがすごい？**: Gated DeltaNet の密な key-value outer product 更新を、Product-Key Memory 的な top-k sparse read/write に置き換えることで、isoFLOP・同一パラメータ条件でも状態容量を桁違いに拡大できる点。PDF本文では、GDNより長文 recall / in-context learning が改善し、8B activated parameter・1T token超の訓練でも検証したと主張している。
- **技術や手法の肝はどこ？**: メモリを `N x d` の明示テーブルとして持ち、各時刻で全スロットを更新せず、PKM風の分解スコアから選ばれた `W` 個のwrite slotと `R` 個のread slotだけに gated delta rule を適用する。さらに初期メモリ `M0` を学習可能にし、context中の作業メモリだけでなく、事前学習知識を格納する parametric memory としても使う。
- **どうやって有効だと検証した？**: Full Attention、GDN、Mamba2系のbaselineと比較し、held-out text/code NLL、reasoning / commonsense task、RULERの長文検索タスク、最大128k tokenのlong-context fine-tuning、最大1M tokenのin-context learningを評価。1.4Bと8B規模のモデルで、SDMがGDNより長文recallに強く、学習済み初期状態ありのSDMがtraining lossや一般タスクでも改善することを示している。
- **議論はある？**: 疎メモリは計算量を抑える一方で、ランダムなgather/scatterが支配的になり、実装・GPU効率・メモリ帯域がボトルネックになり得る。Full Attentionを完全に置き換えるというより、SWAやFullAttnとのhybrid設計に依存している。RULERの一部タスクでは固定状態モデルに残る苦手さもあり、細かい数値はPDF抽出テキスト上では表崩れがあるため断定しすぎない方がよい。
- **次に読む/試すなら**:
  1. 公開コードでSDM layerのtop-k slot選択、chunk-wise training、memory-efficient backwardの実装を確認する。
  2. Gated DeltaNet / Mamba2 baselineに対して、小規模なcopy / retrieval taskで `W`, `R`, `N`, learned `M0` のablationを再現する。
  3. long-context agent memory用途で、KV cache削減とrecall劣化のトレードオフを実測する。
- **キーワード**: `Sparse Delta Memory`, `linear RNN`, `Gated DeltaNet`, `linear attention`, `Product-Key Memory`, `long-context recall`, `parametric memory`, `RULER`

## 気になったこと

- SDMの性能向上が「状態容量」由来なのか、「learned M0による追加パラメトリックメモリ」由来なのかを、実運用サイズでどこまで切り分けられるか。
- ランダムアクセス主体の疎メモリが、GPU/TPU上で本当にend-to-end latency改善につながるのか。
- Full Attentionなしの純SDM寄り構成で、reasoningやmulti-hop retrievalがどこまで維持されるか。
- slot利用率が高いことと、意味的に解釈可能なメモリ構造が形成されることは別なので、メモリ内容の解析が見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
