# Paperpile Brief 2026-07-14 - Scaling the horizon, not the parameters: Reaching trillion-parameter performance with a {35B} agent

## 基本情報

- **タイトル**: Scaling the horizon, not the parameters: Reaching trillion-parameter performance with a {35B} agent
- **著者**: Lei Bai et al.; Agents-A1 Team, Shanghai Artificial Intelligence Laboratory
- **年 / venue**: 2026 / arXiv [cs.CL], arXiv:2606.30616v1
- **リンク**: https://arxiv.org/pdf/2606.30616

## 落合陽一フォーマット

- **ひとことでいうと**: 35B MoEのエージェントモデル Agents-A1 を、パラメータ数ではなく長い行動履歴・ツール利用・検証付き軌跡をスケールさせることで、1T級モデルに近い長期タスク性能へ持っていく論文。
- **先行研究と比べてどこがすごい？**: 大規模化の主軸を「モデルサイズ」から「agent horizon」にずらし、平均45K tokenの長期軌跡、Knowledge-Action Graph、domain teacher、on-policy distillationを組み合わせている。本文では SEAL-0 56.4、IFBench 80.6、HiPhO 46.4、FrontierScience-Olympiad 79.0、MolBench-Bind 56.8 などで Kimi-K2.6 や DeepSeek-V4-pro など1T級モデルを上回る、または競争的だと報告している。
- **技術や手法の肝はどこ？**: 肝は3つ。1つ目は、外部知識・行動・観測・検証結果を Knowledge-Action Graph として記録し、成功/失敗を含むプロセス監督を作ること。2つ目は、検索、MLE、科学推論、instruction following、tool callingなど複数ドメインで専門teacherを作ること。3つ目は、domain-routed on-policy distillation と salient vocabulary alignment により、各ドメインteacherの知識を単一の35B studentへ移すこと。
- **どうやって有効だと検証した？**: GAIA、BrowseComp、XBench-DeepResearch、SEAL-0、SciCode、MLE-Bench-Lite、科学系ベンチマークなどで評価。検索系では search/visit/code tool を持たせ、最大300 turn、pass@1を主指標にしている。SciCodeは288 subproblems、MLE-Bench-Liteは22 Kaggle competitionを12時間/H200 GPU条件で評価したと本文にある。
- **議論はある？**: PDF本文抽出は19ページまでで、Limitations節の詳細は確認できない。見えている範囲では、再現性の鍵となる大規模なKAG構築、teacher生成、長時間tool環境、データフィルタリング、人手レビューの詳細が実装依存で重い。さらに、benchmark judgeやtool環境に性能が依存し、1T級モデル比較も同一条件の厳密性を追加確認したい。
- **次に読む/試すなら**: 
  1. Knowledge-Action Graphを小規模に再現し、検索タスクで成功/失敗軌跡を保存する。
  2. salient vocabulary alignmentの実装可能性を、既存teacher/studentで検証する。
  3. SEAL-0やBrowseCompで、単純SFT、domain teacher、OPDの差分を確認する。
- **キーワード**: `agent horizon scaling`, `Knowledge-Action Graph`, `on-policy distillation`, `salient vocabulary alignment`, `long-horizon agent`, `tool use`

## 気になったこと

- KAGの構築コストと品質管理を、研究室外の小規模環境でどこまで再現できるか。
- domain-routed OPDで、ドメイン境界が曖昧なタスクをどうroutingするのか。
- 1T級モデル比較で、tool、turn上限、judge、prompt、推論budgetが完全に揃っているか。
- 平均45K token軌跡のうち、性能に効いているのは長さなのか、検証信号なのか、teacherの質なのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [bai2026-jn-scaling-the-horizon-not-the-parameters-reaching-trillion-para-5b776467.md](../../chat/2026-07-14/bai2026-jn-scaling-the-horizon-not-the-parameters-reaching-trillion-para-5b776467.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
