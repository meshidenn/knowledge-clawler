# Chat Prompt 2026-09-05

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Token-efficient data reasoning agents via adaptive structuring of unstructured data

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-05 - Token-efficient data reasoning agents via adaptive structuring of unstructured data

## 基本情報

- **タイトル**: Token-efficient data reasoning agents via adaptive structuring of unstructured data
- **著者**: Milad Rezaei Hajidehi, Qitong Wang, Stratos Idreos
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.31082v1](https://arxiv.org/abs/2608.31082v1)

## 落合陽一フォーマット

- **ひとことでいうと**: エージェントが一度読んだ非構造化文書から、将来の関連質問に使えそうな根拠付き構造データを副産物として蓄積し、次回以降の推論コストを下げる「agentic data cracking」を提案した。
- **先行研究と比べてどこがすごい？**: RAGのような固定検索より複雑な多段推論の精度を維持しつつ、質問ごとに文書を読み直す無駄を削る。事前に全コーパスを構造化する知識グラフ構築とも、近似質問の答えを返すsemantic cacheとも異なり、実際の問い合わせに応じて関連しそうな属性・関係まで投機的に構造化する。
- **技術や手法の肝はどこ？**: 回答エージェントが文書を開いた時点で、同じ読み込み済みコンテキストからcracking sub-agentを分岐させる。サブエージェントは現在・過去の質問を手掛かりに、将来再利用できそうなエンティティ、属性、関係を根拠とともに抽出・正規化・検証して保存する。後続質問は構造化ストアを先に読み、足りなければ原文へフォールバックする。
- **どうやって有効だと検証した？**: Claude Haiku 4.5とprompt cachingを用い、FanOutQAおよびHitchcockを題材にしたケーススタディで評価した。FanOutQAでは各テスト質問に対し、人手検証済みの「属性は異なるがエンティティが重なる」関連質問を1件追加してストアを温めた。平均コストは$0.26から$0.12、平均prefill tokenは189Kから87Kへ低下し、LLM判定精度は43.0%から42.0%で統計的に有意な差はないとしている。ケーススタディでは平均コストが$0.81から$0.27へ低下した。
- **議論はある？**: 効果は関連質問が同じ文書・エンティティを再訪するという局所性に依存する。FanOutQAの関連質問はLLM生成後に人手確認しており、実運用ログ由来ではない。構造化ストアへの読み出しは制約付きで、SQLの集約・join・多段クエリを安全に公開する設計は今後の課題である。静的コーパスを前提としており、文書更新時の整合性も未検証。再利用がない質問ではcrackingの追加コストが上回る場合がある。
- **次に読む/試すなら**:
  1. 自分の文書QAログで、文書再訪率・エンティティ重複率・質問の時系列局所性を測る。
  2. 原文位置や引用を必須にした小規模なcracked-object storeを実装し、通常RAGとのコスト・正確性を比較する。
  3. GraphRAG、semantic cache、agent memoryとの役割分担を、更新・根拠追跡・モデル移行の観点で比較する。
- **キーワード**: `agentic data cracking`, `data reasoning`, `adaptive structuring`, `LLM agents`, `prompt caching`, `FanOutQA`

## 気になったこと

- cracked objectの具体的なスキーマ、根拠位置の保持方法、誤抽出や矛盾の検出精度を確認したい。
- 4K tokenのcracking予算を文書・質問ごとに最適化した場合、どこまで改善するか。
- Wikipedia以外の更新頻度が高い社内文書で、構造データの鮮度とアクセス制御をどう扱うか。
- 関連質問が少ないcold startや、複数ユーザーが異なる関心を持つ状況での損益分岐点を知りたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
