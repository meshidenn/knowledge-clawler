# Paperpile Brief 2026-07-17 - Function-aware fill-in-the-middle as mid-training for coding agent foundation models

## 基本情報

- **タイトル**: Function-aware fill-in-the-middle as mid-training for coding agent foundation models
- **著者**: Yubo Wang, Jiarong Liang, Yuxuan Zhang, Xuye Liu, Cong Wei, Yuyu Zhang, Ping Nie, Wenhu Chen
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.12463 / arXiv:2607.12463 / PDF: https://arxiv.org/pdf/2607.12463.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: Coding agentの「action → observation → continuation」は通常コードの関数呼び出し構造に似ている、という見立てから、関数単位のFIMをmid-trainingとして入れることでSWE-Bench系の性能を上げる論文。
- **先行研究と比べてどこがすごい？**: ランダムspanのFIMではなく、AST/Program Dependency Graphを使って「複雑だが文脈から推測可能」な関数を選ぶ点が差分。Qwen2.5-Coder-Instruct 7B/14BとQwen3-8Bで、SWE-Bench-Verifiedに+2.8/+3.0/+3.2、SWE-Bench-Liteに+3.7/+4.0/+5.4の改善を報告している。R2E-Gym、SWE-Smith、SWE-Legoなど複数のpost-training pipelineでも効果を確認している。
- **技術や手法の肝はどこ？**: 関数呼び出しを「context、call/action、return/observation、continuation」の4段階として捉え、関数本体をFIMのmiddleとして復元させる。対象関数はProgram Dependency Graph、複雑度スコア、推測可能性スコア、difficulty penaltyで選ぶ。さらにGemini-3-Flashで生成したCoT rationaleと候補実装をフィルタし、FIM middle内に「rationale → body」として入れて学習する。
- **どうやって有効だと検証した？**: 968個のGitHub Python repositoryから、SWE-Benchとの重複を除いた約400K FIM samples、約2.6B tokensのcorpusを作成。Qwen2.5-Coder-Instruct 7B/14B、Qwen3-8Bをmid-trainingし、その後R2E-Gym/SWE-Smith/SWE-Lego系のagentic post-trainingを適用。SWE-Bench-Verified/Liteに加え、LiveCodeBench、OJBench、FullStackBench-EN、Terminal-Bench、tau-bench、BFCLでも評価している。
- **議論はある？**: 関数呼び出しとtool callの同型性は構造的な仮説であり、完全な同一性ではない。corpusはPython中心なので、多言語・大規模repository・非コードtool useへの一般化は追加確認が必要。CoT生成とフィルタにGemini-3-Flashを使うため、データ生成コストやteacher依存もある。PDF抽出上、細かい表の数値は一部崩れているため、詳細なablation値は原PDFで再確認したい。
- **次に読む/試すなら**: 1. 公開予定のFIM-Midtraining repositoryで選択pipelineとcorpus形式を確認する。2. 自分のPython codebaseでPDG + function-aware FIM sampleを小規模生成してみる。3. CoTあり/なし、single-function/multi-function maskのablationを再現する。
- **キーワード**: `fill-in-the-middle`, `coding agent`, `mid-training`, `SWE-Bench`, `program dependency graph`, `Qwen`, `tool use`

## 気になったこと

- 関数呼び出し構造がtool observation処理に効くという仮説は面白いが、どの種類のagent failureを減らしているのかを失敗分類で見たい。
- Gemini生成CoTの品質が性能改善にどれだけ寄与しているのか、純粋な関数単位FIMだけとの切り分けを深く確認したい。
- Python-only corpusでBFCLやtau-benchにも効くなら、言語ではなく「外部計算結果を受け取って継続する」表現が学習されている可能性がある。
- 実装するなら、まずはASTでcaller/callee/sibling edgeを作り、LoC・cyclomatic complexity・docstring・signature情報だけで簡易版selectorを作れるか確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [wang2026-nj-function-aware-fill-in-the-middle-as-mid-training-for-coding-f7e2bd06.md](../../chat/2026-07-17/wang2026-nj-function-aware-fill-in-the-middle-as-mid-training-for-coding-f7e2bd06.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
