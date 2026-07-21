# Paperpile Brief 2026-07-22 - ALiiCE: Evaluating Positional Fine-grained Citation Generation

## 基本情報

- **タイトル**: ALiiCE: Evaluating Positional Fine-grained Citation Generation
- **著者**: Yilong Xu, Jinhua Gao, Xiaoming Yu, Baolong Bi, Huawei Shen, Xueqi Cheng
- **年 / venue**: 2024 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2406.13375 / arXiv:2406.13375

## 落合陽一フォーマット

- **ひとことでいうと**: 文末引用だけでなく、文中のどの位置の引用がどのatomic claimを支えているかを評価するための自動評価フレームワークALiiCEを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のcitation generation評価は主にsentence-levelで、1文内に複数claimがある場合や引用位置が曖昧な場合を扱いにくかった。ALiiCEはdependency treeで文をatomic claimに分解し、位置つきfine-grained citationを専用に評価する点が新しい。
- **技術や手法の肝はどこ？**: citation markの近傍語をdependency tree上のcitation nodeとして対応づけ、複数citation node間のLCAを使って不要なsubtreeを削除・置換し、各引用が支えるclaimを抽出する。そのうえで、claim-levelのcitation recall、precision、引用位置の分散を測るCVCPを計算する。
- **どうやって有効だと検証した？**: ASQAとELI5のlong-form QAで、GPT-3.5、GPT-4、LLaMA-3-8Bなどの出力を評価。sentence-level指標との比較、parsing error分析、人手評価との整合性確認を行っている。人手評価ではALiiCEのrecall/precision rankingが人間判断と概ね一致し、Cohen’s kappaも高めと報告されている。
- **議論はある？**: dependency parsingに依存するため、構文解析ミスやレイアウト崩れた文への耐性が限界になりうる。CVCPは引用位置の分散を測るが、引用の「有用性」そのものとは直結しない。著者らも、既存のcitation quality指標は正しさを見てもutilityを十分見ないと指摘している。
- **次に読む/試すなら**: 1. GitHub実装でclaim parsing部分を確認する。 2. 自分のRAG出力にALiiCEをかけ、文末引用偏重かを測る。 3. citation utilityを別指標として追加できるか検討する。
- **キーワード**: `citation generation`, `fine-grained citation`, `long-form QA`, `dependency parsing`, `atomic claim`, `LLM evaluation`, `RAG`

## 気になったこと

- dependency treeベースのatomic claim抽出が、日本語や複雑な学術文の引用文脈でも安定するか。
- CVCPが高いほどよいとは限らないため、位置の分散と読者にとっての検証しやすさをどう結びつけるべきか。
- 「正しい引用」と「役に立つ引用」を分けて評価するなら、citation utilityの自動評価器が必要そう。
- ALiiCEを論文要約や研究メモ生成のcitation評価に転用できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [xu2024-os-aliice-evaluating-positional-fine-grained-citation-generation-bd5813ab.md](../../chat/2026-07-22/xu2024-os-aliice-evaluating-positional-fine-grained-citation-generation-bd5813ab.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
