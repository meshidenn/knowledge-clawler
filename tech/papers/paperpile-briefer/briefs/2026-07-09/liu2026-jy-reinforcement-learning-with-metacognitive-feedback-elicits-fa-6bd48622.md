# Paperpile Brief 2026-07-09 - Reinforcement learning with metacognitive feedback elicits faithful uncertainty expression in LLMs

## 基本情報

- **タイトル**: Reinforcement learning with metacognitive feedback elicits faithful uncertainty expression in LLMs
- **著者**: Gabrielle Kaili-May Liu, Avi Caciularu, Gal Yona, Idan Szpektor, Arman Cohan
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2606.32032 / arXiv:2606.32032v1 / code: https://github.com/yale-nlp/RLMF

## 落合陽一フォーマット

- **ひとことでいうと**: LLMが自分の不確実性を数値・言語の両方で「内的な確信度に忠実に」表現できるよう、自己評価の正確さをRLの報酬信号に組み込むRLMFを提案した論文。
- **先行研究と比べてどこがすごい？**: 従来のpromptingやSFTによる不確実性表現改善に対し、自己判断の正確さをadvantage scalingに使う点が新しい。10タスク・複数モデルで評価し、平均cMFG*で既存手法より大きく改善、標準RLより最大63%良いと報告している。数値的不確実性だけでなく、後段のrewritingで自然な言語的不確実性にも接続している。
- **技術や手法の肝はどこ？**: RLMFでは、各completionについて「表明したconfidenceが内的confidenceにどれだけ忠実か」というgold FCと、モデル自身が推定したpredicted FCを比較し、自己評価が正確なcompletionの学習信号を強める。さらにmetacognitive data selectionで、モデルの自己評価スコアの高低両端から訓練例を選び、学習価値の高いデータを選別する。Stage 1でsentence-level confidenceを較正し、Stage 2で数値confidenceをhedge表現へ変換・編集する。
- **どうやって有効だと検証した？**: Qwen3系とLlama3.1-8B-Instructに適用し、PopQAで訓練して10データセットにOOD評価。指標はfaithful calibration用のcMFG*、accuracy、Brier Score。MetaFaith、FUT、標準RL、frontier modelとの比較、訓練データ選択のablation、訓練タスクをSelfAware/HaluEval/UMWPへ変えたrobustness評価、人手評価による言語的不確実性の自然さ・多様性・有用性の比較を行っている。
- **議論はある？**: PDF本文上では、自己評価性能の改善は広い意味でのmetacognition全体を保証しないと注記している。intrinsic confidenceの推定はsampling consistencyに依存するため、推定誤差や計算コストが実運用上の論点になる。人手評価やLLM-as-a-Judgeの設計、rewritingモデル依存、confidence表現がユーザー信頼に与える影響の長期評価も追加検証が必要。
- **次に読む/試すなら**: RLMFのGitHub実装を確認する。cMFG*の定義と従来cMFGとの差分を読む。小さなQAタスクで、標準RLとmetacognitive advantage scalingの最小比較実験を作る。
- **キーワード**: `RLMF`, `metacognition`, `faithful calibration`, `uncertainty expression`, `LLM calibration`, `GRPO`, `metacognitive feedback`

## 気になったこと

- intrinsic confidenceをsampling consistencyで推定する設計は、長文生成や創造的タスクでどれだけ安定するのか。
- 「自己評価が正確なcompletionを強める」ことで、モデルが保守的・曖昧な表現へ逃げる副作用はないのか。
- cMFG*は実装に落とすとどの程度データ数を要求するのか。
- Stage 2のrewritingがGemini系に依存しているため、完全open-weight構成で同等に再現できるか。
- faithful calibrationとfactual calibrationのトレードオフを、医療・法務など高リスク領域でどう評価するべきか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [liu2026-jy-reinforcement-learning-with-metacognitive-feedback-elicits-fa-6bd48622.md](../../chat/2026-07-09/liu2026-jy-reinforcement-learning-with-metacognitive-feedback-elicits-fa-6bd48622.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
