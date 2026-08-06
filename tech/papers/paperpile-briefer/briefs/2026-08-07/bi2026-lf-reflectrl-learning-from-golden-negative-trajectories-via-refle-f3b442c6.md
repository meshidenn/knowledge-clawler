# Paperpile Brief 2026-08-07 - ReflectRL: Learning from Golden Negative Trajectories via Reflective-to-Direct Reasoning

## 基本情報

- **タイトル**: ReflectRL: Learning from Golden Negative Trajectories via Reflective-to-Direct Reasoning
- **著者**: Jinhe Bi, Chennan Zhou, Zengjie Jin, Aniri, Shuo Lu, Wenke Huang, Hu Cao, Xun Xiao, Zhihong Zhu, Volker Tresp, Fei Shen, Yunpu Ma, Tat-Seng Chua
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2608.03972 / PDF: https://arxiv.org/pdf/2608.03972.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: 強い expert model が失敗した推論軌跡を捨てずに、「どこまで正しく、どこで壊れたか」を反省材料として使い、LLM の on-policy reasoning training を改善する ReflectRL を提案した論文。

- **先行研究と比べてどこがすごい？**: 従来の RLVR や OPD は、正解した expert trajectory を良い手本として使う一方、失敗軌跡は negative sample として捨てがちだった。本研究は、強いモデルの失敗には高品質な valid prefix と局所的な error region が含まれるため、反省させる文脈として使えば direct reasoning より解きやすくなる、という Reflection Advantage を実験的に示している。

- **技術や手法の肝はどこ？**: Golden Negative Trajectories（GNT）を reflective prompt に入れ、モデルに「誤りを見つけ、修復し、解く」Reflective Reasoning を行わせる。その後、Reflective-to-Direct Policy Transition により、学習中の rollout 比率を reflective から direct へ徐々に移し、推論時には GNT なしで直接解けるようにする。RLVR では混合 rollout を同じ verifier で評価し、OPD では teacher 側に GNT を privileged context として与える。

- **どうやって有効だと検証した？**: PDF本文によると、9 benchmark、4 LLM backbone、4 on-policy training method で評価している。Qwen2.5 系や Llama-3.1-8B-Instruct を用い、AIME、AMC、MATH-500、Minerva、OlympiadBench、ARC-c、GPQA、MMLU-Pro などで baseline / GRPO / +ReflectRL を比較。さらに PRM による step-level quality 分析、GNT component の ablation、transition scheduler の比較も行い、GNT の valid prefix と error region の両方が性能改善に寄与すると主張している。

- **議論はある？**: 強い expert model の失敗軌跡を事前に集める必要があり、GNT の品質に依存する。PDF抽出上は、数値表は細部まで断定しすぎない方がよいが、全体傾向として ReflectRL は一貫して改善したとされる。数学・推論 benchmark 中心なので、コード生成、実世界タスク、長期エージェントタスクなどへの一般化はメタデータからは不明。GNT が「局所的に間違っているが構造は良い」場合に効く設計なので、完全に低品質な失敗や問題と不一致な軌跡では逆効果になり得る。

- **次に読む/試すなら**: OpenR1-GNT-69k dataset の作成方法とフィルタ条件を確認する。自分の RLVR pipeline で reflective/direct rollout 比率の cosine decay を最小実装する。GNT の valid prefix / error region を自動検出する PRM ベースの前処理が再現可能か見る。

- **キーワード**: `ReflectRL`, `Golden Negative Trajectories`, `Reflection Advantage`, `RLVR`, `GRPO`, `On-Policy Distillation`, `LLM reasoning`

## 気になったこと

- GNT を生成する expert model の強さと失敗タイプが、どの程度性能に影響するのか。
- Reflective-to-Direct transition の schedule はタスクやモデルサイズにどれだけ敏感か。
- 「反省して解く」能力が本当に direct reasoning に転移しているのか、それとも benchmark 上の prompting artifact なのか。
- 失敗軌跡を大量に使う場合、誤った reasoning style を internalize するリスクはないか。
- 数学以外の domain、特にコード修正・計画・マルチステップツール利用でも Reflection Advantage が出るか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [bi2026-lf-reflectrl-learning-from-golden-negative-trajectories-via-refle-f3b442c6.md](../../chat/2026-08-07/bi2026-lf-reflectrl-learning-from-golden-negative-trajectories-via-refle-f3b442c6.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
