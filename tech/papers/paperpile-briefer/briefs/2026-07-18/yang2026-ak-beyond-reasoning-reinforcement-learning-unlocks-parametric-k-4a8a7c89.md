# Paperpile Brief 2026-07-18 - Beyond reasoning: Reinforcement learning unlocks parametric knowledge in {LLMs}

## 基本情報

- **タイトル**: Beyond reasoning: Reinforcement learning unlocks parametric knowledge in {LLMs}
- **著者**: Wanli Yang, Hongyu Zang, Junwei Zhang, Wenjie Shi, Du Su, Jingang Wang, Xueqi Cheng, Fei Sun
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2605.07153 / PDF: https://arxiv.org/pdf/2605.07153.pdf / arXiv:2605.07153

## 落合陽一フォーマット

- **ひとことでいうと**: RLは推論能力だけでなく、LLM内部にすでに埋め込まれているが出力上位に出てこない事実知識を、closed-book QAで引き出しやすくできることを示した論文。
- **先行研究と比べてどこがすごい？**: 従来のRLVRは数学・コードなどのmulti-step reasoning改善が主対象だったが、この論文はzero-shot、one-hop、non-CoT、binary rewardという直接想起の設定に絞り、RLが「新しい知識獲得」ではなく「潜在知識の確率質量の再配置」を起こすと主張する。3つのモデル系列と複数QAベンチマークで平均約27%の相対改善を報告し、SFT、DPO、RFT、majority voting、CoT promptingより強い。
- **技術や手法の肝はどこ？**: GRPOを使い、同一質問に対する複数rollout内でbinary factual correctness rewardを相対化して更新する。正誤判定はexact matchではなくQwen2.5-72B-Instructによるsemantic verification。さらにfact-level train-test deduplicationを行い、訓練事実の丸暗記でテスト性能が上がる混入を抑えている。核心は、低確率tailに眠る正答をRLのon-policy探索でたまたま拾い、それを強化してgreedy decodingで出る位置まで押し上げる点。
- **どうやって有効だと検証した？**: Qwen2.5-7B-Instruct、Llama-3.1-8B-Instruct、OLMo-2-7B-Instructを対象に、Natural Questions、TriviaQA、PopQA、SimpleQAで評価。SFT、DPO、RFTなどのtraining-time baseline、majority votingやCoT promptingなどのinference-time baselineと比較した。さらにpre-RLで128サンプル中どれだけ正答が出るかを「accessibility」として測り、pass@k解析でRL前後の分布変化を調べた。結果として、RL後のk=1またはk=2が、RL前のk=16またはk=32相当に近づくケースが多く、k=256では差が縮まるため、知識獲得というより順位付けの変化だと解釈している。
- **議論はある？**: SimpleQAでは改善が限定的で、base modelがほとんど正答を出せない事実にはRLも弱い。評価と報酬に同じQwen2.5-72B-Instruct judgeを使うためreward hacking懸念があり、著者はhuman agreement解析で緩和しているが、完全には消えない。PDF抽出上、詳細な表や数値はレイアウト崩れの可能性があるため、細かい値は原PDFで再確認したい。また、closed-book one-hop QAの結果が、実運用のRAG、長文生成、多段推論、更新知識にどこまで移るかは未検証。
- **次に読む/試すなら**: 1. 自分のQAデータでpre-RL sampling 128回を行い、正答がtailに存在するかを測る。 2. GRPOではなくDPO/RFT/SFTで同じ事実想起タスクを再現し、on-policy探索とnegative signalの寄与を切り分ける。 3. judge依存を避けるため、人手ラベルまたは複数judge ensembleでreward/evalの頑健性を確認する。
- **キーワード**: `reinforcement learning`, `parametric knowledge`, `factual recall`, `GRPO`, `closed-book QA`, `LLM-as-a-Judge`, `pass@k`, `knowledge elicitation`

## 気になったこと

- 「inaccessible@128」が訓練データの約18%なのにgainの約83%を説明するという主張は強いので、subset sampling、seed、データサイズ一致の詳細を原PDFで確認したい。
- RLが押し上げた正答が本当にpretraining由来の知識なのか、訓練中の質問文・answer signalからの局所的な汎化なのかを、より厳しいentity/relation splitで見たい。
- Qwen judgeのfalse positive rate 0%という評価は200サンプル規模なので、難例・曖昧回答・別名表記でどれくらい崩れるか追加確認したい。
- RAGやtool-use前提のモデルでも、内部知識のtailを押し上げるRLが検索クエリ生成や引用精度に効くか試したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yang2026-ak-beyond-reasoning-reinforcement-learning-unlocks-parametric-k-4a8a7c89.md](../../chat/2026-07-18/yang2026-ak-beyond-reasoning-reinforcement-learning-unlocks-parametric-k-4a8a7c89.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
