# Paperpile Brief 2026-07-09 - Self-distilled reasoner: On-Policy Self-distillation for large language models

## 基本情報

- **タイトル**: Self-distilled reasoner: On-Policy Self-distillation for large language models
- **著者**: Siyan Zhao, Zhihui Xie, Mengchen Liu, Jing Huang, Guan Pang, Feiyu Chen, Aditya Grover
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: Code repo: https://github.com/siyan-zhao/OPSD

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの数学推論能力を、別の大型teacherなしで、同一モデルの「privileged情報ありteacher」と「通常入力のみstudent」の分布差を使って自己蒸留する手法を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のon-policy distillationはstudent自身の軌跡に対してteacherがdenseなtoken-level supervisionを与えるが、別の強いteacherが必要だった。この論文は単一LLMをteacher/studentの両方に使い、teacher側だけにverified reasoning tracesなどの特権情報を与えることで、外部teacher依存を減らす点が新規性。abstractベースでは、RLよりtoken効率がよく、off-policy distillationより性能が良いと主張している。
- **技術や手法の肝はどこ？**: On-Policy Self-Distillation, OPSD。student policyは問題文だけを見て自身のrolloutを生成し、teacher policyは同じモデルだがverified reasoning tracesなどのprivileged informationを条件として見る。そのうえで、student自身のrollout上でteacher分布とstudent分布のper-token divergenceを最小化する。
- **どうやって有効だと検証した？**: 複数の数学推論ベンチマークで評価したとされる。比較対象はreinforcement learning methodsとoff-policy distillation methods。ただしPDF本文がなく、具体的なベンチマーク名、モデルサイズ、数値、統計的有意性、計算量条件はメタデータからは不明。
- **議論はある？**: PDF本文がないため、限界や失敗例の詳細はメタデータからは不明。気になる点は、privileged reasoning tracesの品質・入手コスト、teacher/studentが同一モデルであることによる性能上限、誤ったtraceを合理化してしまうリスク、数学以外の推論タスクへの一般化。
- **次に読む/試すなら**: GitHub repoでOPSDの実装と学習lossを確認する。数学ベンチマークごとの比較表をPDFで確認する。小さいopen modelでverified traceあり/なしの最小実験を再現する。
- **キーワード**: `on-policy distillation`, `self-distillation`, `LLM reasoning`, `mathematical reasoning`, `token-level supervision`, `privileged information`

## 気になったこと

- teacher側に与えるverified reasoning tracesは、ground-truth解答からどう構成しているのか。
- student rollout上でteacher分布を計算する設計は、探索不足や早期の低品質trajectoryにどれくらい弱いのか。
- RLよりtoken効率が良いという主張の比較条件、特に同一compute・同一データでの比較かを確認したい。
- off-policy distillationとの差分が、on-policy性によるものか、privileged contextによるものか、ablationが必要。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhao2026-dq-self-distilled-reasoner-on-policy-self-distillation-for-larg-5ae81954.md](../../chat/2026-07-09/zhao2026-dq-self-distilled-reasoner-on-policy-self-distillation-for-larg-5ae81954.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
