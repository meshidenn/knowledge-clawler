# Paperpile Brief 2026-06-17 - Smaller models are natural explorers for policy-level diversity in {GRPO}

## 基本情報

- **タイトル**: Smaller models are natural explorers for policy-level diversity in {GRPO}
- **著者**: Yiming Ren, Yiran Xu, Zicheng Lin, Chufan Shi, Yukang Chen, Dingdong Wang, Tianhe Wu, Junjie Wang, Yujiu Yang, Yu Qiao, Ruihang Chu
- **年 / venue**: 2026 / arXiv [cs.LG]（本文中に ICML 2026, PMLR 306 の表記あり）
- **リンク**: https://arxiv.org/pdf/2605.30789 （arXiv:2605.30789v2）。DOIはメタデータからは不明。コード: https://github.com/qishisuren123/S2L-PO

## 落合陽一フォーマット

- **ひとことでいうと**: GRPOで大規模モデルを強化学習する際、同系統の小さいモデルを「自然な探索器」として使い、初期ロールアウトの多様性を増やす S2L-PO を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来は温度を上げるなどトークン単位のランダム性で多様性を作っていたが、この論文は「小さいモデルは方策レベルで多様な解法を出す」という観察を使う。高温サンプリングのように推論列を壊しにくく、Qwen3 8Bでは AIME24 +8.8、AIME25 +10.4、MATH-500 +4.2、OlympiadBench +1.7 の Pass@1 改善を報告している。
- **技術や手法の肝はどこ？**: 固定した小モデルで初期ロールアウトを生成し、学習が進むにつれてロールアウト元を小モデルから大モデル自身へ線形にアニーリングする。小モデルだけに頼ると分布ずれで失速するため、探索は小モデル、最終的な搾り込みはオンポリシーGRPOに戻す設計が肝。
- **どうやって有効だと検証した？**: DAPO17kで学習し、AIME 2024、AIME 2025、MATH-500、OlympiadBenchで評価。Qwen3とInternLM2.5の2系列で検証し、CommonsenseQAでOOD評価も実施。さらに Self-BLEU、Edit Diversity、Unique Answer Ratioで小モデルほど多様であることを測り、多様性を除いた小モデルロールアウトでは性能がGRPO並みに戻ることを示している。
- **議論はある？**: 小モデルロールアウトだけでは中盤以降に失速し、分布ずれが問題になる。段階的アニーリングの長さも重要で、短すぎると不安定化する。理論解析は方策摂動の有利さを説明するが、Hessian alignmentなどの仮定は実モデルでどこまで一般化するか追加検証が必要。数学推論中心の評価なので、他ドメインでの効果はまだ限定的。
- **次に読む/試すなら**: S2L-POのコードで Qwen3 1.7B→8B の最小再現を確認する。自前GRPO実装の rollout sampler だけを差し替えられるか見る。小モデル選択を同一ファミリー内外で比較する。
- **キーワード**: `GRPO`, `RLVR`, `policy-level diversity`, `small-to-large policy optimization`, `rollout sampling`, `mathematical reasoning`

## 気になったこと

- 「小さいモデルほど探索が良い」は同一ファミリー・蒸留系列に依存していそうで、異種モデル混合でも成立するか。
- 小モデルの誤答が多い領域で、group-relative advantageがどの程度ノイズ化するか。
- アニーリングスケジュールを固定線形ではなく、報酬分散やKLで適応制御できるか。
- ロールアウト計算削減の実測値と、GPU構成が変わった場合の壁時計時間の改善幅。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [ren2026-cm-smaller-models-are-natural-explorers-for-policy-level-diversi-136ce5ce.md](../../chat/2026-06-17/ren2026-cm-smaller-models-are-natural-explorers-for-policy-level-diversi-136ce5ce.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
