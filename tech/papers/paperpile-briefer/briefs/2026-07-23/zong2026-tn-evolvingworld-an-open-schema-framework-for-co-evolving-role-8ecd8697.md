# Paperpile Brief 2026-07-23 - EvolvingWorld: An open-schema framework for co-evolving role-play agents and World Model in interactive literary world

## 基本情報

- **タイトル**: EvolvingWorld: An open-schema framework for co-evolving role-play agents and World Model in interactive literary world
- **著者**: Qing Zong, Yue Guo, Mengxin Yang, Yiwen Guo, Yangqiu Song
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.17250 / arXiv:2607.17250

## 落合陽一フォーマット

- **ひとことでいうと**: 文学作品の世界を、静的なキャラ再現ではなく、キャラクター状態と世界状態が長期的に相互更新されるシミュレーションとして扱うフレームワーク兼ベンチマークを提案した論文。
- **先行研究と比べてどこがすごい？**: 既存のRole-play agentは固定プロフィール、短い対話文脈、単一シーン生成、固定スキーマの世界表現に寄りがちだった。EvolvingWorldは、作品ごとに異なるキャラクター属性・世界属性をopen-schemaで持ち、キャラクターの内面・関係・場所・エンティティ・グローバル世界状態を連動して更新する点が差分。
- **技術や手法の肝はどこ？**: Character AgentとLLM-based World Modelを結合し、scene initialization、interaction generation、state updateを7つの教師ありタスクに分解している。特に、すぐ変わる感情と時間をかけて変わる人格・関係性を分けるためにhidden trackerを導入し、弱い証拠を蓄積してからプロフィール更新に反映する設計が肝。
- **どうやって有効だと検証した？**: Project Gutenberg由来の57冊から、138,596件の教師あり訓練サンプルと222件のテストsnapshotを構築。10次元・20指標のtrajectory-level LLM-as-Judge評価で、キャラクター一貫性、進化品質、環境 grounding、世界状態維持、シーン計画などを評価。BookWorldなどの長期シミュレーション系ベースラインと比較し、長期化に伴う性能劣化を抑える傾向を示している。ただし、細かな数値はPDF抽出テキスト上では一部崩れているため断定しすぎない。
- **議論はある？**: 世界状態を全キャラクター共有の客観状態として扱っており、キャラクターごとの誤認・記憶違い・主観的世界認識は十分に扱えない。LLMのcontext length制約により、全エンティティではなく重要エンティティ中心の追跡になる。データは著作権上public-domain古典に限定され、現代小説・ゲーム・ユーザー生成世界への一般化は今後の検証課題。
- **次に読む/試すなら**: BookWorldとの比較部分を精読する。 / hidden trackerがどの程度更新の安定性に効いているかablationを確認する。 / 小規模な自作物語世界でopen-schema state updateを再現実験する。
- **キーワード**: `role-playing agents`, `world model`, `open-schema`, `literary simulation`, `multi-agent`, `long-horizon simulation`, `LLM-as-Judge`

## 気になったこと

- open-schemaの自由度が高いほど、評価時に「正しい状態更新」をどう定義するかが難しくなりそう。
- LLM-as-Judgeの20指標は便利だが、judge model依存のバイアスや再現性がどこまで管理されているか確認したい。
- hidden trackerは実装上かなり重要そうなので、どの形式で証拠を蓄積し、いつprofileへ昇格させるのかを詳しく見たい。
- 主観的世界モデル、記憶の不一致、キャラクターごとのbelief stateを入れると、より物語らしくなる一方で状態爆発しそう。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zong2026-tn-evolvingworld-an-open-schema-framework-for-co-evolving-role-8ecd8697.md](../../chat/2026-07-23/zong2026-tn-evolvingworld-an-open-schema-framework-for-co-evolving-role-8ecd8697.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
