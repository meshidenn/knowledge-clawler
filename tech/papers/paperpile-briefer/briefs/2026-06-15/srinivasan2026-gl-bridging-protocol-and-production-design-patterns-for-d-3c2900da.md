# Paperpile Brief 2026-06-15 - Bridging protocol and production: Design patterns for deploying {AI} agents with Model Context Protocol

## 基本情報

- **タイトル**: Bridging protocol and production: Design patterns for deploying {AI} agents with Model Context Protocol
- **著者**: Vasundra Srinivasan
- **年 / venue**: 2026 / arXiv [cs.SE]
- **リンク**: https://arxiv.org/abs/2603.13417v1 / arXiv:2603.13417v1

## 落合陽一フォーマット

- **ひとことでいうと**: MCPを本番環境でAIエージェントの外部ツール接続に使うときに足りない、ID伝播、タイムアウト予算配分、構造化エラー処理を、設計パターンと検証可能な仮説として整理した論文。
- **先行研究と比べてどこがすごい？**: MCPの一般的な仕様説明やセキュリティ分類に留まらず、企業導入で見えた具体的な失敗モードを、CABP、ATBA、SERFという3つの実装可能な仕組みに落としている点。特に、MCPの「ツールを呼べる」段階と「安全に本番運用できる」段階の差分を明確化している。
- **技術や手法の肝はどこ？**: CABPはブローカー層でJWTを検証し、ユーザー/テナント/ロール/スコープをJSON-RPCリクエストへ注入し、ACL確認、レスポンスサニタイズ、監査ログまで行う。ATBAは逐次ツールチェーンの総ターン予算を、各ツールのp99レイテンシに応じて動的配分する。SERFは`retryable`、`suggested_actions`、エラー分類を持つ機械可読エラーで、エージェントの自己修復を決定的にする。
- **どうやって有効だと検証した？**: 本文では、企業向けAIエージェント基盤とクラウドプロバイダのMCPサーバ統合から得たフィールド観察と失敗事例を根拠にしている。さらに、CABP/ATBA/SERFについては、合成MCPサーバ、ブローカー、負荷生成器、LLMエージェントを使った再現実験方法を提示している。ただし、各仮説の数値効果は提案・予測であり、本文上では大規模な実測結果として確定していない。
- **議論はある？**: クライアント名や詳細環境は秘匿されており、一般化可能性には注意が必要。CABPの追加レイテンシ、ATBAのp99推定の安定性、SERFが実際のLLMエージェント挙動にどこまで効くかは、提案されたベンチマークでの独立検証が必要。MCP仕様自体も変化し得るため、2025-11-25版仕様前提の議論である。
- **次に読む/試すなら**: MCPサーバ実装で、まずツール定義の説明、JSON Schema、idempotency、structured errorを点検する。次に、JWT検証とテナント境界を担う最小ブローカーを試作する。最後に、逐次ツールチェーンのp95/p99レイテンシを取り、固定タイムアウトとATBA風配分を比較する。
- **キーワード**: `MCP`, `AI agents`, `JSON-RPC`, `identity propagation`, `tool orchestration`, `structured errors`, `timeout budgeting`, `production readiness`

## 気になったこと

- CABPは実務的だが、MCP仕様に将来ネイティブなユーザーコンテキスト伝播が入った場合、どこまで残る設計なのか。
- ATBAはp99レイテンシ前提なので、観測数が少ない新規ツールや季節性のあるAPIでどう安定化するか。
- SERFの`recommended_actions`を、各LLMクライアントが同じように解釈できるのか。仕様化しないとベンダー差が出そう。
- 失敗事例は説得力があるが、実測ベンチマーク結果ではなく仮説提示の色が強い。再現コードや公開ベンチマークの有無を確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [srinivasan2026-gl-bridging-protocol-and-production-design-patterns-for-d-3c2900da.md](../../chat/2026-06-15/srinivasan2026-gl-bridging-protocol-and-production-design-patterns-for-d-3c2900da.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
