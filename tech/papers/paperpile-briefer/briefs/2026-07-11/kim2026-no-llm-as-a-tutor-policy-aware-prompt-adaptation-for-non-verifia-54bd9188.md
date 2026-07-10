# Paperpile Brief 2026-07-11 - LLM-as-a-tutor: Policy-aware prompt adaptation for non-verifiable RL

## 基本情報

- **タイトル**: LLM-as-a-tutor: Policy-aware prompt adaptation for non-verifiable RL
- **著者**: Yujin Kim, Namgyu Ho, Sangmin Hwang, Joonkee Kim, Yongjin Yang, Sangmin Bae, Seungone Kim, Jaehun Jung, Se-Young Yun, Hwanjun Song
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2607.04412

## 落合陽一フォーマット

- **ひとことでいうと**: 非検証型の instruction-following RL で、LLM judge を「採点者」だけでなく「家庭教師」として使い、現在の policy にとって簡単すぎる prompt に制約を追加して学習信号を復活させる論文。
- **先行研究と比べてどこがすごい？**: 既存の rubric-based RL は prompt を固定し、最近の policy-adaptive 手法も rubric の更新や prompt rewrite に寄りがちだった。本研究は「reward が識別的であるには prompt 自体が policy に対して適切な難易度である必要がある」と明示し、pairwise rollout 比較で非識別的 prompt を検出して、append-only に難易度を上げる点が新しい。
- **技術や手法の肝はどこ？**: 同一の Qwen3-8B tutor が、まず2つの policy rollout を比較して品質差があるかを判定する。差がなければ prompt が current policy に対して non-challenging とみなし、元 prompt を書き換えずに atomic constraint と対応 rubric criterion を追加する。append-only なので元タスク分布を保ちつつ、制約数として難易度を単調に上げる。
- **どうやって有効だと検証した？**: Qwen3-1.7B-Thinking を policy、Qwen3-8B-Thinking を tutor/judge とし、WildChat から4K prompt を使って3 epoch の GRPO 学習を実施。FollowBench、AdvancedIF、InfoBench で評価し、LLM-as-a-Tutor は平均 51.96 で、Base rubrics、WildChecklists、Policy-adaptive rubrics、Evol-Instruct、EVA を上回った。Ablation では、Always/Random/Wrong な制約追加より current policy の rollout に基づく Adaptive が良く、Reset/Rewrite より Append が良いことを示している。
- **議論はある？**: 主結果は Qwen3-1.7B policy と Qwen3-8B tutor の単一構成が中心で、他モデルファミリや大規模 policy への一般化は限定的。tutor の pairwise 判定と constraint 生成能力に依存するため、弱い tutor では誤判定や不適切な制約が増える。さらに tutor 呼び出しと追加 rollout による inference cost がある。安全性面では、任意の instruction への追従能力を高めるため、seed corpus や rubric が悪いと有害指示への追従も強化しうる。
- **次に読む/試すなら**: 
  1. 自分の instruction-following RL pipeline で、prompt ごとの reward variance が epoch とともに潰れていないか確認する。
  2. prompt rewrite ではなく append-only constraint を小規模データで試し、base rubric score の平均・分散がどう変わるか見る。
  3. DR Tulu、EVA、WildChecklists/RLCF 系の rubric-based RL と比較して、prompt adaptation と rubric adaptation の役割分担を整理する。
- **キーワード**: `non-verifiable RL`, `LLM judge`, `rubric-based reward`, `policy-adaptive prompting`, `GRPO`, `instruction following`, `curriculum learning`

## 気になったこと

- pairwise 判定で「両方よくできている」と「両方だめ」をどこまで区別できているのか。
- append された constraint が、元 prompt の意図を歪めるケースの検出方法。
- tutor と judge が同じモデルであることによる bias や reward hacking の可能性。
- constraint 数が増え続けたとき、学習信号は強くなる一方で prompt 長・評価コスト・タスク自然性がどこで破綻するか。
- 数学・コード・検索・エージェントタスクなど、単純な「制約追加」以外の難易度操作が必要な領域への拡張方法。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [kim2026-no-llm-as-a-tutor-policy-aware-prompt-adaptation-for-non-verifia-54bd9188.md](../../chat/2026-07-11/kim2026-no-llm-as-a-tutor-policy-aware-prompt-adaptation-for-non-verifia-54bd9188.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
