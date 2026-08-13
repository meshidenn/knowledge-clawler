# Paperpile Brief 2026-08-14 - Search-G1: Grounded Search Agents via Representation-Based Intrinsic Rewards

## 基本情報

- **タイトル**: Search-G1: Grounded Search Agents via Representation-Based Intrinsic Rewards
- **著者**: Ruoxi Cheng, Haoxuan Ma, Hongyi Zhang, Junming Zhang, Ranjie Duan, Qiaolin Xia, Hao Wang, Yu Lu, Haibo Shi, Xingjun Ma
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: [arXiv:2608.07531](https://arxiv.org/abs/2608.07531) / [Code](https://github.com/Rosy0912/Search-G1)

## 落合陽一フォーマット

- **ひとことでいうと**: 検索が「必要だったか」と、最終回答が「実際に取得証拠へ依存したか」をモデル内部表現から推定し、必要なときだけ根拠付き検索を強化するRL報酬設計。
- **先行研究と比べてどこがすごい？**: 正解・不正解だけの報酬は、検索せずとも知っていた回答と検索根拠を使った回答を区別できない。一方でSearch-G1は、LLM-as-a-judgeや工程アノテーションを最適化中に必要とせず、介入実験で較正した軽量readoutにより、groundingと検索コストを同時に扱う。4つのQAベンチマーク・Qwen2.5の3B/7Bで、競争力ある精度を保ちつつgroundingと軌跡長を改善した。
- **技術や手法の肝はどこ？**: プロンプト時点の隠れ状態からclosed-bookで答えられる確率 \(b\) を予測し、検索必要性を \(1-b\) とする。さらに回答確定時の隠れ状態から、取得文書を削除したとき回答が変わる確率 \(d\) を予測する。正しく検索した軌跡には \(d(1-b)\) を報酬として与え、正しい直接回答には \(b\) を与え、複数回検索にはコストを課す。RLで内部表現が変化するため、readoutも最新チェックポイントで定期的に再学習する。
- **どうやって有効だと検証した？**: NQ、HotpotQA、2WikiMultiHopQA、MuSiQueで評価し、正解率（EM）、反実仮想的なtrust consistency、文書置換後も回答が変わらない割合（D-Inv）、質問あたり検索回数を比較した。2WikiMultiHopQAの3BではSearch-G1がEM 0.368、TC 0.972、Search/Q 2.812で、Search-R1の0.267、0.913、3.402を上回った。readoutの推定性能もAUCで監査し、各要素を外すablationも実施している。
- **議論はある？**: 「文書を消すと回答が変わる」ことは因果的な根拠利用の完全な証明ではなく、operational proxyにとどまる。評価はQwen系2モデル、固定のWikipedia検索環境、テキストQAに限定される。readoutの較正と定期再学習には追加計算が必要で、retrieverや介入設計が変わればgrounding指標の絶対値も変わりうる。
- **次に読む/試すなら**:
  1. Search-R1、Knowledge Boundary-aware Policy Optimization（KbPO）と報酬設計の差分を比較する。
  2. 自分のRAGエージェントで、証拠削除時の回答変化をログ化して \(d\) の簡易版を測る。
  3. web検索・長期タスク・画像や表を含む証拠でも同じreadoutが成立するか検証する。
- **キーワード**: `agentic search`, `grounded retrieval`, `reinforcement learning`, `intrinsic reward`, `representation probing`, `counterfactual evaluation`

## 気になったこと

- 証拠削除で回答が変わることが、単なる文脈攪乱ではなく「正しい証拠への依存」をどこまで測れているか。
- readoutの定期再学習頻度と計算コストが、実運用での総学習コストをどの程度押し上げるか。
- 検索結果自体が誤っている場合に、証拠依存を強化する報酬が誤ったgroundingを促さないか。
- 検索回数ではなく、取得・再ランキング・生成トークンを含む実計算コストで優位性がどこまで維持されるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [ruoxi2026-ae-search-g1-grounded-search-agents-via-representation-based-i-d0f07def.md](../../chat/2026-08-14/ruoxi2026-ae-search-g1-grounded-search-agents-via-representation-based-i-d0f07def.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
