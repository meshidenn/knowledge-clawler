# Chat Prompt 2026-08-13

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Evo-Bench: Can Language Models improve agent harness?

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-13 - Evo-Bench: Can Language Models improve agent harness?

## 基本情報

- **タイトル**: Evo-Bench: Can Language Models improve agent harness?
- **著者**: Lisheng Huang, Chen Yang, Hao Zhou, Huatong Song, Zongchao Chen, Ran Le, Yang Song, Wayne Xin Zhao, Tao Zhang
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2608.09096v2 / arXiv:2608.09096v2

## 落合陽一フォーマット

- **ひとことでいうと**: LLMが agent harness、つまりエージェントの実行ループ・ツール利用・文脈管理・検証手順などを自律的に改善できるかを測るためのベンチマーク「Evo-Bench」を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の agent benchmark は固定 harness 上でのタスク解決能力を測るものが多いが、この論文は「モデルが harness 自体を改善する能力」を分離して測ろうとしている。固定 policy model、可視 validation / 非公開 evaluation、harness sensitivity に基づくタスク選別により、単なる基盤モデル性能やタスク過適合との混同を減らす設計になっている。
- **技術や手法の肝はどこ？**: 補助タスク上で複数モデルに harness evolution を走らせ、得られた 12 個の代表 harness を使って各タスクの harness sensitivity と difficulty を推定する点。感度が高いタスクだけを Search、Office、General の3領域から選び、160 validation / 448 evaluation に分ける。評価では evolver model が seed CodeAct harness を最大20 iteration、48時間、1000 step の制約内で改善する。
- **どうやって有効だと検証した？**: 9つの frontier / open-weight model を evolver として評価。固定 policy model は主に DeepSeek-V4-Flash。GPT-5.6 Sol は CodeAct baseline 29.7 から Overall 46.3 へ +16.6、Claude Opus 4.8 は 45.8 へ +16.1 改善し、人手設計の Artificial harness 47.5 に近づいた。Search では大幅改善、General では一部モデルが人手 harness を上回る一方、Office は専門的 workflow が必要で改善が小さい。別 policy model への移植でも性能向上が残り、進化した harness が単一 policy への過適合だけではないことを示している。
- **議論はある？**: 限界はかなり明確。第一に、スコア変化への反応が表層的で、ログから因果的な失敗モードを深く抽出できていない。第二に、cross-domain interference を domain routing で回避しがちで、汎用的な共有機構の発見には弱い。第三に、budget を人間のエンジニアほど粘り強く使い切れていない。さらに、評価は LLM-as-a-Judge を含み、PDF抽出上の表や数式には崩れがあるため細かい数値は慎重に見るべき。
- **次に読む/試すなら**: 1. 自分の agent harness に対して validation / held-out split を作り、harness sensitivity の高いタスクだけで小型 Evo-Bench を再現する。2. evolved harness の差分を分析し、web tools、domain router、verifier、context manager のどれが効いているか ablation する。3. Office 系タスクで人手 workflow と自動進化 workflow の失敗差分を重点的に見る。
- **キーワード**: `agent harness`, `harness evolution`, `LLM agent`, `benchmark`, `CodeAct`, `self-improvement`, `tool use`, `validation-evaluation split`

## 気になったこと

- harness sensitivity は有用そうだが、Pearson correlation によるタスク選別が「進化しやすいタスク」へ評価を寄せすぎないか。
- Office 領域で改善が小さい理由は、ツール不足なのか、ファイル形式理解なのか、業務手順の暗黙知不足なのかを分解したい。
- evolved harness が transfer するという主張は重要なので、policy model だけでなく task distribution が変わった場合の頑健性も見たい。
- 人手 Artificial harness が composite baseline なので、単一の汎用人手 harness と比べたときの差も気になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
