# Chat Prompt 2026-10-03

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {MILO}: Automated harness discovery via orchestrated multi-agent evolution

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-10-03 - MILO: Automated Harness Discovery via Orchestrated Multi-Agent Evolution

## 基本情報

- **タイトル**: MILO: Automated Harness Discovery via Orchestrated Multi-Agent Evolution
- **著者**: Prithwish Jana, Mononito Goswami, Hao Liu, Xinyu Li, Langlin Huang, Zhehui Huang, Zhishen Huang, Patrick Blöbaum, Anoop Deoras, Purak Jain, Nikos Kanakaris, Sahika Genc
- **年 / venue**: 2026 / arXiv [cs.LG]（arXiv:2609.38349、2026年9月29日 v1）
- **リンク**: https://arxiv.org/abs/2609.38349

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントのプロンプト、ツール、メモリ、制御フローなどを含む「ハーネス」と、その探索戦略自体を同時に進化させる仕組みMILOを提案した。
- **先行研究と比べてどこがすごい？**: 既存手法がプロンプトやスキルの局所最適化、または固定的な探索戦略に偏るのに対し、MILOは複数の島（lineage）でハーネス全体を探索し、探索が停滞するとmutator、記憶、カリキュラムまで再設計する。Opus 4.8では、初期ハーネスに対する解決率の改善がTerminal-Bench 2.1で+12.0%、PaperBenchで+28.3%、DeepSWEで+10.3%となった。
- **技術や手法の肝はどこ？**: ①島ごとの階層的lineage memoryで成功例だけでなく棄却された変異も負の証拠として保持する、②島ごとのmutator agentが失敗トレースと親ハーネスの弱点を使ってハーネス全体を書き換える、③orchestrator agentが停滞時に島の graft、mutatorの再割り当て、探索カリキュラムの変更を行う、という二重ループ構造。評価は精度だけでなくトークン数・レイテンシも含むPareto最適化で行う。
- **どうやって有効だと検証した？**: Terminal-Bench 2.1、PaperBench、DeepSWEで、8種類の既存ハーネスと6種類の探索手法を比較し、Opus 4.8とgpt-oss-120bで評価した。Opus 4.8ではTerminal-Bench 2.1の解決率が86.1±2.0%で、公式リーダーボード上位の83.8±2.3%を上回った。また、TB2.1用に進化させたハーネスを未探索のFrontier-Benchへ転用しても、Best-of-3やMini-SWE-Agentを上回った。EinsteinArenaでは3つの数学問題で既知の上限を更新した。
- **議論はある？**: ハーネス評価には長時間・高コストの実行が必要で、探索計算量が実運用上のボトルネックになり得る。性能向上がどの構成要素に由来するかはアブレーションで確認されているが、対象ベンチマーク、基盤モデル、mutator群に依存する可能性は残る。複数ベンチマークで転用性は示されたものの、より多様なモデル・環境での独立再現性は本文からは不明。
- **次に読む/試すなら**:
  1. まずMILOのlineage memoryと棄却候補の扱いだけを実装し、単一ハーネスの探索と比較する。
  2. 成功率・トークン数・レイテンシの3目的Pareto評価を小規模なコーディングタスクで再現する。
  3. GEPA、Meta-Harness、EvoXと同一予算で比較し、orchestratorの寄与を切り分ける。
- **キーワード**: `automated harness discovery`, `meta-evolution`, `multi-agent evolution`, `lineage memory`, `LLM agents`, `Pareto optimization`

## 気になったこと

- ハーネス探索1回あたりの実際のAPI費用・実行時間と、性能向上との費用対効果。
- 棄却候補を増やし続けた場合のメモリサイズと、mutator agentのコンテキスト負荷。
- モデルやベンチマークを変えたとき、どの程度まで探索済みハーネスを再利用できるか。
- PDF本文ではMILOの実装詳細や一部の数値にレイアウト崩れ・数式欠落があるため、再現時は公式コードと付録の確認が必要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
