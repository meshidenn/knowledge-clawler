# Chat Prompt 2026-09-02

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Training agents to evolve with their Harness: {TaoLive} digital avatar agent technical report

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-02 - Training agents to evolve with their Harness: TaoLive digital avatar agent technical report

## 基本情報

- **タイトル**: Training agents to evolve with their Harness: TaoLive digital avatar agent technical report
- **著者**: TaoLive AIGC LLM Team: Yuhan Sun, Wenhao Lin, Yongdong Luo, Yibo Hu, Meiguang Jin, Junfeng Ma, Weihang Pan, Jiaxin Zhao, Zulong Chen
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv PDF](https://arxiv.org/pdf/2608.15763)

## 落合陽一フォーマット

- **ひとことでいうと**: 頻繁に変わるプロンプト・スキル・ツール定義に、小型のライブコマースAIエージェントが再学習なしで追従できるようにする学習法 HAT を提案した。
- **先行研究と比べてどこがすごい？**: 固定された実行環境だけでSFTすると起きる「スキル名やツール名の丸暗記」を避け、ドメイン性能・環境変更への頑健性・汎用指示追従性を両立した。Live-Stream QAで94.8、Harness変更版QAで94.6を報告し、固定Harness SFTで低下するIFEvalも83.5まで維持している。
- **技術や手法の肝はどこ？**: Harness-State Augmentation（HSA）により、意味を保ったままSkill識別子・内容、ツールスキーマ、プロンプト構造、Hook関数を変形する。これを用いたSFT、一般データでのOn-Policy Distillation、HSA環境内でのRLを順に行い、現行Harnessを読んで行動する方策を学ばせる。
- **どうやって有効だと検証した？**: 4,500件超の4評価セットで、実運用ライブ配信QA、Harness変更耐性、ツール／プロンプト頑健性、IFEvalを比較した。さらにH20 1基での完全エージェント再生ではP50 3.4秒・P95 8.1秒を報告し、Taobao LiveのオンラインA/BテストではGMVと商品詳細ページ閲覧の増加も示した。
- **議論はある？**: 評価Harnessの変更パターンが実運用上の将来変更をどこまで代表するかは未検証である。主要な品質評価にHarnessベースのJudgeを使っており、キャリブレーションはあるものの評価者依存性は残る。A/Bテストの期間・統計的有意性・交絡の詳細は本文抽出範囲からは不明。
- **次に読む/試すなら**: 1. HSAの各変形が何に効くかを個別アブレーションする。 2. 未知のツール追加・仕様破壊的変更での耐性を測る。 3. 自分のエージェントで、プロンプト／ツール名の意味保存リネームを含む最小HSA-SFTを試す。
- **キーワード**: `Harness-Aware Training`, `agent robustness`, `tool calling`, `domain adaptation`, `live commerce`, `reinforcement learning`

## 気になったこと

- HSAが「意味保存」と判断する変形の生成・品質管理方法、および実際のHarness変更との分布差を確認したい。
- 固定Harness SFTとの差が、データ量・教師モデル・RL報酬設計ではなくHSA自体によるものかを、より厳密な対照実験で見たい。
- GMV向上が応答品質、戦略変更速度、あるいは別の配信条件のどれに起因するかを切り分けたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
