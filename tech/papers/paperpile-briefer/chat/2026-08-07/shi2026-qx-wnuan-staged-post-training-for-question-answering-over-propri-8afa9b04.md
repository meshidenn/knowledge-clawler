# Chat Prompt 2026-08-07

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Wnuan: Staged post-training for question answering over proprietary enterprise knowledge

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-07 - Wnuan: Staged post-training for question answering over proprietary enterprise knowledge

## 基本情報

- **タイトル**: Wnuan: Staged post-training for question answering over proprietary enterprise knowledge
- **著者**: Xiaofeng Shi, Xiaosong Qiu, Wenxin Ma, Qian Kou, Yiming Pan, Longbin Yu, Ying Liu, Haiping Wang, Hua Zhou
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/abs/2608.01862 / arXiv:2608.01862

## 落合陽一フォーマット

- **ひとことでいうと**: 企業内の独自文書知識を、Document-to-QA生成、general-data replay付きSFT、残差エラーに対するGRPOの3段階で閉じたQAモデルに注入するパイプラインを提案・評価した論文。
- **先行研究と比べてどこがすごい？**: 個別には既存のQA合成、SFT、RL、RAG、data selectionを、企業QA向けの一貫したpost-training手順として組み合わせ、707問のWnuanBenchでAARを52.76%からSFT後80.06%、RL後91.51%まで上げた点。残差エラーだけをRL対象にする方が、同じ100 update条件でfull-poolや同サイズrandom samplingより約3ポイント良いことも示している。
- **技術や手法の肝はどこ？**: Stage Iで企業文書から自己完結したQAを221,294例作り、対象モデルに合わせて回答を書き換える。Stage IIでQwen3-32Bをfull-parameter SFTし、約48.3%のgeneral replayで汎用能力低下を抑える。Stage IIIでWnuan-Instが間違えた56,147例だけを抽出し、正確性・論理性・専門表現・簡潔性・形式を組み合わせたsemantic rewardでGRPOする。
- **どうやって有効だと検証した？**: 企業文書由来の707問WnuanBenchで評価。自動評価はgpt-oss-120b、MiniMax-M2.5、DeepSeek-V3.2のensembleで、147件の専門家ラベルと90.5%一致。SFT/RLの段階別改善、source-cluster bootstrap、same-domain validation、residual/full/randomの制御実験、MMLU・IFEval・C-Evalによる汎用性能の変化を確認している。
- **議論はある？**: 評価は1企業・同一知識ベース内のin-domain benchmarkで、source-held-out、time-held-out、cross-enterprise、open-world一般化は未検証。WnuanBenchはQA recordとしては学習と分離されるが、元文書や近い意味の質問は共有される。RLでAARは上がる一方、general benchmark平均は5.17ポイント下がり、特にIFEvalの instruction following が悪化する。private documentsと完全benchmarkは公開できず、再現性にも制約がある。
- **次に読む/試すなら**: 1. residual-error samplingを自前の業務QAデータでSFT後エラー抽出として再現する。2. RAGあり/なしをcheckpointごとに分けて評価し、常時RAGにしないgate設計を試す。3. instruction replayやfactual-consistency rewardでRL後のIFEval低下を抑えられるか検証する。
- **キーワード**: `enterprise QA`, `post-training`, `GRPO`, `residual-error sampling`, `general-data replay`, `closed-book QA`, `WnuanBench`

## 気になったこと

- 残差エラー抽出と最終評価で同じ自動judge ensembleを使っているため、selection biasがどの程度あるか。
- QA recordは分離されているが、元文書共有・高いsemantic proximityがあるので、未知文書へのtransfer性能は別途見る必要がある。
- Answer rewritingはdomain AARの独立改善を示していないため、実運用ではコストに見合うか再検証したい。
- RAG診断にgold Recall@5やseed-matched generationがないため、retrieval-aware trainingとの比較はまだ弱い。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
