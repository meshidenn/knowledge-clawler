# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Understanding social reasoning in language models with language models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - Understanding social reasoning in language models with language models

## 基本情報

- **タイトル**: Understanding social reasoning in language models with language models
- **著者**: Kanishk Gandhi, Jan-Philipp Fraenken, Tobias Gerstenberg, Noah Goodman
- **年 / venue**: 2023 / Advances in Neural Information Processing Systems
- **リンク**: https://arxiv.org/abs/2306.15448 / arXiv:2306.15448

## 落合陽一フォーマット

- **ひとことでいうと**: LLMのTheory of Mind、つまり他者の信念・知覚・行動を推論する能力を、LLMで生成した因果テンプレート型ベンチマークBigToMで検証した論文。
- **先行研究と比べてどこがすごい？**: SocialIQAやToMi、心理学由来の少数タスクは曖昧性、統制条件不足、データ漏洩、プロンプト過適合の懸念があった。本研究は因果グラフに基づくテンプレートから5,000件の評価を手続き的に生成し、25条件で失敗モードを切り分ける。
- **技術や手法の肝はどこ？**: 知覚、信念、欲求、行動を因果テンプレートとして表し、True Belief / False Belief、Forward Belief、Forward Action、Backward Beliefなどの条件を組み合わせて評価項目を作る点。LLMは物語を書くが、評価したい推論変数はテンプレート側で統制する。
- **どうやって有効だと検証した？**: BigToMの品質を人間参加者で評価し、crowd-sourcedなSocialIQAより高く、expert-writtenなToM評価と同等以上と報告。さらにtext-davinci-003、gpt-3.5-turbo、gpt-4-0314、Claude、LLaMA-65Bなどを評価し、人間性能と比較した。
- **議論はある？**: GPT-4は人間に近いToM推論パターンを示すが、特に行動から信念を逆推論するBackward Beliefでは人間水準に届かない。モデル生成評価には循環性や生成内容の偏りがあり、ステレオタイプや状況分布の偏りも残る。
- **次に読む/試すなら**: BigToMの生成テンプレートを手元のモデル評価に再実装する。Backward Belief条件だけを抜き出して最新モデルで再評価する。SocialIQA / ToMi / TomChallengesとの失敗ケース差分を比較する。
- **キーワード**: `Theory of Mind`, `LLM evaluation`, `BigToM`, `causal templates`, `social reasoning`

## 気になったこと

- GPT-4が「人間らしい」推論パターンを示すという主張は、タスク形式への適応と本当の心的状態推論をどこまで分離できているか。
- BigToMは統制が強い一方で、テンプレート化された物語にモデルが慣れる可能性がある。
- Claude-2生成セットでもGPT-4が高性能という検証は重要だが、最新モデル群で再実験すると結論が変わる可能性がある。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
