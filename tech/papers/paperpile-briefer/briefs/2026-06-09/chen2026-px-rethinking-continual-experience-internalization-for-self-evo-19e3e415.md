# Paperpile Brief 2026-06-09 - Rethinking continual experience internalization for self-evolving LLM agents

## 基本情報

- **タイトル**: Rethinking continual experience internalization for self-evolving LLM agents
- **著者**: Jingwen Chen, Wenkai Yang, Shengda Fan, Wenbo Nie, Chenxing Sun, Shaodong Zheng, Yangen Hu, Lu Pan, Ke Zeng, Yankai Lin
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2606.04703

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントが過去の経験をパラメータへ内在化して自己進化する際、単発ではなく複数イテレーションで性能が崩壊する問題を分析し、安定化する設計レシピを示した論文。
- **先行研究と比べてどこがすごい？**: 既存の経験内在化・context distillation研究が主に1回の転移性能を見ていたのに対し、この論文は継続的な自己進化ループで性能が累積改善せず崩れることを実験的に示している。特に、経験の粒度、注入方法、蒸留レジームという3軸で失敗原因を分解している点が実践的。
- **技術や手法の肝はどこ？**: 経験を軌跡固有のinstance-levelではなく、再利用可能な戦略・失敗パターンを抽象化したprinciple-levelで扱うこと。さらに、経験を全体プロンプトへ一括注入するglobal injectionではなく、ReAct型エージェントの各中間状態に応じて関連経験を選ぶstep-wise injectionを使う。蒸留は、学生モデル由来の崩れた軌跡を局所修正するon-policyより、高品質な教師軌跡に基づくoff-policy context-distillationの方が安定する、という主張。
- **どうやって有効だと検証した？**: Qwen3-4B-Instruct-2507とQwen3-8B-Instructを使い、WebWalkerQA、GAIA-Text-103、BrowseComp-ZHで3回の自己進化イテレーションを評価している。訓練データはWebWalkerQA-silver、DeepDive、WebShaper、WebDancer、SailorFog-QAから作った15K web-reasoning QA。主要結果では、principle-level経験、step-wise injection、off-policy distillationの組み合わせが、複数イテレーションで比較的安定した性能を示す。
- **議論はある？**: 評価はweb reasoning / tool-use系タスクに寄っており、コード生成、対話、長期記憶、マルチモーダル環境へそのまま一般化できるかは未検証。経験抽出・選択・教師軌跡生成にDeepSeek-V4などのLLMを使っているため、自己進化というより強い外部教師への依存が一部残る。PDF抽出からは、コスト、失敗ケースの詳細分析、経験選択器の頑健性までは十分に断定できない。
- **次に読む/試すなら**: 自分のエージェントログからprinciple-level経験を抽出するプロンプトを作る。global injectionとstep-wise retrieval injectionを小さなReAct環境で比較する。on-policy蒸留が崩れる具体例を軌跡単位で確認する。
- **キーワード**: `LLM agents`, `continual learning`, `experience internalization`, `context distillation`, `self-evolving agents`, `ReAct`, `tool use`

## 気になったこと

- step-wise injectionの経験選択器が失敗した場合、内在化はどの程度壊れるのか。
- principle-level経験の品質を、人手なしでどう評価・フィルタするのがよいか。
- off-policyが安定する一方で、訓練時と推論時の分布ずれをどこまで許容できるのか。
- DeepSeek-V4による経験生成を使わず、学生モデルだけで同等の安定性が出る条件は何か。
- web browsing以外のエージェント、たとえばコード修正エージェントや研究支援エージェントにも同じ3軸が効くか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [chen2026-px-rethinking-continual-experience-internalization-for-self-evo-19e3e415.md](../../chat/2026-06-09/chen2026-px-rethinking-continual-experience-internalization-for-self-evo-19e3e415.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
