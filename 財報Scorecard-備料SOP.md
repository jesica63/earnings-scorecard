# 財報 Scorecard 備料 SOP

> 一頁流程：財報週怎麼備料最省 token、最準。核心原則——**能用官方文件解決的，永遠別用 web_search 拼。**

---

## 為什麼分工

「備料難齊全」不是備料機的錯，是**新聞稿的天花板**：8-K／6-K earnings release 本來就只給損益摘要＋guidance，資產負債表和現金流表要等法說 slides／10-Q。所以不同數字有不同的最省來源，別叫任何一個工具去做它拿不到的事。

Token 成本直覺：一份法說 slides PDF 讀進 context 約 8–15k token、全是有效數字；同一批數字全靠 web_search 拼要 50–100k+ token、還夾雜口徑錯誤。**文件路徑便宜 5–10 倍且更準。**

---

## 三方分工表

| 資料 | 來源 | 誰負責 |
|---|---|---|
| 營收、毛利率、EPS、下季 guidance、**觸發通知** | SEC 8-K／6-K 新聞稿 | **備料機**（自動，維持現狀，不用改） |
| 現金流表、資產負債表、法說定性（節點/封裝） | 公司 IR 法說會 slides PDF | **手動下載丟資料夾**（財報週的 30 秒動作） |
| Consensus、Peer 當季、Regime、N2／CoWoS 問答 | 即時查詢 | **web_search**（scorecard 執行時自動跑） |

> 備料機的不可取代價值：它是**觸發器＋巡檢**——財報一出自動抽、寄信提醒你。web_search 給不了（你得先知道開獎了才會去查）。

---

## 財報週操作步驟

1. **收到備料信**（xiaojhermes 寄來的「【財報備料】…數字表」）→ 財報出爐訊號。
2. **去公司 IR 頁抓法說 slides PDF**（含 Statements of Cash Flows、Balance Sheets），丟進
   `/Users/jesicalin/skills/美股財報檢核SKILL/`
   - 找不到 slides 時，退而求其次抓 10-Q／6-K exhibit 全文（EDGAR 連結在備料信底部）。
3. **跟小J說「跑 XXX scorecard」** → 派 subagent，用「備料信＋法說 slides」當一手底，只 web_search 補下面四類。
4. **⚠️未取得欄位**：報告會標出來。分兩種——
   - *還沒公布*（如 peer 財報）→ 記日期，公布後回補。
   - *要更精確*（如 R&D 絕對值、D&A 實際值）→ 需要時再補，平時用估算＋敏感度頂著。

---

## web_search 只查這四類（其餘一律走文件）

1. **Consensus**：分析師營收／EPS 預估，算 beat 幅度。無可靠免費源就標「留白」，不編。
2. **Peer 當季**：半導體=三星晶圓代工／Intel Foundry；平台=各自對手。做 Peer Delta。
3. **Regime**：Fed 最新利率決議＋VIX，決定五層加權。可由 agent 自動判，或你直接指定省一輪。
4. **法說問答定性**：最新節點 ramp／良率、CoWoS/SoIC 產能等——這些只在 transcript／問答裡，沒有單一數字文件。

---

## 反面清單（別做）

- ❌ 不要擴充備料機去硬抽現金流——那是叫便宜模型啃它拿不到的東西，白費工。
- ❌ 不要「全 web_search 一次抓」——最貴、最不可靠，還把整頁雜訊灌進互動 context。
- ❌ 不要只憑備料信就跑完整 scorecard——層三現金流、層五估值會整片留白（如 2026-07 TSM 首次那樣）。

---

## 範本

`TSM-台積電-Q2-2026-財報-Scorecard.md`（2026-07-16）就是照此流程跑出來的 A 級報告：備料信給損益＋guidance、法說 slides 補齊現金流／資產負債、web_search 補 Regime／peer／CoWoS。可當標準參照。

*最後更新：2026-07-17*
