# Paperpile Brief 2026-08-18 - Scaling Domain Data Repetition in LLM Pretraining

## 基本情報

- **タイトル**: Scaling Domain Data Repetition in LLM Pretraining
- **著者**: Jingwei Li, Xinran Gu, Rui Dai, Xintong Hao, Chengyin Xu, Yan Wu, Shuran Zheng, Jingzhao Zhang
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2608.14071v1](https://arxiv.org/abs/2608.14071v1)

## 落合陽一フォーマット

- **ひとことでいうと**: LLMの学習規模に合わせて総トークン数も増やす現実的な設定では、高品質なドメインデータの最適な繰り返し回数は、モデルが大きくなるほどむしろ少し増えることを示した論文。
- **先行研究と比べてどこがすごい？**: 従来の「モデルが大きいほど重複データに過学習しやすい」という結論は、総トークン数を固定した比較に依存する。本論文は tokens-per-parameter ratio（TPP）を固定し、モデル拡大に応じて学習トークンも増やすと結論が反転することを、実験と理論の両方で示す。
- **技術や手法の肝はどこ？**: Code・Math・Wikipedia・Medicalの各ドメインについて、ユニークデータ比率 \(\alpha\) と反復回数 \(e\) を掃引しつつ、モデルサイズごとの総トークン予算 \(D=\mathrm{TPP}\times N\) を固定する。最終検証損失を反復回数の二次関数で近似し、連続的な最適反復回数を推定する。さらに、知識獲得とノイズ適合のトレードオフをone-hot線形回帰で理論化した。
- **どうやって有効だと検証した？**: 4ドメイン、ユニーク高品質トークン比率3水準（1/40、1/20、1/10）、反復回数1〜7で学習し、ドメイン内検証損失とOODのArXiv・News検証損失を評価した。最適反復回数は最小検証損失と強い負相関（Pearson \(r=-0.944\)）を示し、モデルサイズとは弱い正相関（\(r=0.400\)）、ユニークデータ比率とはほぼ無相関（\(r=0.018\)）だった。
- **議論はある？**: 検証対象は4ドメインで、一度に反復する高品質ドメインも1つだけである。複数ドメインを同時に反復する実運用の混合比最適化には未検証。学習率スケジュールでも許容できる反復回数が変わるため、反復回数をドメインだけで固定するのは危険である。モデル規模やデータセットの詳細な内訳は、PDF抽出テキストからは十分に明確でない。
- **次に読む/試すなら**:
  1. 小規模proxyモデルで本番と同じTPPを保ち、対象ドメインの反復回数を掃引する。
  2. ドメイン内損失だけでなく、一般Web・専門外データでのOOD損失も同時に測る。
  3. 複数の専門ドメインを同時に反復した場合の干渉と、学習率スケジュール依存性を検証する。
- **キーワード**: `LLM pretraining`, `data repetition`, `data mixture`, `scaling laws`, `tokens-per-parameter ratio`, `overfitting`

## 気になったこと

- Mathはおおむね5〜6回の反復まで有効だが、Wikipedia・Medicalは3〜4回程度で最適になる。これはデータ品質、ノイズ、知識の冗長性のどれで説明できるか。
- 固定TPPでの「小モデルで安全な反復回数は大モデルでも安全」という知見を、異なるアーキテクチャやTokenizerでも転用できるか。
- OOD損失は比較的安定だったが、下流タスク性能・暗記・データ漏洩リスクまで安定かは未検証である。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [li2026-tn-scaling-domain-data-repetition-in-llm-pretraining-4dd6d447.md](../../chat/2026-08-18/li2026-tn-scaling-domain-data-repetition-in-llm-pretraining-4dd6d447.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
