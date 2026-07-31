# Paperpile Brief 2026-08-01 - MindForge: Teaching small language models whole-life-cycle software engineering via source-free program synthesis

## 基本情報

- **タイトル**: MindForge: Teaching small language models whole-life-cycle software engineering via source-free program synthesis
- **著者**: Yihao Chen, Shi Chang, Khaled Chawa, Feng Lin, Boyuan Chen, Shaowei Wang, Ahmed E. Hassan
- **年 / venue**: 2026 / arXiv [cs.SE]
- **リンク**: https://arxiv.org/abs/2607.27146v1 / arXiv:2607.27146v1

## 落合陽一フォーマット

- **ひとことでいうと**: ソースコードを見せず、実行可能バイナリとドキュメントだけからCLIプログラムを再実装する環境を大量生成し、その長期開発軌跡で小型LLMを訓練する論文。
- **先行研究と比べてどこがすごい？**: SWE-bench系の「既存コードを修正する」訓練ではなく、仕様探索、設計、実装、デバッグ、検証までの whole-life-cycle を扱う。Qwen3.6-27BをMindForge軌跡でSFTし、ProgramBenchの平均test pass rateを37.98%から49.51%へ改善し、より大きなfrontier modelに近い性能を示した。
- **技術や手法の肝はどこ？**: open-source CLI repositoryを、ソース非公開のcleanroom環境へ変換する自動pipelineが中心。参照実行ファイルとsanitized documentationだけをagentに渡し、GLM-5.2 teacher agentでプログラム合成軌跡を収集する。さらに、infrastructure-noise recoveryとreasoning rewriteで、長い軌跡中の失敗や不整合を訓練データとして使える形に整える。
- **どうやって有効だと検証した？**: 2,235候補repositoryから最終的に562 unique programs、1,001 trajectoriesを構築し、973 trajectoriesでQwen3.6-27BをSFT。ProgramBench 200問で評価し、加えてRepoZero-C2Rust、DeepSWE、NL2Repo-Bench、SWE-bench Verified/Pro/Multilingual、FeatBenchなど未学習の7 benchmarkでも改善を確認した。行動分析では、fine-tuning後にturn数・tool call数が増えつつcommand failure rateが下がり、reasoningやfailure recoveryから実装編集へ移る比率も上がった。
- **議論はある？**: PDF本文ではcontamination分析をしているが、DeepSWEとSWE-bench Multilingualには少数repository overlapがあるため、完全に無関係とは言い切れない。成功軌跡は「buildable submission」を中心に残しており、hidden testでの完全正解を直接保証しているわけではない。PDF抽出テキスト上では、訓練コスト、teacher依存性、失敗軌跡をどこまで学習に使うべきかの詳細な限界は読み取りきれない。
- **次に読む/試すなら**: MindForgeの公開pipelineがあるなら、手元の小規模CLI群でsource-free環境を作れるか確認する。Qwen系以外のopen modelに同じtrajectory recipeを適用した場合の汎化を見る。失敗軌跡やpartial successを含めた訓練がProgramBenchでどう効くかを比較する。
- **キーワード**: `coding agents`, `program synthesis`, `source-free environment`, `software engineering agents`, `distillation`, `ProgramBench`, `SFT`

## 気になったこと

- source-free checkで「バイナリ内に元ソースが読める形で残っていない」ことをどの程度厳密に保証できるのか。
- buildable submissionだけを残す方針は、失敗からの学習信号を捨てすぎていないか。
- GLM-5.2 teacherの軌跡品質に強く依存しているため、teacher modelを変えたときの再現性が気になる。
- CLI中心の環境構築が、GUI、server、distributed system、library API中心のsoftware engineeringにどこまで拡張できるか。
- ProgramBenchでpass rateは大きく上がるが、完全解決率や保守性・コード品質の評価は別途見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [chen2026-pc-mindforge-teaching-small-language-models-whole-life-cycle-so-fa915f63.md](../../chat/2026-08-01/chen2026-pc-mindforge-teaching-small-language-models-whole-life-cycle-so-fa915f63.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
