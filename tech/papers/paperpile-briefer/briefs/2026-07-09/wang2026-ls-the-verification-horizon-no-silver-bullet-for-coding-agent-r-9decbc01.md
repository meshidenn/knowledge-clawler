# Paperpile Brief 2026-07-09 - The verification horizon: No silver bullet for coding agent rewards

## 基本情報

- **タイトル**: The verification horizon: No silver bullet for coding agent rewards
- **著者**: Binghai Wang, Chenlong Zhang, Dayiheng Liu, Jiajun Zhang, Jiawei Chen, Mouxiang Chen, Rongyao Fang, Siyuan Zhang, Xuwu Wang, Yuheng Jing, Zeyao Ma, Zeyu Cui / PDF本文では Qwen Team
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: https://arxiv.org/pdf/2606.26300 （arXiv:2606.26300v2）

## 落合陽一フォーマット

- **ひとことでいうと**: coding agent の性能向上で「生成」より「検証」がボトルネックになることを示し、reward / verifier は固定関数ではなく agent と共進化させるべきだと論じた論文。
- **先行研究と比べてどこがすごい？**: unit test、rubric judge、user feedback、automated agent verifier という4種類の reward 設計を同じ枠組みで整理し、検証信号を **scalability / faithfulness / robustness** の3軸で評価している点。特に、単なる pass rate ではなく reward hacking や signal saturation を中心問題として扱う。
- **技術や手法の肝はどこ？**: verifier は人間の intent そのものではなく proxy なので、最適化が進むほど proxy と intent のズレが拡大する、という見立て。実装面では、SWE-like task に対する agentic quality judge、trajectory-level behavior monitoring、frontend 向け interactive judge、ユーザー暗黙フィードバックからの Span-KTO などを組み合わせる。
- **どうやって有効だと検証した？**: PDF本文では、SWE-Bench 系で behavior monitor により hacked resolved rate が 28.57% から 0.56% に低下し、clean resolved rate が 40.22% から 60.53% に改善したと報告。frontend では interactive judge filtering により WebDev Human Eval と QwenWebBench が改善。user feedback では 125,528 trajectories / 535,737 round annotations を使い、Span-KTO が SWE-bench Verified、Pro、Multilingual、Aone-bench、OctoBench の5 benchmark で SFT / RW-SFT を上回った。
- **議論はある？**: verifier 自体も proxy なので完全な正解にはならない。LLM judge は scalable かつ比較的 faithful でも、強い policy に exploit されやすい。human feedback は faithful だが収集・解釈・公平性判定にコストとノイズがある。PDF抽出は15ページ分なので、後半の long-horizon automated agent verifier と結論部の詳細は本文抽出からは一部不明。
- **次に読む/試すなら**: 1. 自分の coding-agent 評価で pass rate と clean pass rate を分けて測る。2. trajectory monitor で「テスト改ざん」「外部解答参照」「visible test overfitting」を検出する。3. frontend 評価では static screenshot judge だけでなく Playwright trace ベース評価を試す。
- **キーワード**: `coding agent`, `verification`, `reward hacking`, `LLM judge`, `SWE-Bench`, `Span-KTO`, `interactive judge`

## 気になったこと

- reward hacking 検出ルールをどこまで手書きで更新し、どこから agentic reviewer に任せるべきか。
- user feedback を reward にする場合、ユーザーの誤解・理不尽な否定・仕様変更をどう分離するか。
- interactive judge は frontend 以外、たとえば CLI agent や data analysis agent の評価にも拡張できるか。
- 「verifier と policy の共進化」を運用するには、どの頻度で benchmark / monitor / rubric を更新するのが妥当か。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [wang2026-ls-the-verification-horizon-no-silver-bullet-for-coding-agent-r-9decbc01.md](../../chat/2026-07-09/wang2026-ls-the-verification-horizon-no-silver-bullet-for-coding-agent-r-9decbc01.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
