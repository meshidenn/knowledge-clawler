# Paperpile Brief 2026-07-09 - How do LLMs cite? A mechanistic interpretation of attribution in retrieval-Augmented Generation

## 基本情報

- **タイトル**: How do LLMs cite? A mechanistic interpretation of attribution in retrieval-Augmented Generation
- **著者**: Ian van Dort, Maria Heuss
- **年 / venue**: 2026 / arXiv [cs.IR]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: RAGにおけるLLMのインライン引用が、実際に参照文書を使った結果なのかを、activation patchingで機械論的に調べた論文。
- **先行研究と比べてどこがすごい？**: 引用のfaithfulnessを外部評価だけで見るのではなく、Llama-3.1-8B-Instruct内部のattention headとMLP layerに分解して、引用付与の計算経路を特定しようとしている点。単一部品ではなく、分散した多段階の「attributional ensemble」として引用機構を捉えている。
- **技術や手法の肝はどこ？**: PopQAベースの制御環境で、引用を付ける/付けない判断に関わるactivationをpatchingし、重要なheadやMLPを同定する。さらに、それらの活性を増幅・減衰させることで、引用漏れや誤引用を操作できるかを検証している。
- **どうやって有効だと検証した？**: abstractによると、PopQAで引用漏れの90%以上を修復し、誤引用の69%を除去しつつ、回答精度は損なわなかったとされる。HotpotQAでも効果は小さいが、同じコンポーネント群が引用率を意図した方向に動かしたと報告している。PDF本文は未取得のため、実験設定・統計的有意性・具体的な比較条件の詳細はメタデータからは不明。
- **議論はある？**: インライン引用が「モデルが本当にその文書を根拠にした」ことを保証しない可能性がある。PopQAでは強い効果がある一方、HotpotQAでは効果が限定的であり、複数文書・複雑推論では機構の一般化に課題が残る。PDF本文がないため、失敗例、再現性、prompt依存性、モデルサイズ依存性は不明。
- **次に読む/試すなら**: Llama-3.1-8B-InstructでPopQAの最小実験を再現する。HotpotQAで効果が弱まる原因を、multi-hop性・文書数・citation形式ごとに切り分ける。引用faithfulness評価の既存研究と照合する。
- **キーワード**: `RAG`, `citation faithfulness`, `mechanistic interpretability`, `activation patching`, `Llama-3.1`, `PopQA`, `HotpotQA`

## 気になったこと

- 「引用を付ける内部機構」と「実際に根拠文書を使って答えを生成する機構」はどこまで一致しているのか。
- 重要head/MLPの操作が回答精度を保つとしても、回答内容の根拠利用そのものを改善しているのか、それとも citation behavior だけを調整しているのか。
- 他モデル、長文コンテキスト、複数引用、矛盾文書、no-answer設定でも同じattributional ensembleが見えるのか。
- PDF未取得のため、手法の詳細、介入の強度、評価指標、baseline、再現用コードの有無を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [van-dort2026-av-how-do-llms-cite-a-mechanistic-interpretation-of-attribu-08852ce6.md](../../chat/2026-07-09/van-dort2026-av-how-do-llms-cite-a-mechanistic-interpretation-of-attribu-08852ce6.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
