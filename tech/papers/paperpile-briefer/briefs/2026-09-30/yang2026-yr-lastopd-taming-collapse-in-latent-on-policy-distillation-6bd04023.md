# Paperpile Brief 2026-09-30 - LastOPD: Taming collapse in latent on-policy distillation

## 基本情報

- **タイトル**: LastOPD: Taming collapse in latent on-policy distillation
- **著者**: Jie Yang, Zhengyu Fang, Zelin Xu, Jiarui Sun, Xiran Fan, Junpeng Wang, Liang Wang, Qinghua Liu, Yiwei Cai, Yan Zheng
- **年 / venue**: 2026 / arXiv [cs.LG]（arXiv:2609.28845）
- **リンク**: https://arxiv.org/abs/2609.28845

## 落合陽一フォーマット

- **ひとことでいうと**: 潜在表現を使ったオンポリシー蒸留が途中で崩壊する問題に対し、最終層だけを短期間使い、その後トークンレベルの蒸留へ切り替えるLastOPDを提案した論文。
- **先行研究と比べてどこがすごい？**: OPRDのように全層を継続的に揃えるのではなく、教師と学生が共通して次トークン予測に接続する最終層だけを整列させる。Qwen3-4B/8BからQwen3-1.7B-Baseへの蒸留で、token-only OPDに対してMATH-500をそれぞれ5.55/4.02ポイント改善し、8データセット平均でも3.93/2.10ポイント改善した。
- **技術や手法の肝はどこ？**: 学生自身のロールアウト上で、最終層状態に対する潜在損失とreverse top-16のトークン蒸留損失を併用する。最初の10ステップで潜在損失の重みを1から0へ、トークン損失を0から1へ線形にクロスフェードし、以降はtoken-only OPDを続ける。層対応付けや固定プロジェクタを不要にした点も重要。
- **どうやって有効だと検証した？**: Qwen3-4B/8B教師とQwen3-1.7B-Base学生を用い、DAPO-Math-17kで学習。MATH-500、AIME24/25、AMC23、Minerva、OlympiadBench、AIMO、GSM8Kなどで最終チェックポイントを評価した。潜在損失のみの手法では、MATH-500が約25から10ステップで約46まで上がる一方、継続学習で約11まで崩壊することを示し、LastOPDではこの崩壊を回避した。クロスフェードを常時併用に変えると性能が低下するアブレーションも行った。
- **議論はある？**: 実験対象は主にQwen3の数学推論蒸留で、他のモデル系列・タスク・サイズ差への一般化はメタデータからは不明。層の役割の不一致が崩壊原因だという説明は、J-Lens、CKA、プローブ分析に基づく有力な解釈だが、完全な因果証明ではない。また、最適な10ステップという設定がMATH-500を見て決められており、タスク横断で同じスケジュールが有効かは未検証。論文はarXiv preprintであり、査読状況もメタデータからは不明。
- **次に読む/試すなら**:
  1. 公式コードを使い、Qwen系以外でLastOPDの10ステップクロスフェードを再現する。
  2. クロスフェード長を5/10/15ステップで比較し、検証セットを分離してスケジュール依存性を調べる。
  3. 最終層以外に、J-Lensや線形プローブで対応関係が確認できる層だけを選ぶ実験を行う。
- **キーワード**: `on-policy distillation`, `latent supervision`, `representation collapse`, `Qwen3`, `knowledge distillation`

## 気になったこと

- 潜在表現の整列指標が改善しても性能が悪化するため、CKAやcosine similarity以外に、蒸留後の挙動を予測できる指標が必要そう。
- 最終層が「共通インターフェース」とされるが、モデル間で最終層の表現空間を単純なMLPで接続できる理由はどこまで一般的か。
- 10ステップという短い潜在学習期間が、教師・学生のサイズ比、学習率、バッチサイズ、ロールアウト長にどう依存するか確認したい。
- 大規模活性化を除去しても崩壊が防げない結果から、崩壊の主因は表現の異方性ではなく、潜在信号の適用位置や継続時間なのかを切り分けたい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yang2026-yr-lastopd-taming-collapse-in-latent-on-policy-distillation-6bd04023.md](../../chat/2026-09-30/yang2026-yr-lastopd-taming-collapse-in-latent-on-policy-distillation-6bd04023.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
