# Paperpile Brief 2026-07-26 - SearchOS-V1: Towards Robust Open-Domain Information-Seeking Agent Collaboration

## 基本情報

- **タイトル**: SearchOS-V1: Towards Robust Open-Domain Information-Seeking Agent Collaboration
- **著者**: Yuyao Zhang, Junjie Gao, Zhengxian Wu, Jiaming Fan, Jin Zhang, Shihan Ma, Yao Yao, Weiran Qi, Chuyan Jin, Guiyu Ma, Xingzhong Xu, Kai Yang, Ji-Rong Wen, Zhicheng Dou
- **年 / venue**: 2026 / arXiv [cs.AI]、arXiv:2607.15257v1
- **リンク**: https://arxiv.org/pdf/2607.15257 / https://antins-labs.github.io/SearchOS / https://github.com/antins-labs/SearchOS

## 落合陽一フォーマット

- **ひとことでいうと**: 長いWeb調査でエージェントが進捗・証拠・失敗履歴を見失う問題に対し、検索状態を外部化して共有する multi-agent 情報探索基盤 SearchOS を提案した論文。
- **先行研究と比べてどこがすごい？**: 検索を単なる会話履歴やプロンプト管理ではなく、引用付きの relational schema completion として定式化し、Frontier Task、Evidence Graph、Coverage Map、Failure Memory をシステム状態として持つ点が新しい。WideSearch では Item F1 80.3、GISA では Set F1 76.5 を報告し、評価対象の single-agent / multi-agent baseline を上回る。
- **技術や手法の肝はどこ？**: SOCM によって「未解決セル」「根拠付き事実」「カバレッジ」「失敗パターン」を永続状態に分離し、orchestrator / explore / search / writer agent がそれぞれ必要な射影だけを受け取る。さらに pipeline-parallel scheduling で空いた agent slot に未解決 gap を即時投入し、Search Tool Middleware Harness が tool call を監視して証拠抽出、引用固定、ループ検出、budget 制御を行う。
- **どうやって有効だと検証した？**: WideSearch と GISA で ReAct、Plan-and-Solve、Table-as-Search、A-MapReduce、Web2BigTable と比較。GLM-5 を agent backbone、Qwen3.5-35B-A3B を evidence extraction に使い、Max@3 で評価している。Ablation では固定 schema より search-time schema planning が高く、continuous scheduling は batch scheduling より時間・token・LLM calls を減らしつつ Item F1 を改善したと報告している。
- **議論はある？**: PDF本文上では明示的な limitations セクションは見当たらない。弱点としては、評価が特定 benchmark と特定 backbone 設定に依存すること、Max@3 が実運用コストをやや楽観的に見せる可能性、Evidence Extraction 自体の誤りが Coverage Map に伝播する可能性、280個の pre-built skills の構築・保守コストが大きそうな点がある。
- **次に読む/試すなら**: SearchOS の GitHub 実装で SOCM のデータ構造を見る。WideSearch/GISA のタスクを1つ選び、batch vs continuous dispatch の最小再現を作る。Table-as-Search、A-MapReduce、Web2BigTable と設計差分を比較する。
- **キーワード**: `multi-agent search`, `open-domain information seeking`, `relational schema completion`, `SOCM`, `Evidence Graph`, `Coverage Map`, `agent harness`

## 気になったこと

- Failure Memory の「失敗」と「探索すべき未確認領域」の境界をどう判定しているか。
- Evidence Graph の confidence / provenance tier / schema alignment が、実装上どれくらい rule-based でどれくらい model-based なのか。
- 280個の skill library は汎化性能の源泉なのか、それとも benchmark 依存の強い作り込みなのか。
- multimodal やログイン必須サイトに拡張したとき、access skill と引用 grounding がどこまで壊れずに動くか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhang2026-nz-searchos-v1-towards-robust-open-domain-information-seeking-c41ef5e7.md](../../chat/2026-07-26/zhang2026-nz-searchos-v1-towards-robust-open-domain-information-seeking-c41ef5e7.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
