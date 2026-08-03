# Paperpile Brief 2026-08-04 - Filesystem-based memory for LLM agents: Organization, evolution, and sustainability

## 基本情報

- **タイトル**: Filesystem-based memory for LLM agents: Organization, evolution, and sustainability
- **著者**: Sizhe Zhou, Sheldon Yu, Hui Wei, Junda Wu, Siru Ouyang, Yizhu Jiao, Shijia Pan, Julian McAuley, Yu Zhang, Tong Yu, Jiawei Han
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.26637 / arXiv:2607.26637

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agent の長期記憶を markdown file と directory tree で持つ「filesystem-based memory」について、整理・検索・成長時の劣化・tool harness の影響を体系的に評価した論文。
- **先行研究と比べてどこがすごい？**: 既存研究が専用 memory representation や retrieval 手法に寄りがちだったのに対し、実運用で広く使われる「file system を agent が読む・書く・再編成する」という素朴な default 自体を研究対象にした点が新しい。organized store は大規模な材料で retrieval cost をおおむね半減させる一方、answer quality を必ず改善するわけではない、という実証的な切り分けが重要。
- **技術や手法の肝はどこ？**: 1つの memory filesystem を中心に、incoming content を統合・整理する **management agent**、query に対して citation 付きで探す **search agent**、task trajectory を供給する **execution agent** の3役で定式化している。memory shape として agent-organized hierarchy、verbatim dump、chunk retrieval などを比較し、declarative memory と procedural skill を同じ store で扱う。
- **どうやって有効だと検証した？**: LoCoMo、PersonaMem、REALTALK などの long-conversation QA と、ALFWorld の embodied task で評価。store の形、stream scale、tool harness、management/search agent の model strength を変え、answer quality、citation、search cost、token/tool call、store health、成長に伴う organization の維持を測っている。
- **議論はある？**: organized filesystem は検索コストには効くが、本文で測定された範囲では「整理されたから回答精度が上がる」とは言えない。management agent の能力が低いと taxonomy contract が成長とともに崩れ、強い model でも store を elaborate にするだけで answer quality に直結しない場合がある。PDF抽出範囲では、より長期の運用や実ユーザー環境での持続性は未検証に見える。
- **次に読む/試すなら**: 自分の agent memory を「verbatim log」「topic folder」「agent-curated markdown」の3方式で小さく比較する。検索コストと回答精度を分けて測る。tool set の違いだけで store shape が変わるかを再現実験する。
- **キーワード**: `LLM agents`, `filesystem memory`, `long-term memory`, `agent memory`, `retrieval cost`, `memory organization`, `skills`

## 気になったこと

- quality benchmark が store shape の良し悪しを十分に測れていない可能性がある。
- 「整理」は人間には解釈しやすいが、強い search agent には必ずしも必要ないのかもしれない。
- Codex/Claude Code のような実際の coding agent memory で、どの粒度の file/heading が最も保守しやすいかを試したい。
- stale facts や contradictory memories をどう検出・更新するかは、実装上かなり重要そう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhou2026-dv-filesystem-based-memory-for-llm-agents-organization-evolutio-4b99f349.md](../../chat/2026-08-04/zhou2026-dv-filesystem-based-memory-for-llm-agents-organization-evolutio-4b99f349.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
