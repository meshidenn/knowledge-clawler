# Paperpile Brief 2026-06-24 - Contrastive Preference Optimization: Pushing the boundaries of LLM performance in machine translation

## 基本情報

- **タイトル**: Contrastive Preference Optimization: Pushing the boundaries of LLM performance in machine translation
- **著者**: Haoran Xu, Amr Sharaf, Yunmo Chen, Weiting Tan, Lingfeng Shen, Benjamin Van Durme, Kenton Murray, Young Jin Kim
- **年 / venue**: 2024 / ICML 2024, arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2401.08417 / arXiv:2401.08417

## 落合陽一フォーマット

- **ひとことでいうと**: 中規模LLM翻訳モデルALMAを、参照訳を真似るSFTではなく、より良い訳を選び微妙に悪い訳を避けるContrastive Preference Optimizationで強化し、GPT-4やWMT優勝システム級まで押し上げた論文。
- **先行研究と比べてどこがすごい？**: 従来のSFTは「人手参照訳が常に正解」という前提に縛られるが、この論文はFLORES-200でも強い翻訳モデルの出力が参照訳を上回る例が多いと示し、参照訳模倣の限界を突く。ALMA-13B-LoRAに対して22K程度の並列文・LoRAの約12M学習パラメータだけで、WMT’21/’22/’23においてGPT-4やWMT winnersに匹敵または一部上回る性能を報告している。
- **技術や手法の肝はどこ？**: GPT-4、ALMA-13B-LoRA、人手参照訳の3候補を、KIWI-XXLとXCOMETのような参照なし評価器で採点し、最高スコアをpreferred、最低スコアをdis-preferredとしてペア化する。CPOはDPOを翻訳向けに効率化した目的関数で、良い訳の尤度を上げ、十分良いが欠落や細部ミスを含む訳を避けるように学習する点が肝。
- **どうやって有効だと検証した？**: FLORES-200由来の選好データを作り、ALMA-13B-LoRAをベースにCPOで追加学習。WMT’21、WMT’22、WMT’23の複数言語方向で、KIWI-XXL、XCOMET、COMET-22、sacreBLEUなどを用いて、ALMA、SFT、DPO、GPT-4、WMT winners、Google Translate、NLLB、MADLADなどと比較している。人手評価や、評価器を変えた選好データ、dis-preferredデータ品質のアブレーションも行っている。
- **議論はある？**: 参照なし評価器で選好データを作り、同系統の評価器で評価するため、metric biasの懸念は残る。著者らは別評価器や人手評価で補強しているが、全言語・全ドメインで一般化するかは未検証。dis-preferred訳も高品質であることが効いており、低品質な人工ノイズでは性能が落ちるため、選好データ作成コストと品質管理が重要。
- **次に読む/試すなら**: 1. ALMA-RのGitHub実装とCPO lossを確認する。 2. 自分の翻訳対象ドメインでGPT-4/既存MT/参照訳のtriplet選好データを小規模に作る。 3. COMET系以外の評価器・人手評価で同じ改善が出るか検証する。
- **キーワード**: `machine translation`, `LLM`, `CPO`, `DPO`, `preference optimization`, `ALMA-R`, `reference-free evaluation`, `COMET`, `WMT`

## 気になったこと

- 参照なし評価器がpreferred/dis-preferredを決めるため、評価器の癖に最適化していないかを別ドメインで確認したい。
- 「良いが完璧ではない」dis-preferred訳をどう安定して集めるかが実装上の鍵になりそう。
- CPOが翻訳以外の生成タスク、特に要約・校正・コード生成のような参照解が不完全な領域にも効くかを調べたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [xu2024-zk-contrastive-preference-optimization-pushing-the-boundaries-of-e58de77b.md](../../chat/2026-06-24/xu2024-zk-contrastive-preference-optimization-pushing-the-boundaries-of-e58de77b.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
