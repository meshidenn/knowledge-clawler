# Paperpile Brief 2026-06-11 - On the geometry of on-policy distillation

## 基本情報

- **タイトル**: On the geometry of on-policy distillation
- **著者**: Zhennan Shen, Yanshu Li, Qingyu Yin, Chak Tou Leong, Zhilin Wang, Yanxu Chen, Rongduo Han, Sunbowen Lee, Yi R. Fung
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: https://arxiv.org/abs/2606.07082v1 / arXiv:2606.07082v1

## 落合陽一フォーマット

- **ひとことでいうと**: On-policy distillation、つまり学生モデル自身のロールアウトに対して教師モデルのトークン単位信号で学習する手法が、SFTやRLVRと比べてパラメータ空間でどんな更新軌道を描くかを調べた論文。
- **先行研究と比べてどこがすごい？**: OPDを「SFTとRLVRの中間」と雑に見るのではなく、更新スパース性、特異部分空間の回転、スペクトルドリフト、更新マスクの局在性から幾何学的に位置づけた点。PDF本文では、OPDはSFTより疎で主成分方向を避け、RLVRよりは制約が緩い「relaxed off-principal regime」にあると主張している。
- **技術や手法の肝はどこ？**: 初期重みと学習後重みの差分 `ΔW` を追い、bf16-aware update sparsity、principal-angle rotation、normalized spectral shift、principal/low-magnitude mask overlap で更新の場所と方向を測る。さらに学習途中の累積更新を stable rank や Frobenius norm で追跡し、OPDが早期に低次元の更新チャネルへ入り込む「subspace locking」を示す。
- **どうやって有効だと検証した？**: Qwen3系モデルでSFT、OPD、RLVRを比較。主要な制御比較では、bf16更新スパース性がSFT 8.1%、OPD 51.6%、RLVR 77.2%という順になり、OPDが中間だがRLVR寄りにあると示す。さらに、早期に形成されたrank制約つき部分空間へ学習を射影してもOPD性能は保たれやすく、SFTは劣化しやすいことをAIMEなどの推論ベンチマークで確認している。
- **議論はある？**: 実験はQwen3系、数学・コード系データ、特定のOPD/RLVR設定に強く依存している可能性がある。幾何診断は説得力がある一方、因果的に「なぜその部分空間が機能的に十分か」までは完全には説明していない。PDF抽出上、細かい数値や図表の読み取りにはレイアウト崩れの可能性があるため、厳密な再利用時は原PDF確認が必要。
- **次に読む/試すなら**: 1. OPDのstable rank推移を自分の小規模モデルで再現する。2. SFT/OPD/RLVRの差分重みに対して同じbf16-aware sparsityを計算する。3. OPDとRLVRを混ぜるalpha mixingで更新部分空間がどこで崩れるかを見る。
- **キーワード**: `on-policy distillation`, `parameter-space geometry`, `subspace locking`, `SFT`, `RLVR`, `stable rank`, `Qwen3`

## 気になったこと

- OPDの「locked subspace」はモデルサイズや教師-学生ギャップが変わっても同じ意味の方向を持つのか。
- rank制約で性能が保たれるなら、LoRAや低ランクアダプタ設計に直接転用できるのか。
- OPDの目的関数成分がsubspace lockingを支配するという主張を、別アーキテクチャや非推論タスクでも確認できるか。
- 更新が低次元に閉じることと、汎化・忘却・安全性の関係はまだ未検証に見える。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [shen2026-ph-on-the-geometry-of-on-policy-distillation-8801a78e.md](../../chat/2026-06-11/shen2026-ph-on-the-geometry-of-on-policy-distillation-8801a78e.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
