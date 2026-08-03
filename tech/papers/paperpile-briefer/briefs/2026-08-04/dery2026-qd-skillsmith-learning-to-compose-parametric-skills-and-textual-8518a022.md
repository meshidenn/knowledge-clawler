# Paperpile Brief 2026-08-04 - SkillSmith: Learning to compose parametric skills and textual knowledge

## 基本情報

- **タイトル**: SkillSmith: Learning to Compose Parametric Skills and Textual Knowledge
- **著者**: Lucio M. Dery, Benedict Aaron Tjandra, Siavash Samiei, Adhiguna Kuncoro, Zohar Yahav, Jiajun Shen, Arthur Szlam
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2607.27497 （本文中 arXiv:2607.27497v1）

## 落合陽一フォーマット

- **ひとことでいうと**: LLM agent が過去に獲得した「テキスト知識」と「prefix-tuning で得た重み空間のスキル」を同時に読み取り、新しいタスク用の prefix weights を直接合成する SkillSmith を提案した論文。
- **先行研究と比べてどこがすごい？**: 従来は、reflection や memory のような text-only 適応と、LoRA/adapters/prefix などの weight-space merging が別々に扱われていた。この論文は重みを LLM が扱える追加モダリティとして扱い、単純平均・concat・SVD などの算術的 merge では拾えない、タスク間の意味的関係を text と weights の両方から合成する点が新しい。
- **技術や手法の肝はどこ？**: 各 source task を、タスク説明・few-shot 例などの text metadata と prefix K-V cache の bundle として表現する。SkillSmith は input K-V adapter で prefix weights を LLM の latent 空間に写像し、`<src_start>`, `<kv_start>`, `<kv_end>`, `<gen_start>` などの control token で text と K-V cache を interleave して処理する。最後に placeholder latent token 部分の K-V cache を取り出し、RoPE de-rotation と output K-V adapter を通して target task 用 prefix weights を生成する。
- **どうやって有効だと検証した？**: Gemma 3 4B を SkillSmith と downstream model に使い、Composite-SNI、SNI、MMLU-ProX で評価。Composite-SNI は SNI の task pair から Gemini 2.5 Pro で合成した約21Kタスクで、ground-truth source task 関係がある。評価は held-out task の NLL をもとに global Elo に変換。SkillSmith は zero-shot で LERP、Concat、SVD などの weight-only baseline を上回り、fine-tuning 初期値としても direct prefix tuning や ICL 初期化より強い。SNI/MMLU-ProX のように source mapping が未知の設定では Gemini Embedding + Gemini 2.5 Pro による retrieval/selection を使い、特に data-sparse な MMLU-ProX で bootstrapped SkillSmith が強い結果を示した。
- **議論はある？**: 強みは synthetic composition で学んだ能力が実タスクへ転移する点だが、Composite-SNI 自体が Gemini 生成データなので、生成タスクの質や分布に依存する。source task retrieval も Gemini Embedding と Gemini 2.5 Pro に依存しており、retrieval が悪い場合の頑健性は限定的に見える。実験は prefix-tuning に絞られており、LoRA や adapter など他の PEFT 重みへ同じ設計がそのまま効くかはメタデータからは不明。数値結果は PDF 抽出上、細かい表値までは断定しない。
- **次に読む/試すなら**: 1. prefix K-V cache を対象に、LERP/Concat と SkillSmith 型 hypernetwork の最小再現を小規模タスクで組む。 2. LoRA weight を同様に token-like modality として読ませられるか調べる。 3. retrieval が外れた source task を混ぜたときの性能劣化を再評価する。
- **キーワード**: `SkillSmith`, `prefix-tuning`, `KV cache`, `model merging`, `PEFT`, `agentic memory`, `compositional generalization`, `hypernetwork`

## 気になったこと

- SkillSmith が「重みを読んでいる」と言える範囲は prefix K-V cache に強く依存しており、LoRA のような行列差分でも同じ可読性が成立するのか。
- Composite-SNI の合成タスクが Gemini 2.5 Pro 由来なので、評価が生成モデルの癖に寄っていないか。
- MMLU-ProX での強さは retrieval、CSNI pretraining、SkillSmith architecture のどれが支配的なのか、さらに分解した ablation を見たい。
- 実装するなら、まずは frozen 小型LM + prefix tuning + 2 source task composition だけに絞るのが現実的。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [dery2026-qd-skillsmith-learning-to-compose-parametric-skills-and-textual-8518a022.md](../../chat/2026-08-04/dery2026-qd-skillsmith-learning-to-compose-parametric-skills-and-textual-8518a022.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
