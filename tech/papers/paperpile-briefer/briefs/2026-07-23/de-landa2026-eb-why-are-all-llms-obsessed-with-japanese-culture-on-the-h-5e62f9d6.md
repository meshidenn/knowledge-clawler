# Paperpile Brief 2026-07-23 - Why are all LLMs Obsessed with Japanese Culture? On the Hidden Cultural and Regional Biases of LLMs

## 基本情報

- **タイトル**: Why are all LLMs Obsessed with Japanese Culture? On the Hidden Cultural and Regional Biases of LLMs
- **著者**: Joseba Fernandez de Landa, Carla Perez-Almendros, Jose Camacho-Collados
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2604.21751v1 / arXiv:2604.21751v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMが曖昧な文化関連質問に答えるとき、どの国や地域を暗黙に選びがちかを、CROQという多言語・ open question データセットで測った論文。
- **先行研究と比べてどこがすごい？**: 既存研究は文化知識の正誤や Western / Anglocentric bias の検出が中心だったが、この論文は「正解が一つでない文化質問」に対してLLMが自発的にどの地域へアンカーするかを分布として見る。結果として、英米中心だけでなく、日本・米国・インド・中国・フランスなど少数地域への集中、とくに日本への過剰参照を示した点が新しい。
- **技術や手法の肝はどこ？**: 11ドメイン・66サブトピックからなる文化分類を作り、各サブトピック20問、計1,320問を作成。それを24言語に展開して31,680問のCROQを構築する。質問には具体的な国名を入れず、「場所は自分で選べ」と促すことで、モデル内部の文化的 prior を露出させる。生成回答から最大5地域を LLM-as-a-judge で抽出し、diversity、normalized entropy、国別 raw count で分析する。
- **どうやって有効だと検証した？**: gpt-4o-mini、gemini-2.5-flash、claude-3.5-haiku、llama-4-maverick、command-r、magistral-small、deepseek、qwen など8つの frontier model を24言語で評価。さらに base / SFT / instruct の open-weight model を英語で比較し、bias がどの訓練段階で強まるかを調べた。judge prompt は264件で手動評価され、選択した方式は約98%精度と報告されている。
- **議論はある？**: base と instruct の比較は英語のみなので、多言語で同じ訓練段階効果が出るかは未検証。国を文化の proxy にする単純化も強い。生成設定は default のみで、decoding parameter への頑健性は未確認。自動 judge 依存のため、微妙な地域・文化ニュアンスを取り逃がす可能性がある。下流タスクへの実害や影響も未評価。
- **次に読む/試すなら**: CROQ風の質問を手元のLLM評価セットに入れて、日本語・英語・低リソース言語で地域参照分布を比較する。SFTデータや preference data が文化的地域集中を作る仮説を、公開 instruction dataset で検証する。国単位ではなく都市・民族・宗教・diaspora 単位で同様の bias が出るかを試す。
- **キーワード**: `cultural bias`, `regional bias`, `LLM evaluation`, `CROQ`, `multilingual evaluation`, `instruction tuning`, `LLM-as-a-judge`

## 気になったこと

- 「日本への過剰参照」が、アニメ・食・伝統文化など特定トピックの global salience によるものか、SFTデータの会話例・安全回答テンプレートに由来するのかを分けて見たい。
- 「言語の official country」を own reference とする設計は実装しやすい一方、スペイン語・アラビア語・英語のような多地域言語では粗い可能性がある。
- judge に gpt-4o-mini を使っているため、地域抽出そのものにも文化・言語 bias が混入していないか確認したい。
- prompt の「Choose yourself the place」が、通常利用時の自然な文化回答よりも地域選択を強制している可能性がある。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [de-landa2026-eb-why-are-all-llms-obsessed-with-japanese-culture-on-the-h-5e62f9d6.md](../../chat/2026-07-23/de-landa2026-eb-why-are-all-llms-obsessed-with-japanese-culture-on-the-h-5e62f9d6.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
