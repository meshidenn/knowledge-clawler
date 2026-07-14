# Chat Prompt 2026-07-15

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Towards mechanistically understanding why memorized knowledge fails to generalize in large language model finetuning

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-15 - Towards mechanistically understanding why memorized knowledge fails to generalize in large language model finetuning

## 基本情報

- **タイトル**: Towards mechanistically understanding why memorized knowledge fails to generalize in large language model finetuning
- **著者**: Lu Dai, Ziyang Rao, Yili Wang, Hanqing Wang, Hao Liu, Hui Xiong
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2607.08393

## 落合陽一フォーマット

- **ひとことでいうと**: LLMをfine-tuningで新知識に適応させても「覚えた事実を推論で使えない」現象を Knowing--Using Gap として定式化し、その内部メカニズムを self-patching で調べた論文。
- **先行研究と比べてどこがすごい？**: 知識編集やRAGの性能評価ではなく、fine-tuning中に「記憶表現がどの層に存在し、推論回路に接続されるか」を介入的に追っている点。単なる recall と multi-hop reasoning の差を、精度差と時間遅れの両方で測り、さらに手動で表現を移すと失敗例が回復することを示している。
- **技術や手法の肝はどこ？**: self-patching。source run の特定トークン・特定層の hidden representation を target run の別層へコピーし、正解確率がどれだけ改善するかを見る。これにより、記憶された知識が内部に存在していても、推論に効く層・位置へ自然には流れていないという knowledge-circuit misalignment 仮説を検証している。
- **どうやって有効だと検証した？**: STaRK-Prime biomedical と STaRK-MAG academic knowledge graph から、未知知識の memorization QA と chaining / intersection の generalization QA を構成。Qwen系、LLaMA系モデルでLoRAおよびfull fine-tuningを行い、memorization accuracy と generalization accuracy の推移を比較した。さらに self-patching、irrelevant patching、CoT prompting などを比較し、固定ヒューリスティックでも oracle headroom の 58〜75% を回復したと報告している。
- **議論はある？**: PDF本文ベースでは、self-patchingは固定位置・層間移動に制約された診断であり、知識が複数位置や分散表現として存在する場合を十分に扱えない可能性がある。また、表現を移す介入で性能が上がることは強い証拠だが、実運用のfine-tuning手法としてそのまま使えるか、より大規模・多様な知識更新で同じ現象が保たれるかは追加検証が必要。
- **次に読む/試すなら**: 1. self-patchingの実装を確認し、activation patchingとの違いを再現する。2. 自分の知識注入タスクで memorization / chaining / intersection を分けて評価する。3. CAKE、MQuAKE、RippleEdits など知識編集のgeneralization系ベンチマークと比較する。
- **キーワード**: `Knowing-Using Gap`, `self-patching`, `mechanistic interpretability`, `LLM fine-tuning`, `knowledge-circuit misalignment`, `multi-hop reasoning`

## 気になったこと

- self-patchingで見つかる「使える表現」は、通常のfine-tuning objectiveをどう変えれば自然に推論回路へ流れるのか。
- 固定ヒューリスティックの層ペアがモデルサイズやアーキテクチャを跨いでどこまで安定するのか。
- RAGやknowledge editingと組み合わせた場合、Knowing--Using Gapは縮むのか、それとも別の形で残るのか。
- Chainingでは大きなgapが残り、Intersectionでは比較的小さい理由を、回路レベルでもっと細かく見たい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
