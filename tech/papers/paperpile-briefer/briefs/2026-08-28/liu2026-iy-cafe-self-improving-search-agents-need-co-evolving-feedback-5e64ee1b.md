# Paperpile Brief 2026-08-28 - CAFE: Self-improving search agents need co-evolving feedback

## 基本情報

- **タイトル**: CAFE: Self-improving search agents need co-evolving feedback
- **著者**: Boyang Liu, Senjie Jin, Peixin Wang, Zhangyue Yin, Yibo Wang, Yuhao Zhou, Xinbing Liang, Shizheng Zhu, Yuhui Wang, Jingqi Tong, Zhiheng Xi, Jiazheng Zhang, Clive Bai, Clarenceai, Blaze Chen, Tao Gui, Qi Zhang, Xuanjing Huang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.24794](https://arxiv.org/abs/2608.24794)

## 落合陽一フォーマット

- **ひとことでいうと**: 検索エージェントが途中で「助言を求める」方策と、その助言を生成するcriticを交互に学習し、長い検索軌跡の誤りをその場で修復する枠組みCAFEを提案した。
- **先行研究と比べてどこがすごい？**: 終端報酬だけで後から評価するのではなく、実行中の軌跡に介入する学習済みフィードバックを扱う。agentだけ／criticだけを改善するのではなく、失敗分布の変化に合わせて両者を共進化させる設計が新規性。7Bモデルでは既存RL検索agentの最良比較対象より平均EMで2.1、F1で1.3上回った。
- **技術や手法の肝はどこ？**: 同一パラメータのモデルをagent役とcritic役に切り替える。まず自モデルの失敗軌跡に教師モデル（Kimi-K2.5）による訂正と成功継続を挿入してSFTし、オンラインRLでは「助言を呼ぶ／呼ばない」成功率差で依頼行動を報酬化するCFEと、助言前の行動の信用を弱め助言後の回復行動を強めるadvantage shapingを使う。さらに、同じ前置き状態を共有する成功・失敗軌跡の対からRDPOでcriticを更新する。
- **どうやって有効だと検証した？**: 2WikiMultihopQAをin-domain、HotpotQA・MuSiQue・PopQA・TriviaQA・Bamboogle・Natural Questionsをout-of-domainとして、EMとtoken-level F1で評価した。CAFEは7Bで平均52.5 EM / 60.7 F1を達成し、GRPOのみの49.7 / 58.0から改善。全6 out-of-domainベンチマークでもGRPOを上回り、幻覚率はGRPO後の17.6%から12.6%へ低下した。agentのみ／criticのみの更新より、交互更新が継続的に伸びることもablationで示した。
- **議論はある？**: 明示的なLimitations節はメタデータからは不明。初期SFTが教師モデルによる「最初の誤り地点」判定と修復に依存するため、その品質・コスト・バイアスが最終性能に影響しうる。また、助言の有用性を同一prompt内のcall–skip成功差で推定するため、探索多様性や標本数が少ない状況での推定安定性は追加検証したい。評価は主にSearchQA系であり、実運用での検索コストや遅延は本文から十分には判断できない。
- **次に読む/試すなら**: 1. RDPOと通常DPO／process rewardの比較を再現する。 2. 小規模検索環境で`<request_feedback>`の発火率・正解率・追加tool call数を同時に測る。 3. CriticSearch、StepSearch、Search-R1と信用割当ての違いを比較する。
- **キーワード**: `search agent`, `reinforcement learning`, `in-trajectory feedback`, `credit assignment`, `DPO`, `self-improvement`

## 気になったこと

- 共有backboneでagentとcriticを兼ねることが、役割干渉や自己追認をどの程度招くか。
- feedback requestが正解率の改善ではなく、単に検索回数・推論長の増加で効いていないか。品質当たりのコスト評価を確認したい。
- criticが同一iterationのagentに最適化されるという結果は、異なるモデル・検索ツール・未知ドメインにもどこまで転移するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [liu2026-iy-cafe-self-improving-search-agents-need-co-evolving-feedback-5e64ee1b.md](../../chat/2026-08-28/liu2026-iy-cafe-self-improving-search-agents-need-co-evolving-feedback-5e64ee1b.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
