# Paperpile Brief 2026-07-09 - Program-as-Weights: A programming paradigm for fuzzy functions

## 基本情報

- **タイトル**: Program-as-Weights: A programming paradigm for fuzzy functions
- **著者**: Wentao Zhang, Liliana Hotsko, Woojeong Kim, Pengyu Nie, Stuart Shieber, Yuntian Deng
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: ルールで書きにくい「曖昧な関数」を、自然言語仕様から小さなニューラル重みとしてコンパイルし、ローカルで再利用可能にするプログラミングパラダイムを提案した論文。
- **先行研究と比べてどこがすごい？**: 毎回LLM APIに投げるのではなく、関数定義時に一度だけ大きめのモデルを「コンパイラ」として使い、その後は軽量な「インタプリタ」と小さなadapterで実行する点が差分。abstractによれば、0.6B Qwen3 interpreterがQwen3-32Bの直接promptingに匹敵し、推論メモリを約1/50にしつつMacBook M3で30 tokens/sを達成したとされる。
- **技術や手法の肝はどこ？**: Program-as-Weights, PAWでは、自然言語で書かれた fuzzy function の仕様を、凍結された軽量interpreter向けのparameter-efficient adapterに変換する。Foundation modelを「各入力を解くソルバー」ではなく「関数ごとの小さな実行物を作るツールビルダー」として使う発想が中心。
- **どうやって有効だと検証した？**: メタデータ上のabstractでは、著者らが公開する10M例のFuzzyBenchで4B compilerを訓練し、0.6B Qwen3 interpreterによるPAW実行をQwen3-32Bのdirect promptingと比較したとある。PDF本文がないため、タスク内訳、評価指標、統計的検定、失敗例の詳細は不明。
- **議論はある？**: PDF未取得のため詳細な限界は不明。abstractから見る限り、自然言語仕様からadapterを生成するため、仕様の曖昧さ、関数更新時の再コンパイルコスト、FuzzyBench外への汎化、adapterの安全性・検証可能性、デバッグ容易性が論点になりそう。
- **次に読む/試すなら**: arXiv本文を取得してFuzzyBenchのタスク分布と評価指標を確認する。PAW artifactのサイズ、生成時間、adapter形式を確認する。ログ分類やJSON修復など小さい fuzzy function でLLM API呼び出しとのコスト・再現性比較を試す。
- **キーワード**: `Program-as-Weights`, `fuzzy-function programming`, `parameter-efficient adapter`, `local inference`, `FuzzyBench`, `Qwen3`

## 気になったこと

- 「Qwen3-32Bのdirect promptingに匹敵」の比較条件が、同一プロンプト・同一データ分割・同一評価指標なのか確認したい。
- fuzzy functionを重みにコンパイルした後、仕様変更やバグ修正をどう扱うのか。
- 生成されたadapterの解釈性、テスト容易性、バージョン管理の実務上の扱い。
- FuzzyBenchが実アプリの曖昧なタスク、特に検索ランキングやログ重要度判定をどこまで代表しているか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhang2026-eu-program-as-weights-a-programming-paradigm-for-fuzzy-functio-cdcf79f4.md](../../chat/2026-07-09/zhang2026-eu-program-as-weights-a-programming-paradigm-for-fuzzy-functio-cdcf79f4.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
