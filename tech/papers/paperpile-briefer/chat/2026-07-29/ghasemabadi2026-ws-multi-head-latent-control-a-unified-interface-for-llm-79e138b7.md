# Chat Prompt 2026-07-29

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Multi-Head Latent Control: A unified interface for {LLM} agent decision making

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-29 - Multi-Head Latent Control: A unified interface for LLM agent decision making

## 基本情報

- **タイトル**: Multi-Head Latent Control: A Unified Interface for LLM Agent Decision Making
- **著者**: Amirhosein Ghasemabadi, Ruichen Chen, Bahador Rashidi, Di Niu
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: arXiv:2607.14277v1 / https://arxiv.org/pdf/2607.14277

## 落合陽一フォーマット

- **ひとことでいうと**: Frozen LLM/VLM の生成中 hidden state を読んで、「このまま答える」「強いモデルへ渡す」「質問する」「toolを使う」「棄権する」を軽量headで決める論文。
- **先行研究と比べてどこがすごい？**: 既存のrouterはpromptや入力特徴ベース、tool-use研究はbackbone fine-tuningや外部 orchestration 寄りだった。本論文はbackboneを凍結したまま、生成軌跡のlatent signalからinstance-levelな制御を出す。AndroidWorldで大モデルAPI costを最大90.7%削減し、複数benchmarkで27〜53%程度のcost削減を示す。
- **技術や手法の肝はどこ？**: Multi-Head Latent Controlとして、Capability HeadとResolution Headを分ける設計。Capability Headは最終層hidden-state trajectoryから現在モデルで十分かを予測し、不十分なら強いモデルへhandoffする。Resolution Headは中間層traceから、clarification / tool use / abstention / direct answerを判定する。direct answerは明示classではなく、介入signalが弱い場合のデフォルトとして扱う。
- **どうやって有効だと検証した？**: Qwen3-VL、Qwen3.5、Gemma系で、SimpleVQA、ScreenSpot-Pro、CharXiv、MathVerse、MathVista、MMLU-Pro、AndroidWorld、WHEN2CALL、TriviaQAを評価。routingでは小モデル単独より性能を上げつつ、大モデル常用よりcostを削減。WHEN2CALLではResolution Headがnative action choiceよりF1/accuracyを改善。TriviaQAではweb search判断の質が改善し、missed-needed web callsも減少。
- **議論はある？**: control headの学習には、backbone出力・hidden state収集・judge modelによるlabel作成が必要で、label品質に依存する。PDF抽出上、詳細な統計検定や失敗事例分析の厚みは限定的に見える。routing thresholdやcost前提はdeployment環境に依存し、hidden stateへアクセスできない商用APIモデルではそのまま使えない可能性がある。
- **次に読む/試すなら**: 1. GitHub実装でhidden-state extractionとhead構造を確認する。2. 自分のagent loopで「小モデル→大モデル」routingの最小実験を作る。3. GnosisやWhen2Call、RouteLLMとの比較軸を整理する。
- **キーワード**: `latent control`, `LLM agents`, `model routing`, `hidden states`, `tool use`, `abstention`, `frozen backbone`

## 気になったこと

- hidden stateにアクセスできるlocal/open-weight model前提なので、closed API中心のagent基盤でどう代替するか。
- Capability Headのlabelを外部judgeで作る場合、judge biasがrouting policyにどれだけ移るか。
- 「失敗しそう」というlatent signalが、domain shiftや新しいtool環境でも安定するか。
- prefix-time routingは実用上重要なので、200 tokenより短い早期handoffで性能劣化がどこまで許容できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
