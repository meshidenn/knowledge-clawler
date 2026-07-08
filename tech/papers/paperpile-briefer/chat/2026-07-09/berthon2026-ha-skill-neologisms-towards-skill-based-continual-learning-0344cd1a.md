# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Skill neologisms: Towards skill-based continual learning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - Skill neologisms: Towards skill-based continual learning

## 基本情報

- **タイトル**: Skill neologisms: Towards skill-based continual learning
- **著者**: Antonin Berthon, Nicolas Astorga, Mihaela van der Schaar
- **年 / venue**: 2026 / arXiv [cs.LG]、ICML 2026 Proceedings 記載あり
- **リンク**: https://arxiv.org/pdf/2605.04970

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの重みを更新せず、特定スキルを表す学習済みsoft tokenを語彙に追加することで、継続学習とスキル合成を狙う論文。
- **先行研究と比べてどこがすごい？**: LoRAやfine-tuningはcatastrophic forgettingやOOD合成の弱さがあり、prompt tuningは基本的にtask-specificで独立に学習したprefixを合成しにくい。本論文は「skill-centered dataset」と「vocabulary-level integration」により、独立に学習したスキルtokenをzero-shotで組み合わせられる点を主張する。
- **技術や手法の肝はどこ？**: 各スキルに対してsoft token列、つまりskill neologismを追加し、モデル本体は凍結したまま、そのスキルを必ず含むデータでtokenだけをSFTする。tokenは単なるprefixではなく語彙要素としてprompt内の意味的に適切な位置に挿入される。
- **どうやって有効だと検証した？**: まずXOR/XNOR実験で、既存語彙tokenが手続き的知識を持ち得ることを観察。次に数字列変換タスクでSHIFTやINV-POLを新規スキルとして学習し、LoRA、prompt tuning、skill neologismsを比較。skill neologismsはOODスキルとの合成や、SHIFTとINV-POLの独立学習tokenのzero-shot合成で良好だった。さらにSkill-Mixでmodus ponensとstatistical syllogismを対象に、自然言語スキルのzero-shot合成も確認している。
- **議論はある？**: かなりproof-of-concept寄り。スキルが明確に定義でき、skill-centered datasetを作れることが前提になる。soft token学習なので初期化、token長、learning rate、ラベルノイズに敏感で、訓練時は凍結モデル全体にbackpropするため大規模モデルでは計算コストも残る。
- **次に読む/試すなら**: 1. GitHub実装で数字列変換タスクを再現する。2. 自分の関心領域で「skill-centered dataset」を作れるか確認する。3. prompt tuningとの差が挿入位置によるものか、語彙統合によるものかを追加ablationで見る。
- **キーワード**: `skill neologisms`, `soft tokens`, `continual learning`, `skill composition`, `prompt tuning`, `LLM`

## 気になったこと

- 「skill」の境界を自然言語タスクでどう安定に定義するかが最大の実用上の論点。
- skill tokenが本当に手続き的知識を表すのか、単に訓練分布のshortcutを圧縮しているのかをもう少し検証したい。
- Skill-Mix評価はGPT-5 gradingに依存しており、評価器バイアスや再現性の確認が必要。
- token長が大きすぎるとOOD性能が落ちる結果は重要で、capacity制約が合成性のinductive biasになっている可能性がある。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
