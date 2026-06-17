# Chat Prompt 2026-06-18

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Where did it go wrong? Process-level evaluation of web agents with semantic state tracking

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-06-18 - Where did it go wrong? Process-level evaluation of web agents with semantic state tracking

## 基本情報

- **タイトル**: Where did it go wrong? Process-level evaluation of web agents with semantic state tracking
- **著者**: Jiwan Chung, Jihyuk Byun, Vibhav Vineet, Seon Joo Kim
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2606.15673v1 / arXiv:2606.15673v1

## 落合陽一フォーマット

- **ひとことでいうと**: Webエージェントを最終成功率だけでなく、GUI操作の背後にある意味状態遷移まで追跡して「どこで失敗したか」を診断するベンチマーク WEBSTEP を提案した論文。
- **先行研究と比べてどこがすごい？**: WebArenaやWebVoyagerなどが主に終端成功で評価するのに対し、各Webサイトを決定的な semantic MDP として実装し、探索失敗・実行失敗・スキル呼び出し・分岐点を自動で分解できる。1,800タスク、10サイト、hard negative制御つきで、手動アノテーションやLLM judgeに依存しない点が差分。
- **技術や手法の肝はどこ？**: エージェントは通常のGUIだけを操作するが、環境側ではGUIが semantic MDP の状態からレンダリングされる。クリックや入力などの低レベル操作を、検索、詳細ページ閲覧、フィルタ、最終コミットなどの高レベル意味遷移に変換し、軌跡全体を `s0, a0, s1...` として記録する。
- **どうやって有効だと検証した？**: Fara-7B、GUI-Owl-1.5-8B、UI-TARS-1.5-7B、Qwen3.5-122B、OpenAI CUA を WEBSTEP 上で評価。小型3モデルは終端成功率が31〜33%付近で似ているが、探索成功率、実行成功率、情報カバレッジ、ステップ効率では異なる失敗パターンが出ることを示した。例として Housing では OpenAI CUA が commit に強い一方、filter では Qwen3.5 に劣るなど、同一ドメイン内でもスキル別の強弱が分かれる。
- **議論はある？**: 環境は自己ホストかつ決定的なので、ライブWebの非同期更新、セッション依存、推薦、外部連携、ノイズの多いレイアウトは十分に再現しない。タスクもテンプレート生成で、曖昧・開放的な依頼は対象外。スキル分析は「意図したスキルが成功したか」ではなく「実際にどの意味遷移が起きたか」を見るため、潜在意図までは評価しない。
- **次に読む/試すなら**: WEBSTEPのコードとデータ公開状況を確認する。自前Webエージェントのログを semantic transition に変換できるか試す。既存評価で「成功/失敗」しか見ていないタスクに探索成功率と実行成功率の分解を追加する。
- **キーワード**: `web agents`, `process-level evaluation`, `semantic MDP`, `WEBSTEP`, `trajectory analysis`, `GUI agents`, `benchmark`

## 気になったこと

- semantic MDP を各サイトごとに作るコストが高そうで、実サイトの変化に追随できるか。
- 「safe pass policy」により、最終コミット失敗を成功扱いする場合があるため、終端成功率の解釈には注意が必要。
- MDPで表現できるタスク構造と、実Web上の曖昧な操作・例外処理・確認ダイアログの差分をどう埋めるか。
- LLM judge不要の決定的評価は強いが、ユーザー満足度や自然な回復行動の評価までは含まれていない。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
