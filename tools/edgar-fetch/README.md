1|# EDGAR 財報原文抓取工具（配套 earnings-scorecard 使用）
2|
3|這裡是搭配 `SKILL.md` 第零步「資料盤點與等級判定」使用的輔助工具，
4|用 [`edgartools`](https://github.com/dgunning/edgartools) 套件直接讀取 SEC EDGAR 的 XBRL 結構化財報資料，
5|取代手動複製貼上財報數字，也比 web_search 二手轉載的網頁數字更準確（可達 A 級報告標準）。
6|
7|## 為什麼需要這個
8|
9|Scorecard 系統的硬性規則是「關鍵比率一律自行計算，不接受媒體報導的百分比」。
10|`edgartools` 能直接把 10-Q / 10-K 的資產負債表、損益表、現金流量表讀成結構化物件，
11|且能用 `grep()` 在全文（含 HTML／JSON／XML 各版本）搜出藏在附注裡、沒進標準三表的揭露
12|（例如客戶集中度、股數變化、可轉債條款等）。
13|
14|## 安裝
15|
16|```bash
17|python3 -m venv edgar-venv
18|source edgar-venv/bin/activate
19|pip install edgartools
20|```
21|
22|## 使用前必讀：SEC 身分識別
23|
24|SEC EDGAR 要求所有自動化存取都要附上**真實可聯絡的身分**（User-Agent），
25|不可留空或用假資料，否則會被 SEC 封鎖 IP。
26|
27|執行前先設定環境變數（不要把個人信箱寫死進程式碼裡，尤其是公開 repo）：
28|
29|```bash
30|export SEC_EDGAR_IDENTITY="你的名字 你的信箱@example.com"
31|```
32|
33|兩支腳本都會從這個環境變數讀取身分，沒設定會直接報錯提醒。
34|
35|## 腳本
36|
37|### `fetch_filing.py` — 抓三張表
38|
39|```bash
40|python fetch_filing.py AAOI --form 10-Q --index 0
41|```
42|
43|- `TICKER`：股票代號（如 `AAOI`、`NVDA`、`AMD`）
44|- `--form`：`10-Q` 或 `10-K`（預設 `10-Q`）
45|- `--index`：第幾份最新申報，`0`＝最新一份，`1`＝上一份（可做 QoQ／YoY 比較），依此類推
46|
47|輸出：該份申報的資產負債表、損益表、現金流量表（結構化文字表格）。
48|
49|### `grep_filing.py` — 全文搜尋揭露性條款
50|
51|```bash
52|python grep_filing.py AAOI "top ten customers" --form 10-Q --index 0
53|```
54|
55|用於搜尋不在標準三表裡、藏在附注中的揭露，例如：
56|- 客戶集中度（如 `"top ten customers"`、特定客戶名稱）
57|- 股數變化（如 `"shares outstanding"`）
58|- 可轉債條款、認股權證等特殊約定
59|
60|## 執行順序建議（配合 SKILL.md 第零步）
61|
62|1. 先用 `fetch_filing.py` 抓當季三表原文數字。
63|2. 若懷疑有集中度、稀釋等風險條款藏在附注，用 `grep_filing.py` 關鍵字搜尋。
64|3. 原文抓完才進 `web_search` 補「原文沒有」的部分：Peer 當季數字、Regime 判定（Fed 利率／VIX）、
65|   當日股價與市值、市場共識 EPS。
66|4. 這個順序能讓報告盡量往 A 級靠，而不是每次都仰賴 web_search 拼湊二手數字。
67|
