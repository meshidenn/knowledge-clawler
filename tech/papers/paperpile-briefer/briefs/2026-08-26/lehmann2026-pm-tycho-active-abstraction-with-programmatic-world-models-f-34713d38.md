# Paperpile Brief 2026-08-26 - Tycho: Active Abstraction with Programmatic World Models for ARC-AGI-3

## 基本情報

- **タイトル**: Tycho: Active Abstraction with Programmatic World Models for ARC-AGI-3
- **著者**: Jens Lehmann, Andrei Aioanei, Sahar Vahdati
- **年 / venue**: 2026 / arXiv [cs.AI]
- **リンク**: [arXiv:2607.28287](https://arxiv.org/abs/2607.28287) / [PDF](https://arxiv.org/pdf/2607.28287) / [実装](https://github.com/NIMI-research/Tycho)

## 落合陽一フォーマット

- **ひとことでいうと**: ARC-AGI-3の未知ゲームを、行動コストを払って探索しながら実行可能な世界モデルとして抽象化し、「いつモデルを作る・直す・使わないか」まで制御するコーディングエージェントTychoを提案した。
- **先行研究と比べてどこがすごい？**: 世界モデルを常時必須の構成要素にせず、直接推論・単一エージェントによるモデル化・専門Builderへの委譲・自動修復を同一の証拠／行動インターフェースで比較した点が新しい。選択された委譲型方策では、GPT-5.6 SolとOpus 5が公開25ゲーム・183レベルを完了し、RHAE 100.00を報告している。
- **技術や手法の肝はどこ？**: ゲームを隠れ状態を持つ決定論的Moore machineとして扱い、Pythonで状態・遷移・描画・終端判定を記述するプログラム的世界モデルを構築する。過去軌跡のreplayでモデルを検証し、受理されたモデル上で計画を探索する一方、Actor自身がモデル構築やBuilder委譲の価値を判断する。この「モデル獲得・利用自体の意思決定」をactive abstractionと呼ぶ。
- **どうやって有効だと検証した？**: ARC-AGI-3公開セット全25ゲーム・183レベルで、同一推論予算の4方策をClaude Opus 4.8で比較した。RHAEは直接推論79.07、単一Actor 85.36、Actor要求によるBuilder委譲88.49、自動修復83.07。委譲型を選択後、GPT-5.6 Solは7,766行動、Opus 5は6,641行動で全レベルを完了した。遷移一致率、予測カバレッジ、終端判定、行動数も分けて評価している。
- **議論はある？**: 方策比較は各方策1回の公開セット走行であり、実行間のばらつきは十分に測っていない。遷移を再現するモデルでも、ゴール理解や次行動の改善を保証しないことが実験で示された。RHAEには上限があり、満点同士の行動効率差は圧縮される。さらに、モデル選択・アーキテクチャ改善には人手を介したcross-run adaptationが含まれる。
- **次に読む/試すなら**:
  - 公開実装で、特定ゲーム1本に対するモデル生成・replay検証・計画の最小ループを再現する。
  - Builder委譲の発火条件を、固定ルール・Actor判断・不確実性推定で比較する。
  - 「遷移一致は高いが攻略に失敗する」ケースを収集し、目的・終端条件の推論を分離評価する。
- **キーワード**: `ARC-AGI-3`, `world model`, `program synthesis`, `active abstraction`, `agent orchestration`, `planning`

## 気になったこと

- Builder委譲の優位性は、モデル構築そのものよりも、Actorが委譲タイミングを選べることによる可能性がある。
- 自動修復は遷移再現を改善してもRHAEが伸びない。モデルの正確さだけでなく、目標表現・探索方策・モデル利用コストをどう測るべきか確認したい。
- 25ゲーム・単発走行を超えて、未知ゲーム群や複数seedで同じ結論が再現するかが重要である。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [lehmann2026-pm-tycho-active-abstraction-with-programmatic-world-models-f-34713d38.md](../../chat/2026-08-26/lehmann2026-pm-tycho-active-abstraction-with-programmatic-world-models-f-34713d38.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
