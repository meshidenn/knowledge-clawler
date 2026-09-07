# Paperpile Brief 2026-09-08 - Using Grounded Theory for agent behavior analysis at scale

## 基本情報

- **タイトル**: Using Grounded Theory for agent behavior analysis at scale
- **著者**: Zhuoran Lu, Yangyang Yu, Zhuoyan Li, Yibo Meng, Nan Jiang, Chengxi Zang, Jie Gao, Ziang Xiao
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.30391v1](https://arxiv.org/abs/2608.30391v1)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMエージェントの長大な行動軌跡を、Grounded Theoryの手順で自動コード化し、失敗・成功の行動パターンを監査可能な形で抽出するAutoTraceGTを提案した。
- **先行研究と比べてどこがすごい？**: 既定の失敗分類器や人手分析ではなく、データから分類体系を帰納的に作る。open／axial／theoretical codingを役割分担した複数エージェントで実装し、飽和基準に達するまで反復する点が新しい。人手タクソノミーの失敗モードを73〜91%回収し、既存分類にない行動パターンも発見した。
- **技術や手法の肝はどこ？**: OpenCodeが各軌跡の根拠付き行動コードを作り、AxialCodeがバッチ横断でカテゴリ・関係を構成し、Manageが既存コードブックと照合して追加・統合・分割を記録する。新規カテゴリ追加が閾値未満の状態が連続したときに飽和とみなし、TheoreticalCodeが全体の説明へ統合する。
- **どうやって有効だと検証した？**: 6環境・7,500件超の軌跡、4種類のバックボーンLLMで評価した。コードブックの飽和と再現性、ALFWorld・GAIA・WebShopの人手失敗分類との対応、既存の専門家分析との理論的一致、軌跡途中からの失敗予測を検証した。コードブック由来特徴は、直接few-shot予測やfew-shotで作るコードブックを上回る条件があり、両者の併用が有効な場合もある。
- **議論はある？**: 全コーディング段階と一部評価がLLMに依存するため、共有バイアスやLLM judge依存の可能性が残る。飽和は「新規カテゴリ追加数」で近似しており、質的研究上の理論的飽和と同一ではない。多数のLLM呼び出しを要するオフライン分析向けであり、英語の単一エージェント軌跡・公開ベンチマーク以外への一般化は未検証。
- **次に読む/試すなら**:
  - 公開コードで小規模なSWE-AgentまたはWebArena軌跡に適用し、生成されるコードブックを人手レビューする。
  - 飽和判定をカテゴリ追加数だけでなく、カテゴリ内の事例密度・関係の安定性でも測る。
  - 抽出した行動カテゴリを、報酬設計・失敗時の介入・評価指標に接続する。
- **キーワード**: `LLM agents`, `Grounded Theory`, `trajectory analysis`, `multi-agent systems`, `failure analysis`, `behavioral taxonomy`

## 気になったこと

- LLM judgeによる分類対応の評価を、より大規模な独立人手評価で再現できるか。
- コードブックのカテゴリ数・内容が、バックボーンモデルやプロンプト、温度にどこまで依存するか。
- 飽和後に見落とされた稀な失敗パターンを、能動的サンプリングでどの程度補えるか。
- 分析結果を実際のエージェント改善へ使った場合、成功率・安全性・計算コストがどう変わるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [lu2026-mk-using-grounded-theory-for-agent-behavior-analysis-at-scale-e7151e3c.md](../../chat/2026-09-08/lu2026-mk-using-grounded-theory-for-agent-behavior-analysis-at-scale-e7151e3c.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
