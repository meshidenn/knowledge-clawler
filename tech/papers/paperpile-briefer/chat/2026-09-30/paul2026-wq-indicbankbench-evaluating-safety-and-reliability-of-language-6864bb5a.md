# Chat Prompt 2026-09-30

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {IndicBankBench}: Evaluating safety and reliability of language model assistants in Indian retail banking

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-09-30 - IndicBankBench: Evaluating safety and reliability of language model assistants in Indian retail banking

## 基本情報

- **タイトル**: IndicBankBench: Evaluating Safety and Reliability of Language Model Assistants in Indian Retail Banking
- **著者**: Suvradip Paul, Chandra Bhushan, Harsh Sharma, Nitin Kukreja, Yatharth Dedhia, Keyur Doshi, Prashant Devadiga
- **年 / venue**: 2026 / arXiv [cs.AI]（arXiv:2609.29167、2026-09-24）
- **リンク**: https://arxiv.org/abs/2609.29167

## 落合陽一フォーマット

- **ひとことでいうと**: インドの個人向け銀行業務を題材に、LLMが「正しく答えたか」だけでなく、安全性・ツール操作・文脈利用・回答の十分性まで評価する799ケースのベンチマークを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のツール利用ベンチマークが最終的な成功率に集約しがちだったのに対し、安全性、アクション、回答、助言の4段階で失敗箇所を切り分ける。11モデルを各ケース3回評価し、全試行で成功する strict pass³ を報告した点も特徴。strict reliabilityは43.7〜58.2%、一度でも成功する率は60〜74%で、見かけの成功率と安定性の差を示した。
- **技術や手法の肝はどこ？**: 認証済み顧客コンテキスト、過去会話、決定論的なモック銀行ツール、期待されるツール呼び出し、禁止事項をケースごとに定義する。安全性とツール利用の多くは決定論的に判定し、意味的な回答妥当性だけをLLM judgeで評価する。曖昧な確認前書き込みだけには限定的なresolverを使う。
- **どうやって有効だと検証した？**: 5つの銀行業務領域と能力・拒否領域、20軸の799ケースを構成し、各ケースを3回、計26,367軌跡評価した。wrong information、long context、context switching、multi-tool、out-of-scope refusalなどを含め、不要なツール呼び出し、誤った引数、古い残高の再利用、確認後の未実行などを失敗パターンとして分析した。
- **議論はある？**: ケースは著者が作成した決定論的な合成環境であり、実際の顧客トラフィックへの性能を直接示すものではない。モデル間の上位差は統計的に明確でなく、LLM judgeの人手一致率も限定的な監査に基づく。インドの銀行業務や英語中心の設定以外への一般化、実運用でのツール・ポリシー差はメタデータからは不明。
- **次に読む/試すなら**: 1. 公開されたケース、モック環境、評価ハーネスを動かし、最小構成でstrict pass³を再現する。 2. 自分のエージェントに「不要な質問」「古いコンテキスト」「書き込み前確認」の診断軸を導入する。 3. τ-benchやBFCLと同一モデルで評価結果を比較する。
- **キーワード**: `banking agents`, `tool use`, `LLM evaluation`, `safety`, `reliability`, `multi-turn interaction`

## 気になったこと

- 合成ケースの難易度や軸ごとの分布が、実際の銀行問い合わせ頻度や損失リスクをどの程度反映しているか。
- LLM judgeの誤判定がモデル順位やstrict pass³に与える影響。
- 実運用のAPI遅延、権限分離、監査ログ、ツール障害を加えた場合にも同じ失敗傾向が現れるか。
- モデルの温度、プロンプト、ツールスキーマの提示方法を変えたときの再現性。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
