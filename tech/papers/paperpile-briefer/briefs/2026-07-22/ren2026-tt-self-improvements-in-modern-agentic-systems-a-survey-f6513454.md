# Paperpile Brief 2026-07-22 - Self-improvements in modern agentic systems: A survey

## 基本情報

- **タイトル**: Self-improvements in modern agentic systems: A survey
- **著者**: Zhe Ren, Yimeng Chen, Dandan Guo, Guowei Rong, Tonghui Li, R. B. Xiong, Qingfeng Lan, Wenyi Wang, Li Nanbo, Yibo Yang, Mingchen Zhuge, Jürgen Schmidhuber
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.13104v1 / arXiv:2607.13104v1

## 落合陽一フォーマット

- **ひとことでいうと**: Foundation Modelを中核にした現代のagentic systemが、自分の経験・評価・実行結果を使ってモデル本体やscaffoldを更新する「self-improvement」を、歴史・定義・分類・応用・評価の観点から整理したサーベイ。
- **先行研究と比べてどこがすごい？**: 既存サーベイがself-evolving agent、self-correction、meta-prompting、self-playなどを個別に扱いがちなところを、`At = (θt, Σt)` というシステム構成で統一している点が強い。更新対象をFoundation Modelのパラメータ `θ` と、prompt・memory・tool・control logicからなるscaffold `Σ` に分け、さらに改善信号の由来で整理することで、fine-tuning系とagent scaffold改善系を同じ地図上に置いている。
- **技術や手法の肝はどこ？**: self-improvementを「実行によって得た信号を、持続的な変更として自分自身にcommitするoperator」として定式化している。特に、短期的なcontext更新や会話履歴の蓄積ではなく、モデル重み・prompt・memory構造・tool interface・routing/control logicなど、将来の挙動を変える構成要素への永続的更新をself-improvementとみなす点がコア。
- **どうやって有効だと検証した？**: 本論文自体は新手法の実験論文ではなくサーベイ。PDF本文では、software engineering、web navigation、game/strategic reasoning、scientific discovery、embodied AI/robotics、general computer controlなどの応用領域と、mechanism-level benchmark / domain benchmark、metric-based / judge-based measurementという評価観点を整理すると述べている。ただし、抽出テキストからは各ベンチマークの詳細な数値比較までは確認できない。
- **議論はある？**: self-improvementは能力向上だけでなく、評価の汚染、報酬ハック、安全でないtool生成、scaffold更新のrollback、長期的な性能劣化、自己参照的な更新の制御可能性が問題になる。本文抽出は16ページ分で、Discussion以降の詳細はメタデータからは不明だが、abstractと目次からはevaluation、open problems、future directions、安全性が主要論点として扱われている。
- **次に読む/試すなら**: 1. 自分のagent実装を `θ` と `Σ = prompt, memory, tools, control logic` に分解して、どこを更新可能にしているか棚卸しする。 2. prompt改善・memory更新・tool生成のどれが最小のself-improvement loopとして実装しやすいか比較する。 3. arXiv本文のEvaluation章を読み、自己改善を測るためのbenchmark設計を抜き出す。
- **キーワード**: `self-improving agents`, `agentic systems`, `foundation models`, `scaffolding improvement`, `prompt optimization`, `memory`, `tool use`, `self-induced update`

## 気になったこと

- scaffold更新を「改善」と判定するための評価器は、どの程度agent自身から独立しているべきか。
- promptやtoolを自動更新するagentで、rollback・versioning・安全制約をどう設計するのが実用的か。
- `skill` を再利用可能なself-induced updateとして扱う定義は、Codex/Claude Codeのskillやtool運用にもそのまま対応しそう。
- Foundation Model ImprovementとScaffolding Improvementを組み合わせた場合、どちらの改善が性能変化に寄与したかをどう切り分けるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [ren2026-tt-self-improvements-in-modern-agentic-systems-a-survey-f6513454.md](../../chat/2026-07-22/ren2026-tt-self-improvements-in-modern-agentic-systems-a-survey-f6513454.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
