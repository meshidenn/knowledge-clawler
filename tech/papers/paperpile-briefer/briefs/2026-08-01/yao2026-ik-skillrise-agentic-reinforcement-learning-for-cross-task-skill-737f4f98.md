# Paperpile Brief 2026-08-01 - SkillRise: Agentic reinforcement learning for cross-task skill evolution

## 基本情報

- **タイトル**: SkillRise: Agentic reinforcement learning for cross-task skill evolution
- **著者**: Zhiyuan Yao, Yuxin Chen, Zhengxi Lu, Zishan Xu, Yueqing Sun, Yifu Guo, Yuquan Lu, Zhengzhou Cai, Kangning Zhang, Zhuowen Han, Zi-Han Wang, Ziang Ye, Qi Gu, Xunliang Cai, Weiwen Liu, Yongliang Shen
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2607.26784 / arXiv:2607.26784

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agent が関連する別タスク列を解きながら、過去の軌跡から再利用可能な skill document を更新し、後続タスクに転移させるための agentic RL 手法 SkillRise を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存の agentic RL は各タスクを独立 episode として扱いがちで、Reflexion/LaMer 系は同一タスクの再試行に寄り、skill bank 系は抽出・検索・実行が絡んで credit assignment が曖昧になりやすい。SkillRise は「関連するが異なるタスク列」「単一 policy」「skill document だけを跨タスク情報チャネルにする」設計で、ALFWorld / WebShop / ScienceWorld の Pass@1 で比較手法中最高を報告している。
- **技術や手法の肝はどこ？**: タスクを同一 family 内で簡単なものから難しいものへ並べ、各ステップで同じ policy がまず現在の skill document を使ってタスクを解き、その後に軌跡と結果を見て skill document 全体を書き換える。学習信号は分離され、solve phase には現在タスク報酬、curate phase には後続タスク報酬の discounted return を割り当てる。これにより「今解く能力」と「次以降に効く知識を抽象化する能力」を同じ policy に学習させる。
- **どうやって有効だと検証した？**: Qwen3-1.7B/4B を backbone に、ALFWorld、WebShop、ScienceWorld で評価。Qwen3-4B の主結果では SkillRise が ALFWorld 85.9%、WebShop 84.4%、ScienceWorld 54.6% の Pass@1 を達成し、最強 baseline からそれぞれ 2.3、7.1、8.5 percentage points 上回ったと報告。Pass@2/3、同一タスク再試行への一般化、テスト時に関連タスク列が長くなるほど性能が伸びる cross-task test-time scaling、multi-stage skill pipeline より runtime overhead が小さい点も分析している。
- **議論はある？**: 関連タスク family や難易度順序を構成できることが前提で、実環境でこの metadata が常に得られるかは課題。skill document はテキスト要約なので、誤った抽象化や過度に instance-specific な記憶が後続タスクを悪化させる可能性がある。評価は text-based interactive benchmark 中心で、Web/OS/robotics などより開いた環境で同じ credit assignment が効くかは未検証。細かい数値はPDF抽出テキスト由来なので表の読み取り誤差には注意。
- **次に読む/試すなら**: SkillRise の GitHub 実装を確認し、skill curation prompt と reward assignment を読む。自分の agent benchmark で「同一カテゴリの別タスクを3本並べる」最小実験を作る。LaMer、SkillRL、Reflexion、Agent Workflow Memory との設計差分を整理する。
- **キーワード**: `agentic reinforcement learning`, `LLM agents`, `skill learning`, `cross-task transfer`, `credit assignment`, `test-time scaling`, `ALFWorld`, `WebShop`, `ScienceWorld`

## 気になったこと

- タスク family 分割と難易度順序付けを人手 metadata なしで作る場合、embedding 類似度や過去成功率だけで十分か。
- skill document が長くなったときの圧縮・忘却・誤知識除去をどう制御しているか。
- 後続報酬を curation に割り当てる設計は直感的だが、後続 solve policy の偶然性と skill document 品質をどこまで分離できているか。
- 実運用では「似ているが別タスク」の stream が自然に来るとは限らないため、オンラインで task sequence を組む scheduler が必要そう。
- コード公開先: https://github.com/Within-yao/SkillRise

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yao2026-ik-skillrise-agentic-reinforcement-learning-for-cross-task-skill-737f4f98.md](../../chat/2026-08-01/yao2026-ik-skillrise-agentic-reinforcement-learning-for-cross-task-skill-737f4f98.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
