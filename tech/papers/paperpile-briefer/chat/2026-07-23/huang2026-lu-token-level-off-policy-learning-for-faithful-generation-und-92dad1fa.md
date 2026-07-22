# Chat Prompt 2026-07-23

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Token-Level Off-policy learning for faithful generation under distribution shift

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-23 - Token-Level Off-policy learning for faithful generation under distribution shift

## 基本情報

- **タイトル**: Token-Level Off-policy learning for faithful generation under distribution shift
- **著者**: Zitong Huang, Gustavo Lucas Carvalho, Deqing Fu, Robin Jia
- **年 / venue**: 2026 / COLM 2026, arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.17524 / PDF: https://arxiv.org/pdf/2607.17524.pdf

## 落合陽一フォーマット

- **ひとことでいうと**: 生成モデルのpost-trainingを「次トークンを当てる」問題ではなく、「各トークンが事実に忠実かどうかを判定する」問題として学習し、分布シフト下でもfaithful generationを改善するTOPLを提案した論文。
- **先行研究と比べてどこがすごい？**: DPOなどのsequence-levelなoff-policy手法は簡単だがOOD汎化が弱く、token-level reward系は別モデル化しがちだった。TOPLはLoRA付き単一モデルにtoken-level correctness分類を学ばせ、summarizationの11個のAggreFact OODデータセット平均で強い性能を示し、machine translationにも転移する点が新しい。
- **技術や手法の肝はどこ？**: 応答中の各トークンに「faithful / hallucinated」の二値ラベルを付け、選択した中間層のhidden stateに軽量reward headを載せてbinary cross entropyで訓練する。生成時にはreward headを捨て、学習済みLoRAを元モデルにmergeして通常のdecoding headで生成する。著者らはLoRA-Aをtoken correctnessを分離する条件付き分類器、LoRA-Bを表現をfaithful方向へ押すsteering vectorとして解釈している。
- **どうやって有効だと検証した？**: FAVA由来のtoken-level perturbationデータで訓練し、Qwen3-8B、Llama-3.1-8B、Gemma-3-4Bをbackboneに、SFT、DPO、SOPL、TDPO、TLDR、Unlikelihoodと比較した。主評価はAggreFactの11データセットに対するOOD summarizationで、Bespoke-MiniCheck-7Bによりfactualityを評価。Appendixではfull-summary評価、summary length分析、label sensitivity、LoRA-A/B解析、machine translation実験も行っている。
- **議論はある？**: 評価器がBespoke-MiniCheck-7Bに依存しており、factualityの絶対評価には評価モデルバイアスが残る。訓練データはFAVAの人工的なperturbationに依存するため、現実のhallucination分布をどこまで覆うかは未検証。LoRA-A/Bのsteering解釈は実験的には支持されているが、因果的な完全説明とまでは言い切れない。細かい数値はPDF抽出テキスト由来で、表・図の読み取り誤差の可能性がある。
- **次に読む/試すなら**: FAVA形式のtoken-level hallucinationラベルを自分の要約タスクで作れるか確認する。LoRA rank 4、reward head破棄、LoRA merge後生成という最小TOPL実装をQwen系小型モデルで再現する。MiniCheck以外のfact-checkerや人手評価で性能傾向が保たれるか試す。
- **キーワード**: `faithful generation`, `off-policy learning`, `token-level supervision`, `LoRA`, `hallucination`, `summarization`, `conditional steering`

## 気になったこと

- token-levelの「bad token」境界をどの粒度で切ると一番効くのか。
- FAVA以外の自前データで、LLM生成の擬似corruptionだけでも同じ効果が出るのか。
- reward headを捨ててLoRAだけmergeする設計で、どの層にLoRAを入れるのが最も費用対効果が高いのか。
- factualityは上がる一方で、情報量・網羅性・文体の自然さがどの程度変化するのか。
- DPOやSOPLにもLoRA-B steering効果があるなら、TOPLの差分はLoRA-Aの分離性だけで十分説明できるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
