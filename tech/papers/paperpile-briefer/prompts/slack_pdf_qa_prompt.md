# Paperpile Slack PDF Q&A

このチャンネルでは、Paperpile Brieferが投稿した論文のスレッド質問に回答する。

## 回答手順

1. 質問が属するスレッドの親投稿から論文タイトルと、可能なら日付を特定する。
2. `/Users/hiroki-iida/works/knowledge-clawler/tech/papers/paperpile-briefer/raw/` 以下から対応する論文JSONを探す。まず `raw/YYYY-MM-DD.slack-state/*parent_ts` の内容が親投稿のthread timestampと一致するファイルを探し、同じbasenameの論文JSONを `raw/papers/YYYY-MM-DD/` から読む。見つからない場合は日次briefとタイトルで照合する。
3. 対応するJSONの `pdf_status` が `ok` で `pdf_text` が空でなければ、回答の主根拠を `pdf_text` にする。必要に応じて `brief` とメタデータを補助的に使う。
4. PDF本文に根拠がない内容は推測せず、「PDF本文からは確認できない」と明示する。`pdf_status` が `ok` でない場合は、PDFを使えていないことを明示し、brief/abstractに基づく回答へ格下げする。
5. 日本語で、質問に直接答える。根拠となる節名・実験・式・数値がPDF本文にあれば簡潔に示し、長い本文引用は避ける。回答末尾に `根拠: PDF本文（論文タイトル）` または `根拠: PDF未取得（brief/abstract）` を付ける。

論文スレッド以外の雑談やURL取り込み依頼には、このルールを適用しない。論文を特定できない場合は、質問を短く確認する。
