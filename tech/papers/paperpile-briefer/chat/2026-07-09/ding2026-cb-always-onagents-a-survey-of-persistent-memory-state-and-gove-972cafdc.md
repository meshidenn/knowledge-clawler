# Chat Prompt 2026-07-09

以下のPaperpile Daily Briefについて、追加で質問したいです。

## 対象論文

- Always-{OnAgents}:A survey of persistent memory, state, and governance in {LLMAgents}

## 質問したいこと

- 最初に読むべき論文を1本選んで、理由を教えて。
- 実装・検証に落とすなら、最小の再現実験は何？
- 関連研究を探すためのキーワードを5個出して。

## Brief

# Paperpile Brief 2026-07-09 - Always-{OnAgents}:A survey of persistent memory, state, and governance in {LLMAgents}

## 基本情報

- **タイトル**: Always-{OnAgents}:A survey of persistent memory, state, and governance in {LLMAgents}
- **著者**: Tianyu Ding, Aditya Nannapaneni, Bingfan Liu, Ling Zhang
- **年 / venue**: 2026 / arXiv [cs.MA]
- **リンク**: メタデータからは不明

## 落合陽一フォーマット

- **ひとことでいうと**: 長期記憶や状態を持ち続けるLLM agentを「persistent-state system」として捉え、記憶・権限・監査・回復・忘却まで含めて整理したサーベイ。
- **先行研究と比べてどこがすごい？**: 単なるmemory retrievalやagent architectureの整理ではなく、task ledger、permissions、credentials、commitments、provenance、audit records、trigger conditions、外部副作用まで「将来の行動を変える durable state」として扱う点が新しい。435件の文献を対象に、状態の蓄積・検索に偏り、統治・回復・放棄が弱いという研究地図を提示している。
- **技術や手法の肝はどこ？**: state itemごとに、authority、scope、mutability、provenance、recoverability、actionabilityの6軸で診断する枠組みを置くこと。さらに、stateが書き込まれ、検証され、整理され、検索され、行動に使われ、更新され、忘却され、監査され、ときにrollbackされる lifecycle としてagentを分析する。
- **どうやって有効だと検証した？**: abstractベースでは、435件のcoded corpusを用いたサーベイとして文献分布を分析し、Always-On Evaluation Protocol（AOEP-v0）というpilot evaluation contractを提案している。ただしPDF本文がなく、具体的なコーディング手順、評価項目、スコアリング、再現性の詳細はメタデータからは不明。
- **議論はある？**: corpusは「exhaustive census」ではなく「scoped map」と明記されており、網羅性には限界がある。AOEP-v0もpilotであり、標準化された評価として成熟しているかは不明。PDF本文がないため、435件の選定基準、annotationの一致度、state分類の境界、実agentへの適用事例は確認できない。
- **次に読む/試すなら**: AOEP-v0の項目を確認し、自分のagent実装にstate mutation / recovery / auditのチェックリストとして当てる。persistent memoryを使う既存agentで、権限・忘却・rollbackがどこまで実装されているか棚卸しする。関連分野としてdatabase recovery、capability security、machine unlearningとの接続を追う。
- **キーワード**: `LLM agents`, `persistent memory`, `agent governance`, `state management`, `auditability`, `recoverability`, `AOEP-v0`

## 気になったこと

- AOEP-v0が具体的に何を入力として、どのようにstate mutationやrecovery obligationを採点するのか。
- 「memory」と「commitment」「credential」「externally committed effect」を同じstate概念で扱うとき、実装上の境界はどこに置くべきか。
- rollback不能な外部副作用、たとえばメール送信・支払い・API実行をどう監査・補償する設計にしているか。
- 435件のcoded corpusの選定基準と、annotationの再現性。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
