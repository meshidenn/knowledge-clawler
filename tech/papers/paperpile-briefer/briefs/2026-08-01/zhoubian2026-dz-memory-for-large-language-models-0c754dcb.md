# Paperpile Brief 2026-08-01 - Memory for large language models

## 基本情報

- **タイトル**: Memory for large language models
- **著者**: Sining Zhoubian, Dan Zhang, Evgeny Kharlamov, Jie Tang
- **年 / venue**: 2026 / arXiv [cs.CL]
- **リンク**: https://arxiv.org/abs/2607.25380v1 / arXiv:2607.25380v1

## 落合陽一フォーマット

- **ひとことでいうと**: LLMにおける「memory」を、attention cacheやrecurrent stateから、test-time adaptation、lookup store、MoE、multi-timescale updateまで含めて、アーキテクチャ中心に整理したsurvey。
- **先行研究と比べてどこがすごい？**: 断片化していたLLM memory研究を、**representation**（implicit / explicit）、**update dynamics**（offline / online）、**persistence**（short-term / long-term）の3軸で統一的に分類している点。単なるRAGやagent memoryではなく、model-level memoryに焦点を絞っている。
- **技術や手法の肝はどこ？**: memoryを「何を保存するか」「いつ・どう更新するか」「どれくらい保持するか」で分解し、KV cache、SSM / Mamba系、linear attention、Titans、TTT、MEMORYLLM、kNN-LM、MoEなどを同じ座標系に置く。特に、implicit memoryは計算グラフに結合した一時状態、explicit memoryは独立したread/write semanticsを持つ保存機構として区別する。
- **どうやって有効だと検証した？**: survey論文なので新規実験よりも分類・比較・設計空間の整理が主。PDF本文では代表モデルを表で整理し、memory設計の trade-off、hybrid architecture、評価観点を議論している。ただし、抽出本文は先頭11ページ分であり、後半の詳細な評価議論はメタデータからは限定的にしか確認できない。
- **議論はある？**: implicit memoryは容量制御、明示的なread/write、sessionをまたぐ永続性に弱い。一方でexplicit memoryは容量、更新安定性、過学習、干渉、system-level efficiencyが問題になる。agent-level memoryやprompt engineering型の外部memoryは対象外としており、実運用のRAG / agent memoryとの接続は追加確認が必要。
- **次に読む/試すなら**: Titans、TTT-E2E、MEMORYLLM、Engramなどexplicit / online memory系を比較して読む。自分のLLM agent実装で、memoryを「短期KV」「長期retrieval」「更新可能parameter / slot」に分けて設計レビューする。LongBench、RULER、∞Benchなど長文・記憶評価ベンチの使い分けを確認する。
- **キーワード**: `LLM memory`, `implicit memory`, `explicit memory`, `test-time training`, `KV cache`, `state space model`, `retrieval memory`, `MoE`

## 気になったこと

- model-level memoryに限定しているため、実際のagent memory、vector DB、tool-use履歴管理との境界をどう接続するか。
- explicit memoryの「書き込み判断」を、surprise、utility、entropy、retrieval failureなどどの信号で制御するのがよいか。
- long-term memory評価で、単なるneedle retrievalではなく、更新・忘却・矛盾解消・privacy deletionまで測れるベンチがあるか。
- MoEをconditional parameter memoryと見る整理は面白いが、通常のcapacity scalingとの差分をどこまでmemory概念で説明できるか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [zhoubian2026-dz-memory-for-large-language-models-0c754dcb.md](../../chat/2026-08-01/zhoubian2026-dz-memory-for-large-language-models-0c754dcb.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
