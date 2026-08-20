# Chat Prompt 2026-08-21

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {DeepResearcher}: Scaling deep research via reinforcement learning in real-world environments

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-21 - DeepResearcher: Scaling Deep Research via Reinforcement Learning in Real-world Environments

## 基本情報

- **タイトル**: DeepResearcher: Scaling Deep Research via Reinforcement Learning in Real-world Environments
- **著者**: Yuxiang Zheng, Dayuan Fu, Xiangkun Hu, Xiaojie Cai, Lyumanshan Ye, Pengrui Lu, Pengfei Liu
- **年 / venue**: 2025 / EMNLP 2025（メタデータ上は arXiv [cs.AI]）
- **リンク**: [論文PDF](https://aclanthology.org/2025.emnlp-main.22.pdf) / [実装](https://github.com/GAIR-NLP/DeepResearcher)

## 落合陽一フォーマット

- **ひとことでいうと**: 実際のWeb検索・閲覧環境でLLMエージェントをend-to-end RL学習し、固定コーパスRAGでは身につきにくい探索・検証・軌道修正能力を獲得させる枠組み。
- **先行研究と比べてどこがすごい？**: プロンプト設計やローカルRAG上のRLではなく、ノイズ・遅延・アクセス制限を含む生のWebを学習環境にした点が核。OOD評価では全比較手法を上回り、BamboogleでMBE 72.8を達成した。著者報告では、プロンプト系より最大28.9点、RAGベースRLより最大7.2点改善。
- **技術や手法の肝はどこ？**: Qwen2.5-7B-InstructをGRPOで学習する。主エージェントが検索・閲覧・回答を反復し、閲覧側は複数のReading Agentでページ断片を読み、Synthesis Agentが統合する。正解との単語F1を報酬、形式不備を-1のペナルティとし、検索なしで解ける汚染例を除いた8万QAで訓練する。
- **どうやって有効だと検証した？**: IDのNQ、TriviaQA、HotpotQA、2Wikiと、OODのMuSiQue、Bamboogle、PopQAで評価。各512件（Bamboogleは全125件）を用い、正規化F1とGPT-4o-miniによるLLM-as-a-Judge（MBE）を測定。Web版とローカルRAG版のアブレーションも比較し、Web環境での訓練の優位性を示した。
- **議論はある？**: 7Bモデルのみで大規模化の検証は未実施。短答QAのF1報酬なので、長文・曖昧・多観点の「深い調査」を直接最適化できているとは限らない。実Webへの依存は検索結果の変動、クロール制約、コスト、再現性に影響しうる。
- **次に読む/試すなら**:
  - 同一モデル・同一予算で、Web訓練と固定RAG訓練の差を再現する。
  - 長文調査向けに、引用の正確性・網羅性・不確実性表明を含む報酬を設計する。
  - 検索API費用、キャッシュ、失敗時リトライを含む運用コストを測定する。
- **キーワード**: `deep research agent`, `reinforcement learning`, `GRPO`, `web search`, `RAG`, `LLM agent`

## 気になったこと

- 「実Webで学習したから一般化した」という因果は、検索エンジン・クロール器・閲覧マルチエージェントの寄与とどこまで分離できているか。
- Web検索結果の時点依存性に対し、ベンチマーク再現性とキャッシュ方針をどう担保するか。
- F1最適化が、引用付き長文レポートの正確性・根拠追跡・適切な保留をどれだけ改善するか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
