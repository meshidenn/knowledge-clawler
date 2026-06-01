# 週次トレンド分析プロンプトテンプレート

## 使い方

1. systemd user timer が毎週日曜に `scripts/run_weekly.sh` を自動実行する
2. 手動の場合は `scripts/run_weekly.sh` を実行（内部で OpenAI Codex `codex exec`）
3. `papers/daily/*.md` の対象分が結合され Codex に渡される

---

## システムプロンプト

```
あなたはAI/ML論文のリサーチアナリストです。
金融AIエージェント開発者の視点から、Hugging Face Daily Papersの週次トレンドを分析します。

### 追跡テーマ（優先度順）

1. **MoE / 効率的アーキテクチャ**
   - Expert Parallelism, MoE upcasting, ルーティング戦略
   - 量子化（AWQ/GPTQ/INT4）、推論最適化
   - 関連キーワード: Mixture of Experts, sparse model, expert routing, load balancing, conditional computation

2. **金融AI / ドメイン特化LLM**
   - 金融テキスト理解、XBRL処理、決算分析
   - ドメイン特化ファインチューニング、ハルシネーション抑制、**RAG・埋め込み・検索品質**
   - 関連キーワード: financial NLP, domain adaptation, structured output, compliance, regulatory, RAG, dense retrieval, embedding model, multilingual embedding

3. **マルチエージェント / ツール利用**
   - エージェントオーケストレーション、ツールコーリング
   - 計画・推論・自己修正ループ、**研究・実験の自動化エージェント**
   - 関連キーワード: multi-agent, tool use, function calling, agentic workflow, planning, AI scientist, synthetic task scaling, automated scientific discovery

4. **ファインチューニング / RLHF / DPO**
   - LoRA/QLoRA、DPO/KTO/ORPO
   - 表現崩壊、勾配フロー、学習安定性、**ドメイン特化PEFT・VLM適応**
   - 関連キーワード: SFT, preference optimization, reward model, alignment, representation collapse, PEFT, domain-specific LoRA, VLM fine-tuning

### 分析の原則

- **「だから何？」テスト**: 各発見に対し「自分のプロジェクトにどう使えるか」まで踏み込む
- **テーマ横断の接続**: 例「MoEの新ルーティング手法×金融ドメイン特化の可能性」
- **実装可能性**: 理論だけでなく、RTX 6000 Pro × PCIe環境で試せるかの現実性チェック
- **差分重視**: 先週との変化、新しい流れの兆候を明示する
```

---

## ユーザープロンプト（週次分析）

以下をそのまま貼り付けて使う。`{{...}}` の部分を実際のデータに置き換える。

```
# 今週の論文データ

期間: {{YYYY/MM/DD}} 〜 {{YYYY/MM/DD}}

## 今週ピックアップした論文
{{ここに日次で溜めた論文リストを貼る。最低限タイトルとarXiv URLがあればOK}}

---

# 分析リクエスト

以下の構造で今週のトレンド分析をお願いします。

## 1. テーマ別ハイライト（各テーマ3〜5文）
各テーマについて:
- 今週の注目論文とその意義
- 先週からの変化・新しい動き
- 見落としがちだが重要なポイント

## 2. テーマ横断マップ
テーマ間の接続を具体的に示してください:
- どの論文の手法が別テーマに転用可能か
- 複数テーマにまたがる論文があればハイライト
- 「AのアプローチをBに適用すると面白い」という仮説

## 3. 金融AIエージェントへの示唆（最重要）
私のプロジェクト文脈:
- MoEモデル（Qwen3.5-397B級）のPCIe環境推論
- 投資判断・ポートフォリオ管理・M&Aバリュエーション用エージェント
- LoRA/QLoRAによるドメイン特化SFT
- 構造化出力スキーマの品質向上

この文脈に対して:
- 今週すぐ試せるアクションアイテム（最大3つ）
- 中期的に注視すべき研究方向
- 「これは自分には関係ない」と判断した論文とその理由

## 4. 来週の注目ポイント
- 今週の流れから来週チェックすべきキーワード/著者/研究グループ
- 追跡テーマの更新提案（新キーワード追加 or 不要なもの削除）
```

---

## 補助プロンプト（オプション）

### 特定論文の深掘り

週次分析で気になった論文を掘り下げる時に使う。

```
以下の論文を深掘り分析してください。

論文: {{タイトルまたはarXiv URL}}

### 分析観点
1. **手法の核心**: 何が新しいのか、先行研究との差分は何か（3文以内）
2. **実験設計の評価**: ベースラインの妥当性、評価指標の適切さ、再現可能性
3. **限界と死角**: 著者が触れていない弱点、スケーラビリティ懸念
4. **私のプロジェクトへの適用**:
   - 適用可能性: High / Medium / Low（理由付き）
   - 具体的にどのコンポーネントに使えるか
   - 実装するなら最初のステップは何か
5. **関連して読むべき論文**: この論文の前提知識 or 発展形（2〜3本）
```

### テーマ追加/更新の判断

四半期に1回程度で追跡テーマを見直す時に使う。

```
現在の追跡テーマ4つを振り返り、以下を分析してください。

1. **各テーマの論文出現頻度の推移**: 増加/安定/減少
2. **見逃しているホットトピック**: 追跡テーマに入っていないが、
   HF Daily Papersで頻出かつ私のプロジェクトに関連しそうな領域
3. **テーマ更新の提案**:
   - 追加すべきテーマ（理由と期待される情報価値）
   - 統合/分割すべきテーマ
   - 削除候補（出現頻度が低い or プロジェクトとの関連が薄い）
```

---

## 運用ノート

### 日次インテーク（自動）

systemd user timer が平日朝に `scripts/run_daily.sh` を実行。結果は `papers/daily/{日付}.md` に保存される。

### 週次分析（自動）

systemd user timer が日曜に `scripts/run_weekly.sh` を実行。`papers/daily/` の今週分を集約して分析。

### 手動で週次分析を実行する場合

```
claude "今週の週次トレンド分析を実行して"
```

### 論文データの検索

リポジトリ内の全論文を横断検索したい場合:

```bash
# テーマで検索
grep -rl "\[T1\]" papers/daily/

# High 重要度の論文を一覧
grep -h "⚡High" papers/daily/*.md

# 特定キーワードで検索
grep -rn "expert routing" papers/
```
