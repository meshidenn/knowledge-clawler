# Paperpile Brief 2026-08-18 - Thought-Level Beam Search for Reasoning

## 基本情報

- **タイトル**: Thought-Level Beam Search for Reasoning
- **著者**: Lijie Yang, Hongyin Luo, Jiawei Zhao, Tri Dao, Ravi Netravali
- **年 / venue**: 2026 / COLM 2026（arXiv: cs.AI）
- **リンク**: [arXiv:2608.08020v2](https://arxiv.org/abs/2608.08020v2)、[実装（Gambit）](https://github.com/Dao-AILab/Gambit)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの推論時に、良い途中思考を見つけてそこから枝分かれを増やす「思考ステップ単位のビームサーチ」により、精度・GPU利用率・トークン効率を同時に改善する手法 Gambit。
- **先行研究と比べてどこがすごい？**: Self-Consistencyの独立並列サンプリングはKVキャッシュを圧迫し、STEPなどの剪定法は空いた計算資源を再利用できない。Gambitは剪定した分を有望なprefixから即座に再分岐して、探索分布そのものを有望な解へ寄せる。STEPと同じMLP scorerを用いた比較でも、HMMT-24で最大+6.7ポイント、AIME-25で最大+3.3ポイントの精度向上を報告する。
- **技術や手法の肝はどこ？**: 一定数のactive traceを維持し、一定トークン間隔ごとに hidden state scorer で途中軌跡を評価する。低スコア軌跡をpruneし、上位prefixから同数をbranchするゼロサムな再配分を行う。初期推論のスコアは不安定なためwarmupを設け、物理KVキャッシュと論理的な探索木を分離して、単一prefixへの過度な集中も抑える。
- **どうやって有効だと検証した？**: vLLM上・単一NVIDIA B300（275GB）・各問題256 traceの制約で、Qwen3-4B-Thinking、DeepSeek-R1系8B、Phi-4-reasoning-plus-14Bを評価。AIME 2025/2026、HMMT 2024/2025、GPQA-DiamondでSC、Slim-SC、DeepConf、STEPと比較した。Phi-4ではHMMT-25でSC比68.5%のトークン削減を報告し、Qwen3-4Bでは完了trace throughputがSTEPの0.098から0.216 trace/sへ向上した。
- **議論はある？**: 成功は「途中prefixの品質をhidden stateから十分に順位付けできる」という仮定に依存する。warmup、swap数、評価間隔などの感度分析はあるが、主な評価は数学・科学推論ベンチマークと3モデルに限られる。また、prefixを誤判定すると誤った推論へのbranchが増えうる。実運用での多様な負荷・複数GPU環境・閉鎖モデルでの再現性はPDF本文からは不明。
- **次に読む/試すなら**:
  1. STEP、DeepConf、Slim-SCを読み、scorerの品質と「剪定のみ」の限界を比較する。
  2. vLLM上で、固定trace数のprune-and-branchとKV-cache共有を最小実装する。
  3. scorerの校正誤差と探索多様性が最終精度に与える影響を、難問ごとに計測する。
- **キーワード**: `test-time compute scaling`, `thought-level beam search`, `LLM reasoning`, `KV cache`, `hidden-state scoring`, `vLLM`

## 気になったこと

- scorerのランキング精度が低い領域で、Gambitは通常の並列サンプリングよりどの程度劣化しうるか。
- score-weighted majority voteによる寄与と、branching自体による寄与はどこまで分離できているか。
- 分岐元prefixの多様性を保つ制約が、難問・非数学タスクでも十分か確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yang2026-tr-thought-level-beam-search-for-reasoning-66d085af.md](../../chat/2026-08-18/yang2026-tr-thought-level-beam-search-for-reasoning-66d085af.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
