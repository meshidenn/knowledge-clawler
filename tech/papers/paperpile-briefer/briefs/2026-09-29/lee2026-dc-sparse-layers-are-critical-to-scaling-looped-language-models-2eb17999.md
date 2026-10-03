# Paperpile Brief 2026-09-29 - Sparse layers are critical to scaling looped language models

## 基本情報

- **タイトル**: Sparse layers are critical to scaling looped language models
- **著者**: Ryan Lee, Jacob Biloki, Edward J. Hu, Jonathan May
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2605.09165v2

## 落合陽一フォーマット

- **ひとことでいうと**: 同じTransformer層を繰り返し使うlooped language modelでは、Mixture-of-Experts（MoE）を組み合わせることで、パラメータ効率とスケーリング性を改善できることを示した論文。PDF本文は取得できず、以下は主にabstractベース。
- **先行研究と比べてどこがすごい？**: denseなlooped modelは通常のTransformerほどスケールしない一方、Looped-MoEは標準モデルを上回るスケーリングを示す。共有層を再利用しながら、ループごとに異なるexpertを選ぶことで表現力を回復する点が新しい。
- **技術や手法の肝はどこ？**: 同じ層を複数回通す構造にMoE routingを導入し、各ループで異なるexpertを活性化する。さらに、各ループの終端をearly exitの候補にする。最終出力を生成する層と同じ構成を通るため、ループ境界で出力が早く収束すると考えられる。
- **どうやって有効だと検証した？**: standard Transformerとlooped Transformerを、denseおよびMoE構成で比較し、スケーリング挙動とcompute-quality trade-offを評価した。early exitについては、ループ境界での出力収束が通常の途中地点より早いことを確認したとされる。詳細なデータセット、モデル規模、数値結果はメタデータからは不明。
- **議論はある？**: PDF本文がないため、実験条件、比較対象の公平性、expert routingの詳細、early exit時の品質劣化、再現性は未確認。ループ間のrouting divergenceがどの規模・タスクでも表現力向上につながるか、またroutingコストや実運用時の負荷が十分に評価されているかは要確認。
- **次に読む/試すなら**:
  1. arXiv本文で、モデル規模・学習データ・評価タスク・具体的なスケーリング曲線を確認する。
  2. 小規模Transformerで、dense loopingとLooped-MoEの品質・計算量・メモリを比較する。
  3. ループ境界ごとのearly exitと、信頼度ベースのexit条件を実装して品質劣化を測る。
- **キーワード**: `looped language models`, `Mixture-of-Experts`, `early exit`, `routing divergence`, `scaling laws`

## 気になったこと

- ループごとに異なるexpertが選ばれることが、単なる確率的な揺らぎではなく、どの程度の追加表現力を生むのか。
- MoEのexpert数、capacity、routing方式によって結果がどれほど変わるのか。
- early exitによる推論高速化と、MoE routing・expert通信のオーバーヘッドを合わせた実効的な速度・メモリ削減量。
- dense looped modelがスケールしにくい原因が、深さの再利用そのものなのか、最適化や学習設定にあるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは?
---

## 追加で聞く

- Chat prompt: [lee2026-dc-sparse-layers-are-critical-to-scaling-looped-language-models-2eb17999.md](../../chat/2026-09-29/lee2026-dc-sparse-layers-are-critical-to-scaling-looped-language-models-2eb17999.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
