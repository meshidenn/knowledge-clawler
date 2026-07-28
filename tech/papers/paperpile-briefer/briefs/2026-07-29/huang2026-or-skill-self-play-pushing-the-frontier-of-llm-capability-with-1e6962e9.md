# Paperpile Brief 2026-07-29 - Skill Self-play: Pushing the frontier of LLM capability with co-evolving skills

## 基本情報

- **タイトル**: Skill Self-play: Pushing the frontier of LLM capability with co-evolving skills
- **著者**: Siyuan Huang, Pengyu Cheng, Haotian Liu, Tao Chen, Yihao Liu, Jingwei Ni, Shijie Zhou, Ziyi Yang, Gangwei Jiang, Mengyu Zhou, Yu Cheng, Xiaoxi Jiang, Guanjun Jiang
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.22529 / arXiv:2607.22529 / PDF: https://arxiv.org/pdf/2607.22529.pdf / code: https://github.com/Qwen-Applications/skill-self-play

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのself-play学習で、タスク多様性と検証信頼性のトレードオフを、進化する「skill library」を使って解くためのSkill Self-Play（Skill-SP）を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来の環境依存self-playは検証は強いが領域が狭く、open-ended生成は広いが検証が弱い。Skill-SPは、skillを「生成ガイド + validator + 履歴統計」を持つ再利用可能な task-pattern interface として使い、生成前の構造誘導と生成後の検証を同じループで回す点が新しい。API-Bank/BFCLのtool-useとZebraLogicのlogical reasoningで、複数backboneに一貫して改善を出している。
- **技術や手法の肝はどこ？**: proposer、solver、skill controllerの三者をGRPOベースのself-playで共進化させる。proposerはskill-conditioned streamとopen-ended exploration streamからタスクを生成し、schema compliance、contract validity、probe consistencyでvalidityを判定する。solverの成功率が0.5付近になる「学習境界」のタスクを高く評価し、skill controllerは失敗traceや利用統計からskillをrefine、prune、induceする。
- **どうやって有効だと検証した？**: tool-call predictionではAPI-Bank L1-L3とBFCLのJS/Python/Java/Liveカテゴリ、logical reasoningではZebraLogicを使用。Qwen3、Ministral-3、Granite系の5つのbackboneで評価し、avg@8を報告。Tool-callでは最大+42.9ポイント、logical reasoningでは最大+12.0ポイントの改善。Unguided SP、uniform routing、frozen skills、frozen proposer、frozen feedback solverなどのablationで、skill routingとskill library進化、proposer/solver共進化の寄与を分離している。
- **議論はある？**: 弱いモデルではLarge/X-LargeのZebraLogic改善が限定的で、self-playのbootstrapには最低限の初期能力が必要そう。skillの自動生成・更新の品質保証、validator設計の一般化、skill libraryが増えたときの管理コストは重要な論点。PDF本文上では外部の強いteacherなしと説明されるが、初期skill libraryやdomainごとのvalidator設計にどの程度人手や事前設計が入るかは実装確認が必要。
- **次に読む/試すなら**: 1. GitHub実装でskill packageの形式とvalidator実装を確認する。 2. 小さいtool-use環境でskill streamとexploration streamの比率を変える再現実験をする。 3. skill induction/refinementが失敗traceから何を抽出しているかを追う。
- **キーワード**: `LLM self-play`, `agent skills`, `reinforcement learning`, `GRPO`, `tool use`, `verifiable rewards`, `curriculum learning`, `ZebraLogic`

## 気になったこと

- skillを「手続き知識」ではなく「検証可能なタスク生成インターフェース」として扱う設計は、Codex/Claude Skills的な運用にも近く、training-time skillとinference-time skillの橋渡しになりそう。
- 初期skill libraryがどれだけ性能に効くのか、完全ゼロからskill inductionだけで立ち上がるのかを確認したい。
- proposer rewardが「validかつ中難度」を狙う設計なので、validatorをすり抜けるpseudo-valid taskへの耐性がどこまであるかが気になる。
- 自分の用途では、論文要約・コード修正・実験設計のような実務taskに対して、hidden verification contractをどう定義するかが一番の実装課題。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [huang2026-or-skill-self-play-pushing-the-frontier-of-llm-capability-with-1e6962e9.md](../../chat/2026-07-29/huang2026-or-skill-self-play-pushing-the-frontier-of-llm-capability-with-1e6962e9.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
