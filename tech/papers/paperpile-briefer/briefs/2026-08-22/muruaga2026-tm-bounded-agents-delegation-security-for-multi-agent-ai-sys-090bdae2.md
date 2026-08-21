# Paperpile Brief 2026-08-22 - Bounded agents: Delegation security for multi-agent AI systems

## 基本情報

- **タイトル**: Bounded agents: Delegation security for multi-agent AI systems
- **著者**: Xabier Muruaga
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.15888v1](https://arxiv.org/abs/2608.15888v1)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントのprompt injection対策を「モデルを賢くする問題」ではなく「委譲権限をセッション全体で制御する認可設計の問題」と捉え、委譲・行動履歴・予算を追跡するAgentic Principal Chain（APC）を提案した。
- **先行研究と比べてどこがすごい？**: OAuth、RBAC、ABACのような個別リクエスト単位の認可では防げない、「読める」＋「外部送信できる」を組み合わせた情報流出を扱う。各委譲ホップで権限と予算を縮小し、過去の行動との禁止組合せをインフラ側で強制する点が新しい。
- **技術や手法の肝はどこ？**: APCは、署名付きのセッション認可状態を委譲チェーンに持たせ、スコープ、消費済み予算、承認、監査証跡、タスク意図、禁止行動列を評価する6つの認可条件でツール呼び出しを許可・拒否する。中心概念の「composition closure」は、行動ペアや順序付きk-tupleの禁止集合により、多段階の権限濫用を止める。
- **どうやって有効だと検証した？**: 3,154件の評価で、InjecAgent、AgentDojo、ASB、委譲チェーン試験、適応的攻撃を用いた。モデルが完全に侵害された想定で正解の攻撃ツール呼び出しを直接注入する評価では、AgentDojoの4領域で外部流出成功率が75–100%から0%になったと報告する。認可処理の99パーセンタイル遅延は0.24 ms、ただしAgentDojoのutilityは条件により8.6または13.9ポイント低下した。
- **議論はある？**: 形式的保証は、禁止集合が完全であり、認可判定が直列化されることを前提とする。単一操作の悪用、パラメータレベルの危険操作、粗い行動型による意図との重なり、セッションをまたぐ攻撃は主対象外または残余リスクである。評価は主に合成ベンチマークで、定理は機械検証されていない。
- **次に読む/試すなら**:
  - MCPツールゲートウェイの前に、`read → send_external` などの禁止行動列を持つ最小PEPを置く。
  - 自分のエージェントの権限委譲を、親権限との積集合・累積予算として実装できるか確認する。
  - Progent、CaMeL、SEAgentと比較し、行動型制約・データフロー制約・パラメータ検証を組み合わせる設計を検討する。
- **キーワード**: `agentic AI`, `authorization`, `delegation`, `prompt injection`, `multi-agent security`, `MCP`, `composition closure`

## 気になったこと

- 禁止行動列や行動型分類を誰がどの粒度で保守するのか。分類が粗いほど、正当な操作と攻撃操作が同型になり、意図拘束だけでは止めにくい。
- 「完全な禁止集合」という前提を実運用でどう測定・更新するか。未知のツールや新しいワークフローに対するポリシー欠落が主要な攻撃面になりそうである。
- セッション分割による回避と、複数エージェント・複数セッションをまたぐ情報流出を追跡する永続的なlineage設計が必要になる。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [muruaga2026-tm-bounded-agents-delegation-security-for-multi-agent-ai-sys-090bdae2.md](../../chat/2026-08-22/muruaga2026-tm-bounded-agents-delegation-security-for-multi-agent-ai-sys-090bdae2.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
