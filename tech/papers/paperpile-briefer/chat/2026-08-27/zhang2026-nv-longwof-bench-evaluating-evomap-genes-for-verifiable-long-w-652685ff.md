# Chat Prompt 2026-08-27

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {LongWoF}-Bench: Evaluating {EvoMap} genes for verifiable long-workflow tasks

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-27 - LongWoF-Bench: Evaluating EvoMap genes for verifiable long-workflow tasks

## 基本情報

- **タイトル**: LongWoF-Bench: Evaluating EvoMap genes for verifiable long-workflow tasks
- **著者**: Xiao Zhang, Qumeng Sun, Jiahao Li, Yiming Ren, Xiang Liu, Haoyang Zhang, Junjie Wang
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.23200v2](https://arxiv.org/abs/2608.23200v2)

## 落合陽一フォーマット

- **ひとことでいうと**: 検証済みのエージェント実行経験を構造化した「EvoMap Gene」として再利用すると、長いワークフロー課題で通常の手順書型「Skill」より高い成功率を得られるかを測るベンチマークと実証研究。
- **先行研究と比べてどこがすごい？**: 778件の機械検証可能な課題で、手順知識そのものではなく「verifierを通過した実行経験の来歴」が有効性の源泉だと検証した点。Opus由来のGeneは252課題・7モデルでSkillを8.7〜15.5ポイント上回り、異なるモデル系列にも転移した。
- **技術や手法の肝はどこ？**: 失敗時の検証フィードバックを使って解を改善し、通過した軌跡から成功戦略・境界条件・失敗防止策をGeneへ抽出する。再利用時には軌跡や検証フィードバック自体を渡さず、Geneだけを補助コンテキストとして与える。
- **どうやって有効だと検証した？**: コード生成、エージェント環境合成、数理推論、規則追従の4領域・778課題を用意し、No Context／Skill／Geneを同一の仕様・実行環境・隠し検証器で比較。252件の検証済みOpus軌跡がある部分集合では、OpusはSkill比で39件多く通過し、solve-time tokenも9.9%削減した。
- **議論はある？**: Gene作成の探索・蒸留・監査コストは再利用時のコスト集計から除かれており、何回再利用すれば得になるかは未検証。また252件はOpusが検証済み軌跡を得られた課題に限られる選択バイアスがある。数理推論や一部コード生成ではGeneがSkillを下回るモデルもあり、モデル本来の推論能力は補えない。
- **次に読む/試すなら**:
  - Gene生成コストを含めた再利用回数ごとの損益分岐点を測る。
  - 異なる生成モデル・異なる難度の課題でGeneの転移性を再現する。
  - 自分のエージェント運用で、失敗ログから境界条件と検証手順だけを抽出する最小Geneを試す。
- **キーワード**: `LLM agents`, `experience reuse`, `procedural memory`, `verifiable workflows`, `benchmark`

## 気になったこと

- GeneとSkillの情報量・作成コスト・プロンプト長がどの程度統制されているかを確認したい。
- 252件の「検証済み軌跡あり」課題と、残り526件のreference-distilled Gene比較は課題集合が異なるため、来歴効果の因果解釈には注意が必要。
- 公開されたベンチマーク、Gene形式、検証器がどこまで再現可能かを確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
