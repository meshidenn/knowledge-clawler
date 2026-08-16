# Chat Prompt 2026-08-17

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Latent On-Policy Self-Distillation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-17 - Latent On-Policy Self-Distillation

## 基本情報

- **タイトル**: Latent On-Policy Self-Distillation
- **著者**: Guibin Zhang, Jiayang Lyu, Ran Sun, Xinlei Yu, Haoyu Zhao, Qibing Ren, Shuicheng Yan
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2608.13040v1](https://arxiv.org/abs/2608.13040v1)

## 落合陽一フォーマット

- **ひとことでいうと**: 過去の成功軌跡を、手設計のテキスト知識ではなく学習可能な潜在トークンへ圧縮し、それを特権情報として使う自己蒸留（LOPD）を提案した。
- **先行研究と比べてどこがすごい？**: OPSD系は回答・フィードバック・スキルなど教師へ渡す特権情報を人が決めていた。LOPDは「何を残し、どう教師に渡すか」自体をend-to-endで学習する。3バックボーン・7ベンチマークの全10集計比較で最良と報告し、GRPO・Skill-SDの30%未満のロールアウト予算でも上回った。
- **技術や手法の肝はどこ？**: 現在のタスクに近い成功軌跡を3件検索し、LoRA付きエンコーダとQFormer型コンプレッサで各32個の連続潜在トークンに圧縮する。その文脈を見た自己教師が、学生のon-policy軌跡上の各トークン接頭辞へdenseなreverse-KL教師信号を与える。さらに教師が学生より十分有益であり続けるよう、報酬に基づく**privileged-margin**制約を加える。
- **どうやって有効だと検証した？**: ツール利用ではEnvScaler、BFCL-v3、ACEBench、コード生成ではLiveCodeBench v5/v6、HumanEval+、MBPP+で評価した。Qwen3-4B/8BとOLMo3-7Bを用い、GRPO、OPSD、SDPO、Skill-SD、SDFTと比較。固定コンプレッサやmarginなしのアブレーションでは性能が下がり、学習可能な潜在文脈とmarginの両方が効くことを示した。
- **議論はある？**: 成功軌跡バンクと類似度検索の質に依存し、失敗例や大幅に異なるタスクへの一般化は十分には検証されていない。潜在トークンは可読に復号できず、何を因果的に保持しているかは解釈しにくい。評価は主にツール利用・Pythonコード生成であり、長期継続学習や安全性への影響は未検証である。
- **次に読む/試すなら**: 
  1. 公開実装で、固定文脈・検索のみ・LOPDの三条件を同一予算で比較する。
  2. 成功軌跡だけでなく失敗軌跡や反実仮想フィードバックを経験バンクへ加える。
  3. 検索件数・潜在トークン数・marginをタスク難度別に再最適化する。
- **キーワード**: `on-policy self-distillation`, `latent context`, `agent learning`, `privileged information`, `experience retrieval`

## 気になったこと

- 「30%未満のロールアウト予算」の比較は、各手法の事前学習・検索・コンプレッサ学習を含む総計算量でも優位なのか確認したい。
- 検索器はQwen3-Embedding-8Bと固定FAISS検索であり、検索失敗時や分布外タスクでの頑健性が気になる。
- 潜在文脈は教師専用で推論時には除去されるため、性能向上がどの能力として学生へ定着したかを、より細かな失敗分類で見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
