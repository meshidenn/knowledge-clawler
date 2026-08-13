# Paperpile Brief 2026-08-14 - InSight-doc: Agentic Visual Perception for Long-Document Understanding

## 基本情報

- **タイトル**: InSight-doc: Agentic Visual Perception for Long-Document Understanding
- **著者**: Kaican Li, Weiyan Xie, Lewei Yao, Jiannan Wu, Lanqing Hong, Yongxiang Huang, Nevin L. Zhang
- **年 / venue**: 2026 / arXiv [cs.CV]
- **リンク**: https://arxiv.org/abs/2608.10628v1 （arXiv:2608.10628v1）

## 落合陽一フォーマット

- **ひとことでいうと**: 長い文書を低解像度で俯瞰し、必要な箇所だけ高解像度にズームすることで、精度を保ちつつ高速・低コストに読むVLMエージェント。
- **先行研究と比べてどこがすごい？**: 外部Retrieverでページを選ぶのではなく、モデル自身がページ内の領域単位で証拠を探索・拡大する。固定高解像度入力やページ単位のcoarse-to-fine方式より、不要なvisual tokenを抑えつつ、複数ページ・複数領域にまたがる推論を行える設計である。
- **技術や手法の肝はどこ？**: 初期入力は低解像度ページ群とし、推論中にページ・領域説明・bounding boxを含むzoom-in呼び出しを生成する。元の高解像度画像から切り出したcropを文脈へ追加し、答えるまで反復する。17,913件のズーム軌跡でSFTし、19,236件の難例をGRPOでRL学習して、いつ・どこを拡大するかを身につける。
- **どうやって有効だと検証した？**: Qwen3-VL-8B-Instructをベースに、DUDE、MP-DocVQA、MMLongBench-Doc、LongDocURLで評価。低解像度設定では平均精度66.9%でベースラインより16.4ポイント向上したと報告する。70 DPIでは140 DPIのベースラインより高精度で、token数を66%、平均レイテンシを54%削減した。また、回答不能問題のF1や証拠領域へのcrop到達率も評価している。
- **議論はある？**: 検証はQwen3-VL-8B-Instructのみで、他バックボーンへの一般化は未確認。RL報酬は正誤の二値のみで、探索効率・根拠忠実性を直接最適化する報酬設計は未検証である。関連手法との一部比較はバックボーン、解像度、評価条件が異なるcross-paper比較であり、厳密な優劣とは断定できない。
- **次に読む/試すなら**:
  1. 公開コードとデータセットで、低解像度＋領域cropが自分のPDF群でも効くか検証する。
  2. zoom回数、crop面積、回答不能時の棄却率を監視し、精度・遅延・幻覚のトレードオフを測る。
  3. Doc-V⋆、CogDoc、VDocRAGと同一バックボーン・同一ページ予算で比較する。
- **キーワード**: `long-document VQA`, `agentic visual perception`, `coarse-to-fine reasoning`, `visual grounding`, `multimodal reinforcement learning`, `context rot`

## 気になったこと

- 二値正誤報酬だけで、なぜ証拠領域の到達率や停止挙動まで大きく改善するのか。reward hackingの有無を軌跡単位で確認したい。
- 元PDFの高解像度画像を常時参照できる前提のため、OCR品質・PDFレンダリング品質・画像化コストを含めた実運用の総遅延は別途測る必要がある。
- 低解像度で見落とした領域を探索候補にできない失敗、bounding boxの誤指定、表や数式の細部での性能を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [li2026-xi-insight-doc-agentic-visual-perception-for-long-document-unders-741f7d92.md](../../chat/2026-08-14/li2026-xi-insight-doc-agentic-visual-perception-for-long-document-unders-741f7d92.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
