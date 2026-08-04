# Chat Prompt 2026-08-05

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Gated {DeltaNet}-2: Decoupling erase and write in linear attention

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-05 - Gated DeltaNet-2: Decoupling erase and write in linear attention

## 基本情報

- **タイトル**: Gated DeltaNet-2: Decoupling erase and write in linear attention
- **著者**: Ali Hatamizadeh, Yejin Choi, Jan Kautz
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2605.22791 / PDF: https://arxiv.org/pdf/2605.22791.pdf / Code: https://github.com/NVlabs/GatedDeltaNet-2

## 落合陽一フォーマット

- **ひとことでいうと**: Linear attentionの固定サイズメモリにおける「消す」と「書く」を別々のchannel-wise gateで制御し、長文検索性能を上げるGated DeltaNet-2を提案した論文。
- **先行研究と比べてどこがすごい？**: Gated DeltaNetやKDAでは、delta ruleのactive editを1つのscalar gateで制御しており、古い内容をどれだけ消すかと新しい値をどれだけ書くかが結びついていた。本研究はerase gate `b_t` と write gate `w_t` を分離し、KDAのchannel-wise decayを保ったまま表現力を上げる。1.3B parameters、FineWeb-Edu 100B tokensで、Mamba-2、Gated DeltaNet、KDA、Mamba-3系と比較し、language modeling、commonsense reasoning、retrievalで総合的に強い結果を報告している。
- **技術や手法の肝はどこ？**: Gated Delta Rule-2。decay後の状態から `b_t ⊙ k_t` 方向で古い内容を読み出して消し、`w_t ⊙ v_t` を `k_t` 方向に書き込む。つまりkey側のeraseとvalue側のwriteを別のchannel-wise gateにする。さらに、channel-wise decayをrank-one erase factorに吸収することで、chunkwise WY algorithmと効率的なparallel training、gate-aware backward passを維持している。
- **どうやって有効だと検証した？**: 1.3B規模のrecurrent-only / hybridモデルをFineWeb-Edu 100B tokensで訓練し、WikiText、LAMBADA、PIQA、HellaSwag、WinoGrande、ARC、OpenBookQA、Social IQa、BoolQなどで評価。retrievalではRULERのSingle / Multi-Key Needle-In-A-Haystack、さらにSWDE、FDA、SQuAD、TriviaQA、DROP、Natural Questionsを用いた実データ検索系評価も行っている。PDF本文上では、特にlong-context RULERのmulti-key retrievalで利点が目立つとされる。
- **議論はある？**: 主な限界は、評価が著者実装・同一訓練設定に依存しており、他スケール、他データ、他実装で同じ優位が保たれるかは追加確認が必要な点。固定サイズ状態の干渉を完全に解くわけではなく、erase/write gateの分離がどのタスクで本質的に効くのかの分析もまだ深掘り余地がある。PDF抽出テキストでは表の細部が崩れているため、細かな数値差は断定しない。
- **次に読む/試すなら**: 1. GitHub実装のkernel構成と既存KDA実装との差分を読む。 2. RULER MK-NIAHだけを小規模モデルで再現し、erase/write分離の効果を見る。 3. Gated DeltaNet、KDA、Mamba-3との状態更新式を並べて、自分のlong-context用途でどの制約が効くか確認する。
- **キーワード**: `linear attention`, `DeltaNet`, `Gated Delta Rule-2`, `channel-wise gate`, `long-context retrieval`, `RULER`, `fast weights`, `WY algorithm`

## 気になったこと

- erase gateとwrite gateを分けたことで、実際にどのlayer/head/channelで異なる振る舞いが出ているのか。
- multi-key retrievalの改善が、単なるparameter増・gate増によるものではなく、erase/write分離そのものに由来することをどこまでablationで示せているか。
- recurrent-onlyとhybridで、sliding-window attentionがどの程度retrieval性能を補っているか。
- Triton kernel、fp32 state、WY solve precisionなどの実装要件が、実運用の推論速度・メモリにどれくらい効くか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
