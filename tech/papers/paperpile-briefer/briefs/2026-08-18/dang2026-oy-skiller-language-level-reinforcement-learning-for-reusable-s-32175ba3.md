# Paperpile Brief 2026-08-18 - SKILLER: Language-level reinforcement learning for reusable skill extraction in small language models

## 基本情報

- **タイトル**: SKILLER: Language-level reinforcement learning for reusable skill extraction in small language models
- **著者**: Chenhao Dang, Siyuan Xiong, Conghui He, Weijia Li
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.10538v2](https://arxiv.org/abs/2608.10538v2)、[Project](https://github.com/DANG-ai/SKILLER)

## 落合陽一フォーマット

- **ひとことでいうと**: 小型LLM専用の「Agent Skill」を、強力なLLMが自然言語だけで反復改善することで自動生成し、小型モデルのエージェント性能を引き上げる手法。
- **先行研究と比べてどこがすごい？**: 汎用的なスキルを小型モデルへ転用すると、複雑な指示や暗黙の推論前提が過負荷になる「model mismatch」を正面から扱う。Qwen3.5-9B/4Bで、AutoSkill・EvoSkill・SkillX・Manusを含む比較手法を上回り、9BではSkillsBenchで73.91%、SWE-Skills-Benchで82.80%を報告している。
- **技術や手法の肝はどこ？**: 学習対象をモデル重みではなく自然言語のSkill本文とする。小型LLMの実行軌跡・検証器の報酬/診断・成功参照軌跡をCriticが分析し、最初の因果的な失敗を特定する。Actorはその診断に基づき、限定的な編集とタスク専用ヘルパースクリプト作成を行う。過去の失敗・有効編集はreplay memoryに蓄積する。
- **どうやって有効だと検証した？**: SkillsBench、SkillLearnBench、SWE-Skills-Bench、GAIA、EarthBenchの5ベンチマークで、Qwen3.5-9Bと4Bを評価し、各結果は3回平均。GAIA/EarthBenchでは生成用データと保持データを分けたzero-shot評価も実施した。状態情報・Critic/Actorの各要素のablationでは、実行軌跡、タスク入力、ヘルパースクリプト生成の寄与が特に大きい。
- **議論はある？**: 強いモデル（GPT-5.4）と成功参照軌跡、公式verifierをスキル生成時に必要とするため、これらが得られない実運用への適用性は未検証。評価対象はQwen3.5の2サイズに限られ、SWE-Skills-Benchも「skill追加で性能変化がある」10タスク・117事例に絞っている。生成コストには小型モデルの下流実行コストが含まれない。
- **次に読む/試すなら**:
  - 公開実装で、既存の小型モデル用Skillを1件だけSKILLERで改善する。
  - 成功参照軌跡なし・verifierが弱い環境で性能が維持できるか検証する。
  - Qwen以外や実際の社内タスクで、生成コスト込みのROIを比較する。
- **キーワード**: `agent skills`, `language-level reinforcement learning`, `small language models`, `skill evolution`, `LLM agents`

## 気になったこと

- Skillの改善が、タスク固有の最適化ではなく別タスクへどの程度移転するのか。GAIA/EarthBench以外での汎化評価も見たい。
- 参照軌跡の品質や取得コストが、最終的なスキル品質・生成費用をどれほど左右するか。
- verifierに合わせた過適合や、ヘルパースクリプトによる実質的なタスク解法の埋め込みをどう監査するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [dang2026-oy-skiller-language-level-reinforcement-learning-for-reusable-s-32175ba3.md](../../chat/2026-08-18/dang2026-oy-skiller-language-level-reinforcement-learning-for-reusable-s-32175ba3.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
