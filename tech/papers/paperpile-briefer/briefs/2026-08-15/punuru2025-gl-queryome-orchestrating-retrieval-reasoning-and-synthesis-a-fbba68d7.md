# Paperpile Brief 2026-08-15 - Queryome: Orchestrating retrieval, reasoning, and synthesis across biomedical literature

## 基本情報

- **タイトル**: Queryome: Orchestrating retrieval, reasoning, and synthesis across biomedical literature
- **著者**: Pranav Punuru, Nabil Ibtehaz, Swagarika Giri, Harsha Srirangam, Emilia Tugolukova, Daisuke Kihara
- **年 / venue**: 2025 / bioRxiv（査読前プレプリント）
- **リンク**: [DOI: 10.64898/2025.12.22.696019](https://doi.org/10.64898/2025.12.22.696019)

## 落合陽一フォーマット

- **ひとことでいうと**: 2,830万件のPubMed抄録を対象に、複数LLMエージェントが検索・批判・統合を反復する、生物医学向けDeep Research基盤「Queryome」を提案した論文。
- **先行研究と比べてどこがすごい？**: 単発のRAGではなく、主任研究者（PI）エージェントが問いの複雑さに応じてplanner–criticチームを増減させる。MIRAGEで平均88.98%を達成し、従来最良のGPT-4 + MedRAG（79.97%）を上回る。商用Deep Research群とのレビュー生成比較でも最高の総合評価を報告する。
- **技術や手法の肝はどこ？**: FAISSによるdense検索と、title/abstract・著者キーワード・MeSH向けのBM25検索を混ぜるハイブリッド検索が土台。その上でPIがサブタスクを分解し、plannerが検索、criticが根拠の十分性を点検、synthesizerが引用付き回答へ統合する。検索・評価・出力の履歴を残す設計も特徴。
- **どうやって有効だと検証した？**: MIRAGEの7,663問・5データセット、HLEのbiomedical text-only 222問、既存レビュー5本を再構成するReview Generation Testで評価した。MIRAGEは3回実行の平均、レビュー生成はClaude・Gemini・GPTの3 LLM審査員による6観点評価で比較している。アブレーションでは、o3単体84.6%に対しQueryomeは89.0%で、検索・オーケストレーションの寄与を検討した。
- **議論はある？**: コーパスは全文ではなくPubMed抄録中心のため、方法・結果の細部や否定的証拠を取りこぼしうる。レビュー生成評価は5題材かつLLM-as-a-judgeであり、商用ツールの検索条件も完全には統制しにくい。医学試験問題では、文献に忠実な回答が「単一の試験正答」とずれる例もあり、MedQA/MedMCQAではo3単体より低い結果が報告されている。なお、HLEの数値は抄録と本文表で異なるため、評価設定・分割の確認が必要。
- **次に読む/試すなら**:
  1. planner–criticのプロンプト、停止条件、検索回数制御を補足資料で確認する。
  2. 自分の専門領域で、MeSH検索・ハイブリッド検索・単純RAGの比較実験を行う。
  3. 抄録のみと全文利用で、根拠被覆率・引用の正確性がどれだけ変わるか測る。
- **キーワード**: `agentic RAG`, `biomedical literature`, `multi-agent systems`, `hybrid retrieval`, `PubMed`, `Deep Research`

## 気になったこと

- 2,830万件の抄録検索は強力だが、全文・図表・補足資料が必要な問いへの性能は未検証に見える。
- criticが「十分な証拠」と判断する基準、および相反する研究結果をどう保持・提示するかを確認したい。
- 実運用でのレイテンシ、APIコスト、問い合わせ複雑度に応じたエージェント数の増え方が重要。
- HLEの抄録記載値と本文表の値に差があるため、再現時には評価プロトコルを精査すべき。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [punuru2025-gl-queryome-orchestrating-retrieval-reasoning-and-synthesis-a-fbba68d7.md](../../chat/2026-08-15/punuru2025-gl-queryome-orchestrating-retrieval-reasoning-and-synthesis-a-fbba68d7.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
