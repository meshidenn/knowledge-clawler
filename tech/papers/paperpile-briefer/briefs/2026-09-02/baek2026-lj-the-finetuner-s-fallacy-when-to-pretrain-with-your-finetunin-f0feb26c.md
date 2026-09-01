# Paperpile Brief 2026-09-02 - The finetuner's fallacy: When to pretrain with your finetuning data

## 基本情報

- **タイトル**: The finetuner's fallacy: When to pretrain with your finetuning data
- **著者**: Christina Baek, Ricardo Pio Monti, David Schwab, Amro Abbas, Rishabh Adiga, Cody Blakeney, Maximilian Böther, Paul Burstein, Aldo Gael Carranza, Alvin Deng, Parth Doshi, Vineeth Dorna, Alex Fang, Tony Jiang, Siddharth Joshi, Brett W. Larsen, Jason Chan Lee, Katherine L. Mentzer, Luke Merrick, Haakon Mongstad, Fan Pan, Anshuman Suri, Darren Teh, Jason Telanoff, Jack Urbanek, Zhengping Wang, Josh Wills, Haoli Yin, Aditi Raghunathan, J. Zico Kolter, Bogdan Gaza, Ari Morcos, Matthew Leavitt, Pratyush Maini
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2603.16177](https://arxiv.org/abs/2603.16177)

## 落合陽一フォーマット

- **ひとことでいうと**: 少量の専門データをfinetuningまで温存せず、pretraining段階から少割合で繰り返し混ぜる「Specialized Pretraining（SPT）」が、専門性能・汎用性能・推論時コストをまとめて改善しうることを示した論文。
- **先行研究と比べてどこがすごい？**: 継続事前学習やreplayではなく、「専門データをいつ投入するか」に焦点を当てた。ChemPile・MusicPile・ProofPileで、通常のpretraining→finetuningより低い専門領域テスト損失と少ない忘却を報告し、同等性能までの事前学習トークンを最大1.75倍削減した。web文書から遠い領域では、1BのSPTモデルが3Bの通常事前学習モデルを上回る結果も示す。
- **技術や手法の肝はどこ？**: pretraining全体のうち専門データの比率を \(\delta\) とし、一般Webデータと混合する。小規模な専門コーパスはpretraining中に何度も反復されるが、一般データとのインターリーブにより、finetuning単独より反復への過学習耐性が高まるという設計である。さらに、学習損失の低下と反復に伴うtrain-test gapの増大を組み合わせた過学習スケーリング則から、計算予算ごとの適切な混合率を予測する。
- **どうやって有効だと検証した？**: OLMo系の1Bモデルを中心に、各約3億トークンのChemPile・MusicPile・ProofPileを用い、200Bトークンのpretraining後に同じ専門データでfinetuningした。専門領域のhold-out損失、Dolma損失による汎用知識の保持、ChemBench・MusicTheoryBench・MATHの選択式評価、300M〜3Bのモデル規模比較、専門データ量・投入時期・混合率・replay条件を比較した。
- **議論はある？**: 実験は主にOLMo系と3領域に限られ、商用大規模モデル、実運用の私有データ、instruction tuningやRLHFとの相互作用は未検証である。最適な混合率は専門データ量・ドメイン距離・pretraining予算に依存し、早期投入が常に最適とは限らない。総コスト優位も推論量が十分大きい場合の償却を前提とする。
- **次に読む/試すなら**:
  - 自社ドメインで1〜5%の専門データ混合SPTを小規模pilotとして比較する。
  - 専門データのサイズとWebコーパスからの距離に応じて、混合率・投入開始時点を探索する。
  - 専門性能だけでなく、finetuning後の汎用ベンチマーク劣化と推論量込みのTCOを測る。
- **キーワード**: `specialized pretraining`, `domain adaptation`, `fine-tuning`, `catastrophic forgetting`, `scaling laws`, `data mixing`

## 気になったこと

- 専門データが機密情報を含む場合、反復混合によるmemorization・漏洩リスクはどう変化するか。
- 1〜5%という混合率を、ドメイン距離やデータ重複率から事前に推定できるか。
- SPTとLoRA、instruction tuning、RLHFを組み合わせたときも忘却抑制と専門性能向上が維持されるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [baek2026-lj-the-finetuner-s-fallacy-when-to-pretrain-with-your-finetunin-f0feb26c.md](../../chat/2026-09-02/baek2026-lj-the-finetuner-s-fallacy-when-to-pretrain-with-your-finetunin-f0feb26c.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
