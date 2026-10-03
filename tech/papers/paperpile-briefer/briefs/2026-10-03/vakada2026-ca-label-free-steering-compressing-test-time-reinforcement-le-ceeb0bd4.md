# Paperpile Brief 2026-10-03 - Label-free steering: Compressing test-time reinforcement learning into bias-only subspaces

## 基本情報

- **タイトル**: Label-free steering: Compressing test-time reinforcement learning into bias-only subspaces
- **著者**: Naveen Vakada、Mingyuan Li、Shaoxiong Ji
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2609.18587

## 落合陽一フォーマット

- **ひとことでいうと**: 正解ラベルなしのテスト時強化学習で、モデル本体を凍結し、各MLP層のバイアス約10万パラメータだけを更新して推論性能を改善した論文。
- **先行研究と比べてどこがすごい？**: 多くのTTRLがモデル全体を更新するのに対し、Qwen2.5-7Bの約76,000分の1のパラメータだけを最適化してMATH-500で76.67%を達成した。同一パラメータ数のLoRAやReFTより安定して改善し、ラベル付きバイアス調整にも近い性能を示す。
- **技術や手法の肝はどこ？**: 複数ロールアウトの多数決を擬似ラベルとし、その一致度に基づく報酬でGRPOを実行する。更新対象は各デコーダ層の`down_proj.bias`のみで、バックボーン、Attention、埋め込み、正規化層は凍結する。性能はパラメータ数ではなく、RL勾配をどれだけバイアス部分空間に取り込めるか、すなわちaccessible gradient energyに依存すると分析する。
- **どうやって有効だと検証した？**: MATH-500、MathVista、AI2D、LogicVista、MMAUで評価し、テキスト・画像・音声の複数モダリティに適用した。学習に使った問題とは分離した4,500問のMATH問題にもバイアスベクトルを転移し、Qwen2.5-7Bで46.3%から70.9%へ改善した。また、同一の約100,352パラメータ予算でLoRA・ReFTと比較し、9個の単層バイアス部分空間では勾配エネルギーと学習可能性に強い相関（Spearman ρ=0.917）を確認した。
- **議論はある？**: 多数決擬似ラベルはモデル自身の誤答を強化し得るため、ロールアウトの合意が正しさを保証しない。MMAUの改善は特定の音素カウント問題に大きく依存し、そのテンプレートを除くと改善は+1.4ポイントに留まる。ReFTは学習途中で改善しても最終性能が崩れやすく、手法間の安定性差も残る。さらに、データセット上のショートカットと真の推論能力向上を完全には分離できていない。
- **次に読む/試すなら**:
  1. 公開コードとチェックポイントで、MATH-500の多数決報酬によるバイアス更新を最小再現する。
  2. ロールアウト数、初期合意率、バイアスを挿入する層を変え、性能との関係を測る。
  3. ベンチマーク全体ではなく問題テンプレート別に、改善が真の推論かショートカットかを監査する。
- **キーワード**: `test-time reinforcement learning`, `bias-only steering`, `pseudo-label`, `GRPO`, `accessible gradient energy`

## 気になったこと

- 多数決の正解率が低い問題群では、擬似ラベル学習がどの程度まで誤答の固定化を起こすのか。
- 4,500問の転移改善が、問題形式の一般化なのか、Qwen系モデル固有の出力傾向への適応なのか。
- MMAU以外のベンチマークでも、テンプレート別・難易度別の監査後に改善が残るのか。
- バイアス部分空間の選択を、学習前にaccessible gradient energyで予測できるのか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [vakada2026-ca-label-free-steering-compressing-test-time-reinforcement-le-ceeb0bd4.md](../../chat/2026-10-03/vakada2026-ca-label-free-steering-compressing-test-time-reinforcement-le-ceeb0bd4.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
