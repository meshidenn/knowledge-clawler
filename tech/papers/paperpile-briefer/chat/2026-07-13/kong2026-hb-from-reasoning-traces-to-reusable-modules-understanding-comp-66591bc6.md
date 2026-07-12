# Chat Prompt 2026-07-13

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- From reasoning traces to reusable modules: Understanding compositional generalization in language model reasoning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-13 - From reasoning traces to reusable modules: Understanding compositional generalization in language model reasoning

## 基本情報

- **タイトル**: From reasoning traces to reusable modules: Understanding compositional generalization in language model reasoning
- **著者**: Lingjing Kong, Xin Liu, Guangyi Chen, Martin Q. Ma, Xiangchen Song, Yuekai Sun, Mikhail Yurochkin, Taylor W. Killian, Ruslan Salakhutdinov, Kun Zhang, Eric P. Xing, Zhengzhong Liu
- **年 / venue**: 2026 / arXiv [cs.LG], ICML 2026 Proceedings と本文に記載
- **リンク**: https://arxiv.org/abs/2606.18089v2 / arXiv:2606.18089v2

## 落合陽一フォーマット

- **ひとことでいうと**: SFT+RL がLLMの推論汎化を改善する理由を、推論トレースから再利用可能な「スキル」と「ルーティング機構」を同定・再合成する過程として理論化し、合成タスクで検証した論文。
- **先行研究と比べてどこがすごい？**: RLでOOD推論性能が上がるという経験的観察に対し、「なぜ上がるか」を階層的潜在選択モデルで説明している点。SFTは複合トレース中に原材料となるatomic modulesを供給し、RLは報酬下の軌道多様性によってそれらを分解・同定する、という非対称な役割分担を明示した。
- **技術や手法の肝はどこ？**: 推論トレースを、離散潜在変数が階層的にatomic moduleを選ぶ生成過程として見る。atomic moduleは、局所操作である**skills**と、中間結果の選択・再利用・合成を決める**routing mechanisms**に分けられる。理論的には、観測された `(P, D)`、つまり問題descriptorと推論トレース分布から、潜在ノード・隣接構造・局所条件付き分布が同定可能になる条件を示す。
- **どうやって有効だと検証した？**: 主にsynthetic string transformation tasksで、変換関数をatomic skill、入力構造をrouting mechanismとして制御実験を行った。SFTのみ、RLのみ、SFT+RL、atomic task supervision、compound trace trainingなどを比較し、RLが複合トレースからatomic modulesを抽出して未知の組合せへ再合成できることを確認している。さらに、SFTがatomic inventoryをカバーし、RLがSFT support外の新規compositionを探索する設定がOOD性能で強い、というデータ設計の示唆も示す。
- **議論はある？**: 実験は制御性を優先した合成タスク中心で、数学・コード・ツール使用などの複雑な実ドメインにどこまで拡張できるかは未検証。理論条件も「局所interfaceが訓練中に観測される」ことなどに依存するため、現実のLLM推論でその条件をどう測るかは課題。PDF抽出本文からは、細かい数値結果や表の正確な値までは断定しない。
- **次に読む/試すなら**: 1. string transformation taskの実験設定を再現して、SFT/RLデータ重複率とOOD精度の関係を見る。 2. 自分の推論タスクで「skill」と「routing」を分けてアノテーションできるか検討する。 3. RLデータをSFT support外のcompositionに寄せるcurriculumを小規模モデルで試す。
- **キーワード**: `compositional generalization`, `SFT`, `reinforcement learning`, `reasoning traces`, `latent variable model`, `atomic modules`, `routing mechanisms`, `OOD generalization`

## 気になったこと

- 「RLがmoduleを同定する」という主張を、実モデル内部表現ではなく行動・トレース分布からどこまで検証できているのか。
- synthetic taskで定義されたskill/routingの分離が、数学証明やコード生成のような曖昧な推論ステップにも自然に対応するか。
- SFTで全atomic modulesをカバーし、RLでnovel compositionを探索するという設計を、実データセットでどう自動構築するか。
- local interface coverageを測る指標や、未探索interfaceへRLを誘導するobjectiveが作れるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
