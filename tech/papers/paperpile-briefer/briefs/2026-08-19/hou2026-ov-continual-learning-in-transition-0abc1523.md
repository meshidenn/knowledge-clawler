# Paperpile Brief 2026-08-19 - Continual Learning in Transition

## 基本情報

- **タイトル**: Continual Learning in Transition
- **著者**: Zhiyan Hou, Dan Zhang, Tao Feng, Liyuan Wang, Wei Li, Xiangzhao Hao, Hongyan An, Junfeng Fang, Haokai Ma, Zhaohui Xu, Xinyu Tang, Haiyun Guo, Jinqiao Wang, Tat-Seng Chua
- **年 / venue**: 2026 / arXiv [cs.LG]
- **リンク**: [arXiv:2608.06216v2](https://arxiv.org/abs/2608.06216v2)

## 落合陽一フォーマット

- **ひとことでいうと**: 継続学習を「モデル重みを更新して忘却を防ぐ問題」から、LLM・エージェントが能力をいつ・どこで・どう更新するかというシステム全体の能力進化として再定義するサーベイ。
- **先行研究と比べてどこがすごい？**: 従来の replay・正則化・構造拡張などのパラメータ中心分類を、`When`（事前学習／事後学習／推論時）、`Where`（パラメータ／harness）、`How`（off-policy／on-policy／勾配を超えた更新）の3軸に拡張する。メモリ、スキル、プロトコル、test-time training、モデルマージを同じ地図で扱う点が新しい。
- **技術や手法の肝はどこ？**: 各手法を固定カテゴリではなく When–Where–How の複数ラベルを持つ「プロファイル」として捉えること。能力の担い手を、更新コストは高いが安定なパラメータ、書き換えやすいが検索に依存する外部メモリ、一時的で容量制約のあるコンテキストに分け、相互の能力移送・スケジューリングを課題化する。
- **どうやって有効だと検証した？**: 本文PDFを主根拠とするサーベイ論文であり、新規手法の単一ベンチマーク実験ではない。代表手法を3軸上に配置し、既存研究の知見として、on-policy 更新の忘却抑制、zeroth-order 最適化やモデルマージ、推論時適応、外部メモリ・スキル蓄積を整理している。
- **議論はある？**: 3軸図に載る手法は網羅的な文献調査ではなく、空白領域を研究密度の統計的証拠と解釈できない。harness 上の能力蓄積は人手設計に依存しがちで、自律的な継続学習とは限らない。長いコンテキストも容量と有効注意の限界があり、外部メモリには陳腐化・ノイズ蓄積に対する能動的忘却が必要である。
- **次に読む/試すなら**:
  1. 自分のエージェントを When–Where–How で棚卸しし、能力がコンテキスト・メモリ・重みのどこにあるかを可視化する。
  2. 長期タスクで、メモリ書き込み・検索・忘却・スキル化の各操作が成功率と再現性に与える影響を測る。
  3. 頻出かつ汎用的な知識を harness からパラメータへ統合する判断基準を設計する。
- **キーワード**: `continual learning`, `LLM agents`, `test-time training`, `agent memory`, `on-policy learning`, `model merging`

## 気になったこと

- 「いつメモリをスキルやパラメータへ統合し、いつ捨てるか」の最適化目標・評価指標は、本文からは確立していない。
- パラメータ・メモリ・コンテキストをまたぐ能力移送を、長期エージェントの実タスクで一貫して比較できるベンチマークが必要そう。
- on-policy 更新の忘却抑制が、報酬設計の偏りや安全性・既存能力への副作用に対してどこまで頑健かを確認したい。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [hou2026-ov-continual-learning-in-transition-0abc1523.md](../../chat/2026-08-19/hou2026-ov-continual-learning-in-transition-0abc1523.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
