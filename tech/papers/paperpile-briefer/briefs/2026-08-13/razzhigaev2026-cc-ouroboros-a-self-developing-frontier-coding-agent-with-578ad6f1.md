# Paperpile Brief 2026-08-13 - Ouroboros: A self-developing frontier coding agent with reviewed core evolution

## 基本情報

- **タイトル**: Ouroboros: A self-developing frontier coding agent with reviewed core evolution
- **著者**: Anton Razzhigaev, Andrei Gritsaev, Andrei Kaznacheev, Nikita Dragunov, Roman Yampolskiy, Andrei Kuznetsov
- **年 / venue**: 2026 / arXiv [cs.SE]
- **リンク**: https://arxiv.org/abs/2608.08311 / arXiv:2608.08311

## 落合陽一フォーマット

- **ひとことでいうと**: 自分自身のツール、プロンプト、context assembly、core実装を、review済みcommitとして更新し続けるcoding agent harness「Ouroboros」と、その長期稼働実験「Hope」を提示した論文。
- **先行研究と比べてどこがすごい？**: VoyagerやLive-SWE-agentのようなskill/tool進化だけでなく、harnessのcore codeとgovernance面までversion管理されたreviewed commitで進化対象にしている点が差分。Terminal-Bench 2.1で86.74% after audit、OSWorld-Verifiedで90.69%、CL-Benchでnormalized reward 0.2301を報告し、複数benchmarkでSOTA級の性能を主張している。
- **技術や手法の肝はどこ？**: launcher/supervisorとmutable agent repositoryを分離し、自己変更はpreflight、staged diff fingerprint、multi-model diff review、再fingerprint、commit receiptを通る。進化モードは、改善そのものをtask化するrecursive free evolutionと、通常作業・social feedback・失敗記録から構造修正を起こすexperience-driven core evolutionの2系統。
- **どうやって有効だと検証した？**: Terminal-Bench 2.1、OSWorld-Verified、CL-Bench、SWE-bench Pro、GAIAなどでfrozen snapshotを使って評価し、run manifest、seed/runtime attestation、task ledger、secret scrubbingを残す設計。さらにHopeを161日間、7つのinteraction surfaceで運用し、自己変更commit 1,085件、reviewed self-edit attempts 1,522件などの運用統計を示している。
- **議論はある？**: 1つの長期lineageの観察であり、独立に進化する複数agent群のcontrolled studyではない。LLM reviewerはagent本体とblind spotを共有し得る。low context modeではwhole-repository scope reviewが省略される。SWE-bench Proにはpublic-reference leakageやtask defectの影響があると論文自身も認めている。
- **次に読む/試すなら**: 1. GitHub実装とrun artifactを確認し、review gateが実際にどこまで強制されているか読む。2. Terminal-Bench/OSWorldの評価設定でanti-lookupやdelegation offが再現可能か確認する。3. 自分のcoding agent環境で「失敗pattern register → maintenance issue化」だけを小さく再現する。
- **キーワード**: `self-developing agent`, `coding agent`, `reviewed commits`, `agent harness`, `recursive self-improvement`, `operational safety`, `Terminal-Bench`, `OSWorld`

## 気になったこと

- self-modificationのreviewerもLLMである以上、同系統model間の共通盲点をどう測るか。
- 「agentが変更を選ぶ」部分のobjective driftを、constitutionとoperator haltだけでどこまで抑えられるか。
- benchmark用frozen lineageとlive Hope lineageの差分が、性能や安全性の主張にどの程度影響するか。
- 161日運用の社会的feedbackが、品質改善と単なる利用者嗜好への過適合のどちらに寄っているか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [razzhigaev2026-cc-ouroboros-a-self-developing-frontier-coding-agent-with-578ad6f1.md](../../chat/2026-08-13/razzhigaev2026-cc-ouroboros-a-self-developing-frontier-coding-agent-with-578ad6f1.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
