# Chat Prompt 2026-08-04

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Is Deep Research reliable? Misleading Knowledge induces false conclusions

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-04 - Is Deep Research reliable? Misleading Knowledge induces false conclusions

## 基本情報

- **タイトル**: Is Deep Research reliable? Misleading Knowledge induces false conclusions
- **著者**: Pengyu Zhu, Lijun Li, Longju Yang, Sen Su, Jing Shao
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2607.20891v2 / arXiv:2607.20891v2 / DOI: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: Deep Researchエージェントが、もっともらしいが事実として誤った文書に触れたとき、最終レポートで誤結論を採用してしまうかを、MisKnow-Agentという評価フレームワークで検証した論文。
- **先行研究と比べてどこがすごい？**: 既存研究が短いQAやRAGの誤検索耐性を主に見ていたのに対し、この論文は計画・検索・読解・中間分析・最終合成を含む長いDeep Research workflow全体で、誤情報が「取得される」だけでなく「結論として採用される」かを測っている。1件の誤情報注入だけで平均FCARが0%から54.7%に上がるという結果が強い。
- **技術や手法の肝はどこ？**: 各タスクに対して、手動監査済みの偽結論、権威レベル別の機関プロファイル、採用判定基準を含むblueprintを作り、Paper/News/Blog/PostなどのstyleとHigh/Medium/Lowのauthorityを制御して誤誘導文書を生成する。生成後は複数のsearch-enabled verifierと手動スクリーニングで、実在しない・権威情報と矛盾する偽情報だけを残す。
- **どうやって有効だと検証した？**: DeepResearch Benchの100タスクから5,933件のmisleading documentsを構築し、DeerFlowとWebThinkerにDeepSeek-V4 Pro、Qwen3.5-397B、Intern-S1-Proを組み合わせて評価した。指標は最終レポートが偽結論を自分の結論として採用した割合FCAR。検索順位、注入タイミング、権威性、文書style、注入文書数、framework/LLM差、Gemini Deep Researchへの一般化、防御策まで比較している。
- **議論はある？**: 誤情報のsearch-result rankは大きく効かず、final synthesis直前に入った誤情報が特に危険だった。Paper風のpresentationと高権威source cueは採用率を上げる。pre-research promptやpost-research refinementはFCARを下げるがゼロにはできず、組み合わせてもモデルによっては加算的に効かない。閉じた実験環境なので、実Web環境での分布や実ユーザー行動までの一般化は追加検証が必要。
- **次に読む/試すなら**: Deep Research系ワークフローに「中間状態へ入る証拠の検証」を組み込む設計を試す。FCARだけでなく、誤情報の取得率MERと取得後採用率ECARを分けてログ化する。自分のresearch agentにpaper-like fake sourceを混ぜた最小再現実験を作る。
- **キーワード**: `Deep Research`, `misleading knowledge`, `LLM agents`, `RAG robustness`, `FCAR`, `evidence verification`

## 気になったこと

- 誤情報を「全verifierがMisと判定したもの」に絞ってもagentが最終結論で採用する点は、単発のfact-check能力と長期workflow内の証拠管理能力が別物であることを示している。
- post-research refinementが同じ混合検索環境を使うため、再び誤情報を拾ってしまう可能性がある。検証用retrieval environmentは本体検索と分離すべきかもしれない。
- Paper styleがNews/Blog/Postより強いなら、論文PDF・preprint・技術報告書風の文書をどう信頼度スコアリングするかが重要。
- 評価対象のDeep Research agentが引用の独立性、一次情報、claim-level provenanceをどこまで内部表現として保持していたかを追加で見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
