# Paperpile Brief 2026-07-09 - Why multi-step tool-use reinforcement learning collapses and how supervisory signals fix it

## 基本情報

- **タイトル**: Why multi-step tool-use reinforcement learning collapses and how supervisory signals fix it
- **著者**: Yupu Hao, Zhuoran Jin, Huanxuan Liao, Kang Liu, Jun Zhao
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2606.26027 / PDF: https://arxiv.org/pdf/2606.26027.pdf / arXiv:2606.26027

## 落合陽一フォーマット

- **ひとことでいうと**: マルチステップ tool-use RL がなぜ突然崩壊するのかを、能力低下ではなく control token の確率スパイクによる構造崩壊として分析し、SFT や Process Reflection Supervision などの監督信号で安定化する方法を調べた論文。
- **先行研究と比べてどこがすごい？**: tool-use RL の失敗を単なる報酬設計・探索不足ではなく、`<tool_call>` や `<|im_end|>` のような特殊 token の過増幅が tool invocation 構造を壊す現象として切り分けている点。Qwen2.5-1.5B-Instruct と Qwen3-1.7B で、RL 単独、SFT+RL、Off-policy Supervision、Hint-based Guidance、Erroneous Trajectory Supervision、Process Reflection Supervision を比較している。
- **技術や手法の肝はどこ？**: 出力を Healthy Tool Call、Healthy Response、Text Polluted、Collapsed に分類し、RL 中に正常な tool call から汚染出力、最終的には `<tool_call><|im_end|>` のような無意味な終了列へ崩れる過程を見る。対策として、RL に監督信号を同期的に混ぜるだけでなく、RL 探索と SFT 的な構造補正を interleaved に入れる。特に PRS は、失敗軌跡から中間推論の反省文を作り、構文だけでなく tool use の論理的足場を学習させる。
- **どうやって有効だと検証した？**: BFCL-V3 の Base、Miss Func、Miss Param、Long Context で評価し、ACEBench で OOD 汎化も確認。Qwen2.5-1.5B では GRPO 単独が平均 0.0 まで崩壊する一方、PRS は平均 25.75、ETS は 20.0 まで改善。Qwen3-1.7B でも GRPO 単独は平均 1.5、ETS は 23.25、PRS は 19.5。学習率、KL、critic score、format/content OOD も分析している。
- **議論はある？**: 監督信号は in-distribution の安定性を上げるが、SFT は format overfitting を起こしやすく、ACEBench の format and content OOD では性能が落ちる。Qwen3 では thinking mode 用の `<think>\n\n</think>` と SFT データ形式の不一致が崩壊要因になり得る。データ規模は小さく、open-source の検証可能な tool-use 環境が限られるため、スケール時の挙動は未検証。
- **次に読む/試すなら**: ETS/PRS を小さな function-calling 環境で再現する。tool-call 構文 token の確率推移をログする評価器を作る。SFT 形式と RL sampling 形式を完全一致させた ablation を試す。
- **キーワード**: `tool-use RL`, `agentic reinforcement learning`, `structural collapse`, `control tokens`, `SFT`, `Process Reflection Supervision`, `BFCL-V3`, `ACEBench`

## 気になったこと

- 崩壊が「能力喪失ではなく format artifact」という主張は強いが、format を変えると回復する例がどの程度一般化するかは追加確認したい。
- PRS で gpt-5-mini を補助分析器として使っているため、再現性・コスト・教師モデル依存性が気になる。
- reward が state-based と response-based の両方で 1 のときだけ 1 になる設計なので、部分的に正しい長い tool trajectory の学習信号が薄くなっていないか確認したい。
- tool-call protocol ごとに特殊 token の設計を変えるだけで崩壊耐性が変わるかを見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [hao2026-rn-why-multi-step-tool-use-reinforcement-learning-collapses-and-cb2cb3cc.md](../../chat/2026-07-09/hao2026-rn-why-multi-step-tool-use-reinforcement-learning-collapses-and-cb2cb3cc.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
