# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- When search agents should ask: {DiscoBench} for clarification-aware deep search

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - When search agents should ask: DiscoBench for clarification-aware deep search

## 基本情報

- **タイトル**: When search agents should ask: DiscoBench for clarification-aware deep search
- **著者**: Yiling Tao, Shihan Deng, Meiling Tao, Pengzhi Wei, Zhichao Hu, Zhihao Zhu
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2606.27669

## 落合陽一フォーマット

- **ひとことでいうと**: Deep search agent が曖昧な検索課題で「検索を続けるべきか、ユーザーに聞くべきか」を評価するための benchmark、DISCOBENCH を作った論文。
- **先行研究と比べてどこがすごい？**: GAIA や BrowseComp などはクエリが明示的で完全だと仮定しがちだが、この論文は multi-step search の途中で曖昧さが伝播し、誤った search trajectory に入る問題を正面から扱う。211 samples、463 ambiguity instances、11 domains、4 ambiguity types を含み、静的 QA ではなく user simulator による multi-turn clarification まで評価する。
- **技術や手法の肝はどこ？**: 質問を checkpoint 列に分解し、各 checkpoint を unambiguous / ambiguous に分類する。曖昧な checkpoint では agent が `SEARCH`、`ASK`、`ANSWER` のどれを選ぶかを見て、必要なら user simulator が識別的 clue を返す。曖昧さは Entity、Version、Criteria、Factual Inaccuracy の4種類として注入される。
- **どうやって有効だと検証した？**: Claude、GPT、Gemini、Doubao、DeepSeek、Qwen、Kimi、GLM、MiniMax、Hunyuan などを同じ interactive retrieval framework で評価。Neutral / Guided prompting、end-to-end accuracy、checkpoint pass rate、ambiguity detection F1、clarification effectiveness、tool use、ablation を比較した。Neutral では最高の Doubao-Seed-2.0-Pro でも accuracy 43.1%、Gemini-3.1-Pro が 40.8% に留まり、Guided prompting で detection F1 は改善するが end-to-end は依然限定的。
- **議論はある？**: 検索能力と「聞くべきタイミング」の能力は別物で、検索を何度も続ける SearchHeavyGuess は DirectGuess より悪い場合がある。限界として、主に客観的 QA の4種類の曖昧さに絞っており、主観的 preference ambiguity は未検証。また user simulator は LLM 生成なので、実ユーザーのノイズや予測不能性は十分に再現していない。
- **次に読む/試すなら**: 1. DISCOBENCH の公開データと code release を確認する。 2. 自作 search agent に「曖昧さ検出→ASK→clue 反映」の小さい評価ループを入れる。 3. BrowseComp / GAIA 系 benchmark と合わせて、検索精度と clarification 能力を分けて測る。
- **キーワード**: `deep search`, `search agent`, `clarification`, `ambiguity detection`, `interactive retrieval`, `benchmark`, `DISCOBENCH`

## 気になったこと

- code and data は “publicly released soon” と本文にあり、現時点のメタデータからは公開状況は不明。
- checkpoint 分解や ambiguity injection の人手検証コストが高そうで、他言語・他ドメインに拡張したときの再現性が気になる。
- CE-A / CE-B が高くても ask 頻度が低いモデルがあり、「聞けるが聞かない」問題を training / prompting でどう改善できるか確認したい。
- User simulator と checkpoint judge の両方に Gemini-3-Flash-Medium を使っているため、評価モデルとの相性や judge bias の影響を追加で見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
