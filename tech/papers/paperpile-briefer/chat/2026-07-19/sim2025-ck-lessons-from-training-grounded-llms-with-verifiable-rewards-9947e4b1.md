# Chat Prompt 2026-07-19

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Lessons from training grounded {LLMs} with verifiable rewards

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-19 - Lessons from training grounded LLMs with verifiable rewards

## 基本情報

- **タイトル**: Lessons from Training Grounded LLMs with Verifiable Rewards
- **著者**: Shang Hong Sim, Tej Deep Pala, Vernon Toh, Hai Leong Chieu, Amir Zadeh, Chuan Li, Navonil Majumder, Soujanya Poria
- **年 / venue**: 2025 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2506.15522 / arXiv:2506.15522

## 落合陽一フォーマット

- **ひとことでいうと**: RAGにおける回答の正しさ、引用の妥当性、答えられない時の拒否を、検証可能な報酬でGRPO学習するGround-GRPOを提案した論文。
- **先行研究と比べてどこがすごい？**: Search-o1やRAG-Starのような検索付き推論ではなく、grounding alignmentそのもの、つまり「正しく答える」「必要十分に引用する」「根拠がなければ拒否する」に報酬を分解している点が差分。gold reasoning traceや高価な人手アノテーションなしで、outcome-based rewardを使う。
- **技術や手法の肝はどこ？**: 2段階RL。Stage 1ではanswerableな質問だけで、Exact Match、citation、format報酬により回答と引用を学習する。Stage 2ではanswerable/unanswerableを混ぜ、fuzzy matchingによるrefusal rewardを追加して、根拠がない場合に答えない振る舞いを学習する。引用報酬ではNLIで引用文書が主張を支えるかを検証する。
- **どうやって有効だと検証した？**: ASQA、QAMPARI、ELI5、OOD評価としてExpertQAで評価。対象モデルはLLaMA3.1-8B、Qwen3-4B、Qwen3-8Bなど。TrustScore、Answer Correctness、Grounded Refusals、Grounded Citations、Answer Rateを比較し、reasoning model + Ground-GRPOが多くの条件でinstruction-onlyより高い信頼性を示した。特に長文QAやunanswerable queryへの対応で効果が大きい。
- **議論はある？**: 報酬設計がモデル依存で、bad citation penaltyを外すと過剰回答が増えるなど挙動が不安定。process rewardはreasoningとfinal answerの整合性を改善する一方、TrustScoreを少し下げる。PDF抽出上、細かい表の数値は一部崩れているため断定しすぎない方がよい。また、評価は既存ベンチマーク中心で、実運用RAGでの再現性は追加検証が必要。
- **次に読む/試すなら**: Ground-GRPOの報酬関数を自分のRAG評価セットに移植できるか確認する。citation rewardに使うNLIモデルの選択で結果がどれだけ変わるか試す。SFT → GRPOとGRPO → SFTの順序差を小規模モデルで再現する。
- **キーワード**: `RAG`, `GRPO`, `grounded generation`, `citation`, `refusal learning`, `TrustScore`, `reinforcement learning`

## 気になったこと

- citation correctnessをNLIで見る場合、NLIモデル自体のドメイン外性能がボトルネックにならないか。
- Exact Match報酬は短文・列挙型QAには効きそうだが、ELI5のような自由記述でどこまで妥当か。
- refusal rewardがfuzzy matching依存なので、「別表現の正しい拒否」を過小評価しないか。
- 実運用RAGではretrieverの失敗とgeneratorの失敗が混ざるため、Ground-GRPOをどちらの責任として学習させるべきか。
- process supervisionでTrustScoreが下がる理由を、報酬の重み付けやNLI閾値で改善できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
