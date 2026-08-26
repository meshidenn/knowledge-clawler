# Chat Prompt 2026-08-27

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Unified deployment-aware evaluation of open reasoning language models

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-08-27 - Unified deployment-aware evaluation of open reasoning language models

## 基本情報

- **タイトル**: Unified deployment-aware evaluation of open reasoning language models
- **著者**: Md Motaleb Hossen Manik, Ge Wang
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2604.07035v2](https://arxiv.org/abs/2604.07035v2)

## 落合陽一フォーマット

- **ひとことでいうと**: オープン推論LLMの評価を、単一の正答率ランキングではなく、精度・遅延・VRAM・プロンプト感度・互換性を含む「配備可能な動作点」の選択問題として統一的に比較した論文。
- **先行研究と比べてどこがすごい？**: 7モデル×4ベンチマーク×3プロンプトの全84条件を、各238例・同一パイプラインで揃えた。最高スコアの Gemma-4-26B-A4B と、速度・メモリ効率のよい Gemma-4-E4B を区別し、実運用では後者が有力となり得ることを示す。
- **技術や手法の肝はどこ？**: ARC-Challenge、GSM8K、MATH L1–L3、TruthfulQA MC1を統一条件で評価し、正答率に加えて Wilson信頼区間、レイテンシ、ピークVRAM、Pareto前線、プロンプト間の順位相関、出力抽出・形式遵守の互換性診断を報告する。タスクごとの最適モデルを選べる理想的ルータの上限も測る。
- **どうやって有効だと検証した？**: 19,992件を評価。Gemma-4-26B-A4Bのzero-shotが重み付きスコア0.794で首位、Gemma-4-E4Bは少ない遅延・VRAMで上位に近い。理想的なタスク別選択では0.825まで上がる。ブートストラップと対応付き置換検定で上位構成の差も検討した。
- **議論はある？**: 各条件238例に揃えるため、全ベンチマークの全分割を使っていない。重み付き集約の順位はタスク重みに依存し、遅延・VRAM値は単一ハードウェア環境依存である。ルーティング結果は実装コストや選択誤差を含まないoracle上限であり、Phi-4-Reasoningの失敗にはモデル能力だけでなく出力形式・抽出パイプラインの相互作用も含まれる。
- **次に読む/試すなら**:
  - Gemma-4-E4BとGemma-4-26B-A4Bを、自分のGPU・量子化設定・実タスクでPareto比較する。
  - few-shot CoTを含む複数プロンプトで順位の安定性を再測定する。
  - 軽量なタスク別・予算別ルータを実装し、oracle上限0.825との差を測る。
- **キーワード**: `open reasoning LLM`, `deployment-aware evaluation`, `Pareto frontier`, `prompt sensitivity`, `model routing`, `compatibility diagnostics`

## 気になったこと

- 238例という共通サブセットで得た順位が、各ベンチマーク全分割でも維持されるか。
- 重み付きスコアのタスク重みを変えた際、Gemma-4-E4Bの実用上の優位性がどこまで安定するか。
- Phi-4-Reasoningの低成績を、モデル固有の出力パーサやプロンプト設計でどの程度回復できるか。
- oracleルーティングを現実の分類器・不確実性推定付きルータに置き換えた際の純増益とオーバーヘッド。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
