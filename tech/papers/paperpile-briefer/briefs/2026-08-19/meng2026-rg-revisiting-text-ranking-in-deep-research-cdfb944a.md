# Paperpile Brief 2026-08-19 - Revisiting text ranking in deep research

## 基本情報

- **タイトル**: Revisiting text ranking in deep research
- **著者**: Chuan Meng, Litu Ou, Sean MacAvaney, Jeff Dalton
- **年 / venue**: 2026 / SIGIR ’26
- **リンク**: https://doi.org/10.1145/3805712.3808557

## 落合陽一フォーマット

- **ひとことでいうと**: Deep researchエージェントの検索では、passage検索・適切に調整したBM25・深いre-rankingが非常に効き、エージェント特有の検索クエリ形式を自然言語質問へ変換するQ2Qでneural rankerも改善できることを示した論文。
- **先行研究と比べてどこがすごい？**: ブラックボックスのWeb検索APIではなく、固定コーパスと人手relevance judgmentを持つBrowseComp-Plus上で、2エージェント、5 retriever、3 re-rankerを系統的に比較した。BM25が適切な長さ正規化で競争力を回復し、20B agent＋BM25＋monoT5-3BでもGPT-5ベースの既報に近い精度へ到達した点が実務的に強い。
- **技術や手法の肝はどこ？**: 文書全体ではなくpassageを検索単位にしてcontext windowを節約し、BM25／SPLADE-v3／ColBERTv2などを比較する。さらに、キーワード・引用符中心のagent-issued queryと、自然言語質問で学習されたneural rankerとの分布ずれを、直近のreasoning traceも参照するQuery-to-Question（Q2Q）で緩和する。
- **どうやって有効だと検証した？**: BrowseComp-Plusでgpt-oss-20bとGLM-4.7-Flashを用い、retrieval unit、retriever、re-ranker、re-ranking depth、Q2Qの有無を比較した。gpt-oss-20bではBM25＋monoT5-3B（depth 50）がrecall 0.716、accuracy 0.689を記録し、re-rankingなしよりaccuracyを20.45%相対改善した。Q2Q（query＋reasoning trace）はSPLADE-v3やQwen3-Embed-8Bを有意に改善した。
- **議論はある？**: 評価対象は2種類のagentとBrowseComp-Plusの固定コーパスに限られ、ライブWebや他モデルへの一般化は未検証。BM25の文書向けパラメータは全クエリ上で調整されており、比較には慎重さが必要。Q2Qはneural rankerには有効だが、BM25では性能を下げる場合がある。
- **次に読む/試すなら**:
  - 自分のdeep research agentで、document検索とpassage検索のcontext消費・回答精度を比較する。
  - BM25＋軽量cross-encoder re-rankerを基準系として実装し、depthを10/20/50でablationする。
  - neural retrieverを使う場合、agent queryをQ2Q（reasoning trace付き）で変換して効果を検証する。
- **キーワード**: `deep research`, `agentic search`, `text ranking`, `BM25`, `passage retrieval`, `re-ranking`, `query-to-question`, `BrowseComp-Plus`

## 気になったこと

- Q2Qでreasoning traceを渡す際、誤った中間推論がquery rewriteへ伝播するリスクはどの程度あるか。
- 実運用のライブWebでは、固定コーパスで得られたBM25優位性や最適なre-ranking depthが維持されるか。
- passage分割の粒度・overlap・文書復元方法が結果に与える影響を追加で確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [meng2026-rg-revisiting-text-ranking-in-deep-research-cdfb944a.md](../../chat/2026-08-19/meng2026-rg-revisiting-text-ranking-in-deep-research-cdfb944a.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
