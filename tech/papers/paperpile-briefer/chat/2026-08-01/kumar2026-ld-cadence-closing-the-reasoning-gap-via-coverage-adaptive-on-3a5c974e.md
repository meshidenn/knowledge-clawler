# Chat Prompt 2026-08-01

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {CADENCE}: Closing the reasoning gap via coverage-adaptive on-policy distillation

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-01 - CADENCE: Closing the reasoning gap via coverage-adaptive on-policy distillation

## 基本情報

- **タイトル**: CADENCE: Closing the reasoning gap via coverage-adaptive on-policy distillation
- **著者**: Satyam Kumar, Saurabh Jha
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/pdf/2607.16955

## 落合陽一フォーマット

- **ひとことでいうと**: 小さいLLMへ数学推論能力を蒸留する際の「cold-start」「KLスケジュールの硬直性」「binary rewardの疎さ」を、coverage-adaptiveなon-policy distillationでまとめて改善する論文。
- **先行研究と比べてどこがすごい？**: 固定的なforward/reverse KL補間ではなく、学生モデルが教師分布をどれだけカバーしているかに応じてβを調整するCOVAを導入。さらに、部分点reward、entropyに基づく重要token強調、自己蒸留、calibration正則化を組み合わせ、GSM8Kで0.5B studentを48.7%から69.8%まで改善し、matched-computeのDRIFT+binary rewardを+4.4±0.7ポイント上回る。
- **技術や手法の肝はどこ？**: DRIFTで学生生成trajectory上の各tokenに対し、forward-KL風とreverse-KL風のper-token surrogate advantageを混合する。COVAはteacher top-k tokenへのstudent coverageを見てforwardからreverseへの移行を早める。CCDは数値回答の近さで不正解trajectoryにも部分点を与え、FTBはteacher entropyが高い分岐tokenにgradientを集中させる。EMR、LAP、BSD、TFW、KTRも安定化・校正・短縮・自己蒸留に使う。
- **どうやって有効だと検証した？**: GSM8KとMATH-500で、Qwen2.5系の0.5B studentを1.5B/3B teacherから蒸留。5 seeds、標準偏差つきで報告し、SFT、Forward KL、Reverse KL、GKD、STaR/RFT、GKD+GRPO、DRIFT+binary rewardと比較。ablationではCCD、TFW、FTB、COVA、BSDなどの除去で性能低下を確認。評価protocolはMATH-500で512-token cap、answer extractor補正済み。
- **議論はある？**: DRIFTはsequence-level KLの不偏推定ではなく、あくまでper-token surrogateであると明記されている。CCDの部分点化は非ゼロreward比率を約49%から約55%に上げる程度で、step-level process rewardほど細かくない。COVAはmode-coveringが長すぎる問題には効くが、premature sharpening自体は直接解かない。数学推論以外、コードや論理タスクへの一般化は未検証。
- **次に読む/試すなら**: 
  1. DRIFT+COVA+CCDだけの最小実装でGSM8K small splitを再現する。
  2. 数値近接rewardが非数学タスクに移植できるか、code execution rewardやunit test partial creditで試す。
  3. token-level βやentropy-based token weightingの関連研究を追う。
- **キーワード**: `knowledge distillation`, `on-policy distillation`, `reasoning LLM`, `KL divergence`, `GSM8K`, `MATH-500`, `coverage-adaptive`, `Qwen2.5`

## 気になったこと

- 結果は非常に整理されているが、複数componentの組み合わせ効果が大きく、どの要素が別モデル・別タスクでも効くのかは追加検証が必要。
- CCDの「数値的に近い不正解」を評価する設計は数学向きなので、symbolic reasoningやcodingでは別のpartial credit設計が必要そう。
- Apple Mac Studio単体で実験可能という主張は実用上重要だが、実際の学習時間、batch size、LoRA設定、再現コード有無は本文だけでは十分確認したい。
- arXiv IDはPDF本文から `2607.16955v1` と読めるが、メタデータの `arxiv_id` 欄は空。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
