# Paperpile Brief 2026-06-24 - GateMem: Benchmarking memory governance in multi-principal shared-memory agents

## 基本情報

- **タイトル**: GateMem: Benchmarking memory governance in multi-principal shared-memory agents
- **著者**: Zhe Ren, Yibo Yang, Yimeng Chen, Zijun Zhao, Benshuo Fu, Zhihao Shu, Bingjie Zhang, Yangyang Xu, Dandan Guo, Shuicheng Yan
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2606.18829

## 落合陽一フォーマット

- **ひとことでいうと**: 複数ユーザーが共有するLLMエージェントの記憶が、「覚える」だけでなく、正しい相手にだけ開示し、削除要求後に再生しないかを測るベンチマーク GateMem を提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のメモリ評価は単一ユーザーの長期記憶・想起・更新に寄りがちだが、本論文は医療、職場、教育、家庭のような複数主体の共有メモリ環境で、utility、access control、active forgetting を同時に評価する点が新しい。91本の長いマルチパーティエピソードと2,218個の隠しチェックポイントを使い、ロール・関係・スコープ・削除要求を含む統治問題として定式化している。
- **技術や手法の肝はどこ？**: 共有メモリを単なる検索対象ではなく、権限境界つきの状態として扱う設計。各エピソードに複数のprincipal、役割、関係、アクセス規則、時系列の更新、削除要求を埋め込み、チェックポイントでは正当な長期利用、非認可アクセスへの拒否、削除済み情報の非回復を分けて採点する。漏洩対象アノテーションやstructured judgingも用意して、単に「拒否したか」ではなく、返答中に保護情報を確認・示唆していないかも見る。
- **どうやって有効だと検証した？**: Long-context prompting、RAG系、外部メモリ系など複数のベースラインとバックボーンモデルで評価している。結果として、強いutility、堅牢なaccess control、信頼できるactive forgettingを同時に満たす手法はなかった。Long-contextは比較的よい統治スコアを出すがトークンコストが高く、retrieval/external-memory系はコストを抑える一方で非認可情報や削除済み情報を漏らす傾向が残る。
- **議論はある？**: ベンチマークはLLM支援で構築されたシナリオに依存しており、現実の組織ポリシーや法的要件をどこまで代表できるかは追加検証が必要。active forgettingも物理的なストア削除や機械学習モデルのunlearningではなく、エージェント応答レベルの「行動的非回復」を測っている点に注意がいる。細かな数値はPDF抽出テキストのレイアウト崩れがあり得るため断定しすぎない。
- **次に読む/試すなら**: 1. GateMemのデータセットと評価コードを確認し、自分のメモリエージェントでutility/access control/forgettingを分けて測る。2. 削除済み情報に対する「no_memory」と「refuse」の違いを実装ポリシーに落とす。3. RAGのretrieval段階で権限・削除状態をどうフィルタするかを最小実験する。
- **キーワード**: `LLM agents`, `memory governance`, `shared memory`, `access control`, `active forgetting`, `benchmark`, `multi-principal agents`

## 気になったこと

- active forgettingを「削除済み情報を答えない」だけでなく、検索インデックス・ログ・キャッシュからの実削除とどう接続するか。
- 権限判定をプロンプトで行う場合と、外部ポリシーエンジンで強制する場合の失敗モードの違い。
- 「部分的に正当な依頼者」がいる医療・家庭ドメインで、redactionの粒度をどう評価するか。
- GateMemのシナリオが英語・特定制度圏に偏っている場合、日本の医療・教育・企業文脈に移植できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [ren2026-tj-gatemem-benchmarking-memory-governance-in-multi-principal-sha-66f48e07.md](../../chat/2026-06-24/ren2026-tj-gatemem-benchmarking-memory-governance-in-multi-principal-sha-66f48e07.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
