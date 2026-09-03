# earnings-scorecard — 美股財報檢核 Scorecard 系統

這個 repo 是 `earnings-scorecard` skill 的**唯一真本（canonical source）**。
**載入依賴：** `SKILL.md`（框架與路由邏輯）＋ 五個產業子模組（`semiconductor.md`、
`platform.md`、`software.md`、`consumer-tech.md`、`optical-networking.md`），同層相對路徑引用，**缺一不可，並非單檔自足**。
`SKILL.md` 第一步的公司識別路由表與文末 Note 都會依公司類別載入對應子模組。
（更新：2026-07-31，新增光通訊子模組 `optical-networking.md`，適用 AAOI；行號改為不寫死，避免每次改檔就過時）

**附帶文件：** `財報Scorecard-備料SOP.md` 是人工備料的作業流程，`SKILL.md` 並未引用它，
不屬載入依賴，但同步過去方便查閱。

## 為什麼有這個 repo（背景）

2026-07 以前，這個 skill 散在三個地方且已互相漂移：

| 位置 | 形態 | 狀態 |
|------|------|------|
| `~/Documents/skills/美股財報檢核SKILL/archive/legacy-skill/`（Obsidian vault） | 子模組式（無 SKILL.md） | 四個子模組與備料 SOP 的**來源**；`platform.md`、`software.md` 是最新版（mtime 2026-06-12），較 codex 版（2026-05-15）多出「調整後潛在營業利益率（白話估值法）」一段，含各公司維持性 R&D／S&M 參數，本 repo 已採用 |
| `~/.codex/skills/earnings-scorecard/` | 子模組式 | 較舊（2026-05），未使用（沒在用 Codex） |
| Cowork（local-agent-mode）skills-plugin | 帳號端 user skill 的本機投影 | 實際被載入。2026-07-30 前只有 SKILL.md，導致找不到 `software.md` 等子模組；同日帳號端換為多檔版後已補齊五個檔 |

結果是：在 vault 改門檻，但實際載入的是 Cowork 那份，改了沒生效；且 Cowork
那份長期缺子模組，同一份財報在不同來源下算出不同參數。
本 repo 以 **Cowork 6/13 SKILL.md 版 ＋ legacy 目錄的四個子模組與備料 SOP**
為基準補齊，終結漂移與缺檔問題。

## 更新流程（務必照這個走）

```bash
cd ~/skills/earnings-scorecard
# 1. 改 SKILL.md 或任一子模組（門檻、Peer 配對、Regime 加權等）
# 2. 版控
git add SKILL.md software.md ...（依實際改動的檔案）
git commit -m "說明改了什麼" && git push
```

**3. 讓改動生效——優先走帳號端換版，不是跑腳本。**

實際載入的 skill 是**帳號端（Claude 帳號）的 user skill**，Cowork 那個帶 session UUID 的目錄
只是它的本機投影，會被自動重建，直接在那裡改檔會被沖掉。

2026-07-30 起帳號端已改為**多檔版本**（SKILL.md ＋ 子模組），流程：

1. 開 `https://claude.ai/customize/skills`
2. 找 `earnings-scorecard`
3. ⋮ → **Replace**，上傳含 `earnings-scorecard/` 資料夾的 zip（SKILL.md ＋ 五個子模組）
4. 驗證：`ls "$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin"/*/*/skills/earnings-scorecard/`
   應看到 6 個 `.md`（SKILL.md ＋ 五個子模組）

> ⚠️ 實測（2026-07-30）：換版後 **skillId 會變**（`skill_0182eSWa5Qs1j4bmUsbgNjB6` → `skill_01JmvMBrmpuKaT3Fs5hbXCAA`），
> 但 `name` 與 `enabled` 保留、manifest 無重複條目、呼叫名 `anthropic-skills:earnings-scorecard` 不受影響。
> **驗證換版成功要看 name 與檔案清單，不要看 skillId。**

**`./sync-to-cowork.sh` 現已降為備援**，只在下列情況用：帳號端還沒換版、或要臨時覆蓋本機投影做測試。
帳號端既已自帶子模組，正常維護不需要跑它（跑了會對既有檔案回報「已一致，略過」）。

## 不要做的事

- ❌ 不要在 `~/Documents/skills/美股財報檢核SKILL/archive/legacy-skill/` 改 skill——那裡是唯讀來源，改了不會同步回本 repo，只會製造新的漂移。
- ❌ 不要直接編輯 Cowork 的 Library 路徑——它由 Cowork 管、會被覆蓋。改這裡、用腳本同步過去。
- ❌ 不要只同步 SKILL.md 而漏掉子模組——舊版腳本這樣做過，導致 Cowork 端找不到 `software.md`。

## sync-to-cowork.sh

用 `find -print0` 動態尋找 Cowork 的 skill **目錄**（不寫死 session UUID，Cowork
重生路徑也找得到），對目錄內 SKILL.md ＋ 五個子模組 ＋ 備料 SOP 逐檔獨立比對、
獨立備份（`.bak-時間戳`）、獨立複製；內容一致則略過。找不到目標會明確報錯。

## 待處理：兩個估值錨點需重校

2026-07-30 實跑 MSFT FY26 Q4 時發現的落差，尚未校正，先記錄：

- `software.md` 層五的 EV/Adj. EBITDA 歷史中位數寫 **22x**，Bear 情境 17–19x。
- `software.md` 白話估值法段的 Microsoft 特別說明寫「遠期 PE（調整後）落在
  **25–30x**」屬市場對 AI 投資成本的誤讀折扣。
- 實跑結果：以 2026-07-29 收盤價 390.54 計算，forward EV/Adj. EBITDA 為
  **12.1x**、遠期 PE 為 **14.2x**——約為兩個錨點的一半。
- 兩個獨立錨點（EV/EBITDA 中位數、遠期 PE 區間）同向偏離，研判錨點校準於
  較高估值環境，需人工重校後才能用於推導目標價，暫不可直接引用這兩個數字
  做估值判斷。
- 調整後潛在營業利益率算出 50.52%，落在 software.md 預期的 50–55% 區間內，
  計算方法（公式與參數）本身無誤，問題只在估值錨點過時。

## tools/edgar-fetch/ — SEC EDGAR 原文抓取工具

配合第零步「資料盤點與等級判定」使用，用 `edgartools` 套件直接讀 SEC EDGAR 的 XBRL
結構化財報，取代手動複製貼上或 web_search 拼湊二手數字，能讓報告盡量往 A 級靠。
含 `fetch_filing.py`（抓三張表）與 `grep_filing.py`（全文搜尋客戶集中度、股數變化等
藏在附注的揭露）。使用方式見 `tools/edgar-fetch/README.md`。

**執行順序**：先跑這裡的工具抓原文 → 原文沒有的部分（Peer 數字、Regime 判定、當日股價、
市場共識 EPS）才用 web_search 補。不要跳過這一步直接 web_search。

---
*Repo: jesica63/earnings-scorecard（private）。最後更新：2026-09-03*
