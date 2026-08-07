# Chat Prompt 2026-08-08

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Toward skill-native {LLMs}: Skill Entropy for benchmarking and training long-horizon reasoning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-08 - Toward Skill-Native LLMs: Skill Entropy for Benchmarking and Training Long-Horizon Reasoning

## 基本情報

- **タイトル**: Toward Skill-Native LLMs: Skill Entropy for Benchmarking and Training Long-Horizon Reasoning
- **著者**: Yinghui He, Ling Yang, Jiarui Liu, Yongjin Yang, Lechen Zhang, Yingcheng Wu, Zhenfei Yin, Mengdi Wang, Sanjeev Arora
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2608.05139v1 / arXiv:2608.05139v1 / Code: https://github.com/Gen-Verse/Skill-Entropy-RL

## 落合陽一フォーマット

- **ひとことでいうと**: 長い推論で「数学→計画→情報抽出」のように異なるskillを切り替える難しさを Skill Entropy として定量化し、それをbenchmarkとRL報酬に使う論文。
- **先行研究と比べてどこがすごい？**: 既存benchmarkが個別skillや長期タスク全体の成否を測りがちなのに対し、この論文は「skill間の遷移そのもの」を有向ペアの難易度として測る。558 skills・9 domainsからなる Skill2-Bench を作り、frontier/open-source modelでentropyが高いほど精度が落ちるskill-switching gapを示している。
- **技術や手法の肝はどこ？**: Skill Entropy は、単独skillでの平均正解率と、skill Aの後にskill Bを解かせたときのcross-skill正解率の比として定義される。さらにtask全体ではskill sequence上の遷移entropyを平均する。学習側では、モデルに各stepのanswerだけでなく使用skill labelも予測させ、正解報酬とgold skill sequenceへの整合報酬を組み合わせる Skill-Entropy RL を使う。
- **どうやって有効だと検証した？**: Skill2-Benchを使って8個のfrontier modelと4個のopen-source modelを評価し、高entropy taskほど性能がほぼ単調に低下することを確認。Qwen3-4B-InstructではSkill2-Bench scoreが34.4%から68.4%、Qwen3-1.7Bでは14.6%から40.1%に改善したと報告している。OpenR1-Mathのような既存training dataにも同じpipelineを適用できるとしている。
- **議論はある？**: Skill Entropyは固定reference modelに依存するため、「あるモデルにとって難しい遷移」が普遍的な難しさかは検討が必要。open-ended domainではLLM judgeやrubric生成の影響もあり得る。PDF抽出からは、benchmark生成データの人手検証規模、汚染対策、skill labelの曖昧性に対する詳細な頑健性までは十分に断定できない。
- **次に読む/試すなら**: 1. GitHub実装でSkill-Entropy rewardの具体式とtraining data形式を見る。2. 自分のagent taskをskill sequenceに分解してentropy推定できるか試す。3. 高entropyで失敗したcaseが「前stepのskillを引きずる」現象か確認する。
- **キーワード**: `long-horizon reasoning`, `skill entropy`, `skill switching`, `Skill2-Bench`, `reinforcement learning`, `process reward`, `LLM benchmark`

## 気になったこと

- Skill labelをどの粒度で定義すると、実運用のagent taskにも使えるのか。
- Skill Entropyがreference model依存なら、強いmodelで再推定したときに難易度順がどれだけ変わるのか。
- 「skillを明示的に予測させる」ことが、推論性能だけでなく解釈性・debuggabilityにも効くか。
- Open-ended taskの評価で、LLM judgeがskill sequenceの正しさとanswer qualityを混同していないか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
