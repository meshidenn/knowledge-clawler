# Paperpile Brief 2026-08-03 - Unlimited OCR Works

## 基本情報

- **タイトル**: Unlimited OCR Works
- **著者**: Youyang Yin, Huanhuan Liu, YY, Qunyi Xie, Chaorun Liu, Shiqi Yang, Shaohua Wang, Zhanlong Liu, Hao Zou, Jinyue Chen, Shu Wei, Jingjing Wu, Mingxin Huang, Zhen Wu, Guibin Wang, Tengyu Du, Lei Jia
- **年 / venue**: 2026 / arXiv [cs.CV]
- **リンク**: arXiv:2606.23050 / https://arxiv.org/pdf/2606.23050 / code: http://github.com/baidu/Unlimited-OCR

## 落合陽一フォーマット

- **ひとことでいうと**: DeepSeek OCRをベースに、decoderの全attentionをReference Sliding Window Attention（R-SWA）へ置き換え、長い文書を1回のforward passでOCRするためのモデルを提案した技術報告。
- **先行研究と比べてどこがすごい？**: 通常のLLM decoder型OCRでは出力が長くなるほどKV cacheが増え、生成速度も落ちる。Unlimited OCRはvisual/prompt tokenを常に参照しつつ、過去出力は直近128 tokenだけを見る設計にして、decode中のKV cacheを定数サイズに保つ。OmniDocBench v1.5でDeepSeek OCRの87.01に対し93.23、v1.6で93.92を報告している。
- **技術や手法の肝はどこ？**: R-SWAは、prefix領域のreference token、つまり画像特徴とpromptには全生成tokenから常時attentionし、decode済み出力には固定幅のcausal sliding windowだけでattentionする。画像tokenは状態遷移させず固定参照にするため、linear attention的な逐次圧縮で視覚情報がぼける問題を避ける。実装上はKV cacheを「reference KV + 直近n tokenの出力KV」のqueueとして管理する。
- **どうやって有効だと検証した？**: DeepSeek OCR checkpointから継続学習し、約200万の文書OCRデータで4,000 step training。評価はOmniDocBench v1.5/v1.6、9種類の文書カテゴリ別比較、さらに社内multi-page test setで2/5/10/15/20/40+ pagesのlong-horizon OCRを検証。40+ pagesでもEdit Distance 0.1069、Distinct-35 96.90%を報告している。効率面では出力長6,144 token付近でDeepSeek OCRよりTPSが約35%高いという理論上限比較も示している。
- **議論はある？**: 「Unlimited」と言いつつ、有限context長ではprefill長が制約になるため本当の無制限ではない。multi-pageでは1024×1024のBase modeを使うため、小さい文字の認識がボトルネックになる。長文OCRの評価は社内データで、外部再現性やデータセットの詳細は限定的。R-SWAがASRや翻訳にも有効という主張は展望であり、この論文内ではOCR以外の実証はない。
- **次に読む/試すなら**: DeepSeek OCRとの差分実装としてR-SWAのKV cache管理を確認する。公開repoでTransformers/SGLangの実装が本当に定数メモリになっているか試す。OmniDocBenchではなく手元の長いPDFでpage-by-page処理との速度・精度差を見る。
- **キーワード**: `OCR`, `R-SWA`, `KV cache`, `long-horizon parsing`, `DeepSeek OCR`, `document parsing`, `sliding window attention`

## 気になったこと

- R-SWAのwindow幅128が、数式・表・複雑レイアウトで本当に十分なのか。
- multi-page synthetic dataが実文書のページ間構造や参照関係をどこまで再現しているのか。
- 40+ pages評価の社内データを、公開ベンチマークで再現できるか。
- OCR以外のASR・翻訳では「reference tokenを常時固定参照する」仮定がどの程度成立するか。
- DeepEncoderの高圧縮に強く依存しているため、他のVLM encoderでも同じ効果が出るか。

## そのまま聞ける質問

- この論文の主張で一番弱い仮定は？
- 実装に落とすなら最小再現実験は？
- 関連研究として追加で探すべきキーワードは？
---

## 追加で聞く

- Chat prompt: [yin2026-ze-unlimited-ocr-works-a5896527.md](../../chat/2026-08-03/yin2026-ze-unlimited-ocr-works-a5896527.md)
- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。
