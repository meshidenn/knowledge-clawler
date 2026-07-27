# Paperpile Brief 2026-07-28 - Sample-efficient learning from agent experience

## 基本情報

- **タイトル**: Sample-efficient learning from agent experience
- **著者**: Chenhui Gou, Haoqin Tu, Yunhao Fang, Jianfei Cai, Hamid Rezatofighi
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.21051v1 / arXiv:2607.21051v1

## 落合陽一フォーマット

- **ひとことでいうと**: エージェントが過去の試行錯誤履歴から得た in-context learning の改善を、追加の環境 interaction なしでモデル重みに蒸留する Experience Distillation を提案した論文。
- **先行研究と比べてどこがすごい？**: ICL は経験を context に入れている間だけ効く、通常の context distillation は teacher を環境で再実行する必要がある、というギャップを突いている。提案手法は collected experience だけを使い、749個の software-engineering tasks と6つの text-adventure games で ICL gains の少なくとも64.8%を保持し、同じ経験への直接SFTは3.8%しか回復しないと報告している。
- **技術や手法の肝はどこ？**: trajectory-level の context distillation を、1-step branched rollout に落とす点。記録済み履歴の各 branch point で、経験を持つ teacher に次の行動だけを生成させ、student は経験 context なしでそれを模倣する。world model を使った長い rollout を避けるため、環境応答を生成せず、teacher action の直後で止める。実装上は experience preprocessing、enhanced teacher reasoning、branch packing で長い履歴の密度と学習効率を上げる。
- **どうやって有効だと検証した？**: PDF本文によると、749 curated SWE tasks では pass@1、TaleSuite/Jericho 系の6 task では normalized score を評価。ICL、zeroshot、直接SFT、RL baseline、model-based rollout、branch packing などと比較している。SWEでは EPD が pass@1 51.4%、pass@10 80.9%を示し、ICL upper reference は pass@1 76.4%、pass@10 86.4%。TaleSuite でも ICL + EPD が平均 normalized score を 18.50 から 43.77 へ上げたと報告されている。
- **議論はある？**: base model や curated SWE task が in-house で、外部再現性はやや気になる。branch packing は理想目的の厳密実装ではなく近似。PDF抽出テキスト上では、細かい表や一部数値はレイアウト崩れがあるため断定しすぎない方がよい。world model rollout の失敗例は示されるが、失敗頻度の定量は限定的。
- **次に読む/試すなら**: 1. 自分の coding agent logs で「過去trialを teacher context に入れて次 action だけ生成」する最小EPDデータを作る。 2. 直接SFT vs EPD の小規模比較を pass@1/pass@k で試す。 3. branch packing なし/ありで teacher生成コストと性能差を見る。
- **キーワード**: `Experience Distillation`, `in-context learning`, `agent learning`, `context distillation`, `sample efficiency`, `software engineering agents`, `text adventure games`

## 気になったこと

- EPDで蒸留されるのは「タスク固有知識」なのか「経験を読む手順」なのか、OOD task への一般化部分を詳しく確認したい。
- teacher の enhanced reasoning prompt がどれくらい結果に効いているか、prompt依存性を追加で見たい。
- SWE tasks の curated 条件、成功判定、commit feedback の設計が実運用の coding agent にどれだけ近いか確認したい。
- 1-step branch で環境応答を使わない設計は堅いが、長期 credit assignment が必要な場面でどこまで効くか試したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [gou2026-sh-sample-efficient-learning-from-agent-experience-81fd5867.md](../../chat/2026-07-28/gou2026-sh-sample-efficient-learning-from-agent-experience-81fd5867.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
