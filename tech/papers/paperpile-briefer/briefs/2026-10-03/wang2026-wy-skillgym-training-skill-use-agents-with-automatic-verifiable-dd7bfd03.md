# Paperpile Brief 2026-10-03 - SkillGym: Training skill-use agents with automatic verifiable environment generation

## 基本情報

- **タイトル**: SkillGym: Training skill-use agents with automatic verifiable environment generation
- **著者**: Renxi Wang, Mingshan Hee, Fajri Koto, Timothy Baldwin, Haonan Li
- **年 / venue**: 2026 / arXiv [cs.AI]（arXiv:2609.37539）
- **リンク**: https://arxiv.org/abs/2609.37539

## 落合陽一フォーマット

- **ひとことでいうと**: インターネット上のAgent Skillから、実行可能な検証環境・タスク・正解軌跡を自動生成し、Skillを適切に使えるLLMエージェントをSFTで訓練するパイプラインを提案した論文。
- **先行研究と比べてどこがすごい？**: 固定環境でSkillを学習するのではなく、Skillを起点にタスク環境を生成する。builder-reviewerによる品質検査、実行可能なverifier、4種類の推論構造を組み合わせ、約6.8kタスクと19kの検証済み成功軌跡を構築した。Qwen3.5-9BのSFTモデルが、SkillGymとSkillEvalの2ベンチマークで未学習の397Bモデルを上回った。
- **技術や手法の肝はどこ？**: まず再現可能なSkillだけを収集・選別し、各Skillに対して、procedural execution、abductive diagnosis、constraint satisfaction、partial-order planningのタスクを生成する。各タスクに初期状態、参照解、実行可能な検証器を持たせ、未変更状態では失敗し参照解では成功することを確認する。さらにreviewerが情報漏洩、過剰に厳しい検証、見逃しの多い検証を監査する。
- **どうやって有効だと検証した？**: 2B〜122Bの6モデルをMini-SWE-Agent上でSFTし、SkillGym、SkillEval、SkillsBench、Skill-Use-Benchで評価した。SFTにより24比較中22で性能が向上し、平均でSkillGymは13.8ポイント、SkillEvalは9.7ポイント、SkillsBenchは9.7ポイント、Skill-Use-Benchは41.2ポイント改善した。関連Skillを読む割合も28%から96%に上昇し、学習対象外のSkillでも性能向上が確認された。
- **議論はある？**: SkillsBenchでは、参照ドキュメントを提供するSkillには大きな改善があった一方、ドメイン固有の手法や同梱ツールを要求するタスクの改善は小さかった。自動生成タスクとLLM reviewerに依存するため、検証器の妥当性や実環境への外部妥当性には注意が必要。学習はSFTに限定されており、RLでの改善は未検証。ベンチマーク間でハーネスや評価条件も異なるため、単純な性能順位の比較には留保が必要。
- **次に読む/試すなら**: SkillGymのコードとデータを確認し、手元のSkillから最小のverifiable taskを1つ作る。SFT前後でSkillの参照率とタスク成功率を比較する。特にドメイン固有ツールを使うタスクで、単なるSkill参照と実際の手法適用を分離して評価する。
- **キーワード**: `agent skills`, `verifiable environments`, `skill-use training`, `synthetic trajectories`, `supervised fine-tuning`

## 気になったこと

- Skillを読んだだけで解けるタスクと、Skill内の手法・ツールを実際に適用しないと解けないタスクの割合はどの程度か。
- reviewerが「正しい代替解を受け入れる検証器」をどの程度安定して設計できるか。
- 外部Skillや実際の開発環境でも、Skill参照率96%が維持されるか。
- 失敗した軌跡や、Skillを使わずに偶然成功した軌跡をどのように学習へ利用できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは?
---

## 追加で聞く

- Chat prompt: [wang2026-wy-skillgym-training-skill-use-agents-with-automatic-verifiable-dd7bfd03.md](../../chat/2026-10-03/wang2026-wy-skillgym-training-skill-use-agents-with-automatic-verifiable-dd7bfd03.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
