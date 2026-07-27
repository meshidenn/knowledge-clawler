# Chat Prompt 2026-07-28

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {NVIDIA}-labs {OO} agents: Native Python object-Oriented Agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-28 - NVIDIA-labs OO Agents: Native Python Object-Oriented Agents

## 基本情報

- **タイトル**: NVIDIA-labs OO Agents: Native Python Object-Oriented Agents
- **著者**: Paul Furgale, Severin Klingler, James Nolan, Matt Staats, Gaia Di Lorenzo, Elisa Martinez Abad, Christian Schüller, Razvan Dinu, Alessio Devoto, Pascal Berard, Gal Kaplun, Elad Sarafian, Riccardo Roveri, Leon Derczynski, Ricardo Silveira Cabral
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2607.20709

## 落合陽一フォーマット

- **ひとことでいうと**: AI agentを「Pythonのobject」として定義し、method・field・docstring・type annotationをそのままagentの行動、状態、prompt、契約として使うNOOAというframeworkを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のagent開発はprompt template、tool schema、callback、workflow graphに分散しがちだが、NOOAはPython classという単一surfaceに統合する。特に、typed I/O、live objectのpass-by-reference、code as action、programmable loop engineering、explicit object state、model-callable harness APIの6要素を同時に扱う点を新規性として主張している。
- **技術や手法の肝はどこ？**: agentは通常のPython classで、通常bodyを持つmethodは決定的Pythonとして実行され、bodyが `...` のmethodはLLM-drivenなagentic methodになる。`PredictStrategy` は単発の型付き生成、`CodeActStrategy` はmodelがPython codeを書いてREPL的に実行し、最終的に型検証された値を返すloopとして動く。contextはstatic block、event history、dynamic blockに分けられ、状態や履歴をPythonic APIで扱える。
- **どうやって有効だと検証した？**: PDF本文では、targeted capability testに加えて、SWE-bench Verified、Terminal-Bench 2.0、CyberGym L1、ARC-AGI-3で評価している。SWE-bench VerifiedではNOOAがOpenCodeやPIなどのopen general-purpose harnessを上回る結果を報告し、ARC-AGI-3ではworld-model skillとmemory subsystemを組み合わせてscore-cost Pareto frontierを改善したと述べている。ただし、抽出テキスト由来のため細かい数値は再確認したい。
- **議論はある？**: benchmark結果は強いが、比較対象・model version・reasoning effort・cost条件に依存する。agentに任意Pythonを書かせる設計は強力な一方、sandbox、権限、再現性、評価時のcheat checkが重要になる。また「Python objectに寄せる」設計がPython以外のecosystemでも同じ価値を持つかは未検証。
- **次に読む/試すなら**: NOOAのGitHub実装を確認し、最小の `Agent` classで `PredictStrategy` と `CodeActStrategy` を試す。SWE-benchやTerminal-Benchではなく、小さな社内tool操作・論文要約・コード修正taskでtyped returnとpass-by-referenceの恩恵を検証する。比較対象として LangGraph, OpenAI Agents SDK, PydanticAI, smolagents の同等実装を並べる。
- **キーワード**: `AI agents`, `object-oriented agents`, `Python framework`, `CodeAct`, `typed I/O`, `agent harness`, `pass-by-reference`, `LLM agent evaluation`

## 気になったこと

- `...` bodyをagentic methodにする設計は読みやすいが、静的解析、IDE補完、lint、test doubleとの相性を確認したい。
- live objectをmodelに扱わせるとき、どこまでがmodel-visibleで、どこからがsecret/non-visibleなのかの境界設計が重要。
- benchmarkでの優位がframework設計によるものか、prompt・skill・sandbox・memory実装の作り込みによるものかを切り分けたい。
- Python objectに寄せることで開発者体験は良くなるが、agentの失敗時に通常の例外・tracebackだけで十分debugできるのかが気になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
