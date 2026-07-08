# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- {OpenBioRQ}: Unsolved Biomedical Research Questions for Agents

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - OpenBioRQ: Unsolved Biomedical Research Questions for Agents

## 基本情報

- **タイトル**: OpenBioRQ: Unsolved Biomedical Research Questions for Agents
- **著者**: Minbyul Jeong
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/pdf/2606.21959

## 落合陽一フォーマット

- **ひとことでいうと**: 未解決の生物医学研究質問を使い、ツール利用エージェントの「根拠づけ」「引用の正しさ」「答えない判断」を評価する benchmark、OpenBioRQ を提案した論文。
- **先行研究と比べてどこがすごい？**: MedQA、PubMedQA、BioASQ、GeneGPT、BioMysteryBench などは既知の正解を前提にするが、本研究は「正解がまだない問い」を対象にする。12領域・12,553問の未解決 biomedical research questions を構築し、引用IDが実在するかだけでなく、その論文が主張を本当に支持するかまで監査する点が新しい。
- **技術や手法の肝はどこ？**: 問いを `crawl → extract → refine → dedup → export` で構築し、retrieval-grounded verifier で「まだ未解決か」を再確認する。評価では、複数の biomedical REST API を使う agentic setting にし、各問に frozen checklist rubric を付けて、正解一致ではなく grounding と uncertainty handling を採点する。
- **どうやって有効だと検証した？**: 12,553問の base corpus と、難問 core subset を使って複数モデルを評価。現在の agentic models は引用の捏造自体は少なく、4,863 citation 中で未解決IDは約0.7%だが、実在する引用の約15.9%は主張を支持しない wrong-paper citation だった。最難 subset では frontier agents が約29〜60%の幅で解け、best agent でも約33〜40%を未解決として残すため、benchmark が飽和していないことを示している。
- **議論はある？**: 未解決性は時間依存であり、将来の論文や trial 結果で解決されうる。wrong-paper rate は LLM judge 依存の推定で、domain expert による本格検証は未完。difficulty も特定時点・特定モデル群に対する相対的な性質であり、live tool 環境の再現性にも制約がある。
- **次に読む/試すなら**: OpenBioRQ の公開 dataset/code と task ID list を確認する。citation audit の L1 existence check と L2 content-support check を自分の RAG pipeline に組み込めるか試す。agentic collapse、つまり難問ほど tool use が減る現象を既存 agent で再現実験する。
- **キーワード**: `biomedical agents`, `citation faithfulness`, `OpenBioRQ`, `agentic benchmark`, `abstention`, `retrieval grounding`

## 気になったこと

- wrong-paper citation の判定が LLM judge に強く依存するため、domain expert annotation でどの程度一致するか。
- 「未解決」の verifier が narrative resolution や非構造化な合意形成をどこまで拾えるか。
- agentic collapse はモデル固有の tool-use policy の問題か、探索空間が広すぎる benchmark 設計の問題か。
- clinical decision support ではなく research assistance 用と明記されているが、実運用 RAG の safety guardrail としてどこまで転用できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
