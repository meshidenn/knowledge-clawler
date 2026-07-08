# Paperpile Brief 2026-07-09 - ReContext: Recursive Evidence Replay as LLM Harness for Long-Context Reasoning

## 基本情報

- **タイトル**: ReContext: Recursive Evidence Replay as LLM Harness for Long-Context Reasoning
- **著者**: Yanjun Zhao, Ruizhong Qiu, Tianxin Wei, Yuanchen Bei, Zhining Liu, Lingjie Chen, Ismini Lourentzou, Hanghang Tong, Jingrui He
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2607.02509

## 落合陽一フォーマット

- **ひとことでいうと**: 長文コンテキスト内に答えの根拠があるのにLLMが使い損ねる問題に対し、モデル内部のattention由来の関連度信号で根拠文を抽出し、最終回答前に再提示するtraining-free推論手法 RECONTEXT を提案した論文。
- **先行研究と比べてどこがすごい？**: RAGや外部memoryのように別retrieverを足さず、prompt compressionのように元コンテキストを削らず、attention interventionのように最終decodingの挙動を直接いじらない。full contextは保持したまま、候補根拠だけを明示的なevidence scaffoldとして再配置する点が差分。Qwen3-4B、Qwen3-8B、Llama3-8Bの3系統で平均rankが最良と報告されている。
- **技術や手法の肝はどこ？**: 質問側の末尾tokenをcueとして、選択したlayer-headのattentionを集約し、元コンテキストtokenに対するquery-conditioned relevance scoreを作る。上位tokenを含む文を復元してevidence poolに入れ、次ラウンドでは「元コンテキスト + 既存evidence + 質問」から再び根拠を選ぶ。これを数ラウンド繰り返し、最後にfull contextとevidence scaffoldの両方を見せて回答させる。
- **どうやって有効だと検証した？**: 128K contextの8データセットで評価。NQ、TriviaQA、HotpotQA、PopQA、NarrativeQA、InfBench QA、InfBench MC、CLIPPERを使い、Vanilla、AttnSharp、DySCO、A-MEM、DACなどと比較。本文ではVanillaから平均accuracyが0.24から0.30へ改善し、相対24.6% gainと報告。ablationではreplay rounds、Top-K evidence budget、64K context、thinking-enabled設定なども確認している。
- **議論はある？**: attentionを「忠実な説明」ではなく安価なproposal signalとして使っているため、選ばれた根拠が常に因果的に正しいとは限らない。根拠文の再提示は推論時間を増やし、CLIPPER/Llama3-8BではVanilla 44分に対してRECONTEXT 62分。Top-Kを大きくするとrecallは上がるがnoiseも増える可能性があり、NQでは悪化する設定もある。理論解析は直交embeddingなど強い仮定を置いた簡略モデル。
- **次に読む/試すなら**: 実装コードでattention readout対象のlayer-head選択が固定かデータ依存か確認する。自分のlong-context QAタスクでVanillaとRECONTEXTの2 round設定を最小比較する。RAGやcontext compressionと組み合わせた場合に根拠重複・noiseがどう変わるか試す。
- **キーワード**: `long-context reasoning`, `evidence replay`, `attention signal`, `LLM harness`, `training-free inference`, `associative memory`

## 気になったこと

- attention由来のrelevance scoreが、モデル・dataset・prompt形式をまたいでどれくらい安定するのか。
- evidence sentenceの復元で、tokenが含まれる文だけをコピーする設計がmulti-hopや表形式データで十分か。
- recursive replayの最適round数はタスク依存に見えるため、自動停止やconfidence-based selectionが必要そう。
- full contextを保持するため、そもそも128Kを扱えない環境ではそのまま使えない。compressionとの併用設計を確認したい。
- 実装上はKV cache再利用が効く前提なので、利用する推論フレームワークで同じ形に落とせるか要確認。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhao2026-mf-recontext-recursive-evidence-replay-as-llm-harness-for-long-9460811b.md](../../chat/2026-07-09/zhao2026-mf-recontext-recursive-evidence-replay-as-llm-harness-for-long-9460811b.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
