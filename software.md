# 子模組：軟體（Software）
適用公司：Microsoft

---

## 產業核心假設

Microsoft 是**訂閱制軟體 + 雲端基礎建設**的雙引擎結構。
- 短期波動來源：Azure 成長率季度波動、PC 景氣、企業 IT 預算
- 長期成長來源：AI Copilot 變現滲透、Azure OpenAI 服務擴張、混合雲黏著度

Scorecard 的任務：判斷「Azure 的成長是在加速還是趨緩，以及 AI 是否真的在轉化為可計量的收入」。

---

## Peer 配對規則

| 指標 | Peer | 說明 |
|---|---|---|
| Azure YoY | AWS（Amazon）、Google Cloud | 三大雲端成長率對比，判斷份額動向 |
| 商業雲端整體 YoY | AWS、Google Cloud | Microsoft 定義的商業雲端含 Azure + Office 365 商業版 + Dynamics |
| 營業利益率 | Google（Alphabet 整體）| 同為多業務科技巨頭，利益率結構可比 |

**執行前必須 web_search 取得當季 AWS、Google Cloud 實際財報數字。**

---

## 層一｜成長與規模

| 指標 | 說明 | PASS | WARN | FAIL | Peer Delta |
|---|---|---|---|---|---|
| Azure YoY（CC） | 最核心指標 | ≥ 33% | 28–32% | < 28% | vs. AWS YoY、Google Cloud YoY |
| 商業雲端整體 YoY | Azure + O365 商業 + Dynamics | ≥ 20% | 16–19% | < 16% | — |
| Copilot / AI 相關收入揭露 | AI 變現進度 | 有量化數字（ARR 或用戶數）| 僅定性描述 | 無揭露 | — |
| Productivity & Business（含 O365）YoY | 訂閱黏著度 | ≥ 12% | 8–11% | < 8% | — |
| More Personal Computing（含 Windows / Xbox）YoY | 週期性，非核心 | ≥ 0% | -5–0% | < -5% | — |
| 總營收 YoY | — | ≥ 14% | 10–13% | < 10% | — |

> **Azure 特別注意：** Microsoft 不揭露 Azure 絕對金額，只揭露 YoY 成長率（CC）。法說會提到的 AI 服務對 Azure 成長的貢獻 pp 數，是非常重要的前瞻指標，需逐字記錄。

---

## 層二｜獲利能力

| 指標 | PASS | WARN | FAIL | 說明 |
|---|---|---|---|---|
| 整體營業利益率 | ≥ 43% | 40–42% | < 40% | Microsoft 歷史利益率持續擴張中 |
| Intelligent Cloud 營業利益率 | ≥ 42% | 38–41% | < 38% | Azure 是利益率最高的部門 |
| Non-GAAP EPS vs. consensus | ≥ +3% | +1–2% | 低於 consensus | Microsoft 指引通常保守，Beat 為常態 |
| 費用 YoY ≤ 營收 YoY | 費用增速 ≤ 營收增速 | 費用增速超出 1–3pp | 費用增速超出 > 3pp | 營運槓桿是否持續兌現 |
| Copilot 相關 Capex ROI 說明 | 法說會有明確時程或量化指標 | 只有定性說明 | 完全未提及 | AI Capex 需要看到回報敘事 |

### 調整後潛在營業利益率（白話估值法）

> 還原 GAAP 費用化扭曲後的「真實盈利能力」。公式見 SKILL.md 第二點五步。

**Microsoft 維持性水準參考基準：**

| 費用項目 | 維持性佔比 | 說明 |
|---|---|---|
| R&D | 12% | 企業軟體成熟後的維持性研發水準；目前 Microsoft R&D 約 13–15%，超額部分反映 AI / 雲端投資 |
| S&M | 10% | 訂閱制軟體的維持性銷售費用；當前約 14–16%，超額部分屬 Azure 市場擴張與 Copilot 推廣 |

**執行步驟：**

```
① 從財報讀取本期 R&D% 與 S&M%（佔營收比）
② 超額 R&D = (本期 R&D% − 12%) × 本期營收
③ 超額 S&M = (本期 S&M% − 10%) × 本期營收
④ 調整後潛在營業利益率 = (GAAP 營業利益 + 超額 R&D + 超額 S&M + SBC) ÷ 營收
⑤ 遠期 PE = 現股價 ÷ (3 年後預估營收 × 調整後潛在利益率 × (1 − 稅率) ÷ 預估股數)
```

**Microsoft 特別說明：** Microsoft 本身 GAAP 利益率已達 40%+ 的高水準，調整後潛在利益率通常在 50–55% 左右。若遠期 PE（調整後）落在 25–30x，而 GAAP PE 看起來高達 35–40x，差距即反映市場對其 AI 投資成本的「誤讀折扣」。

---

## 層三｜現金流與品質

| 指標 | PASS | WARN | FAIL | 說明 |
|---|---|---|---|---|
| FCF Margin | ≥ 30% | 25–29% | < 25% | 訂閱制模式應維持高 FCF Margin |
| CFO / GAAP 淨利 | ≥ 1.1x | 0.9–1.0x | < 0.9x | TATA 品質 |
| SBC / Revenue | ≤ 6% | 7–8% | > 8% | — |
| CapEx / Revenue | ≤ 18% | 19–22% | > 22% | AI 基礎建設投資使 Capex 上升，需同時追蹤 Azure 加速作為 ROI 佐證 |
| Remaining Performance Obligation（RPO）YoY | ≥ 20% | 15–19% | < 15% | 未來收入能見度，訂閱制最重要的前瞻指標 |

> **RPO（剩餘履約義務）說明：** RPO 是客戶已承諾但尚未認列的合約金額，YoY 成長代表未來收入有支撐。Microsoft 每季揭露，是判斷 Azure 訂單動能的重要先行指標。

---

## 層四｜風險監控（軟體專用）

| 風險項目 | PASS | FAIL | 說明 |
|---|---|---|---|
| Azure 成長加速 vs. 趨緩 | CC YoY 維持或加速 | 連續兩季減速且低於 AWS YoY | 最關鍵風險，減速代表雲端份額流失 |
| AI Capex 持續擴大 | Capex ≤ Revenue 18% 或有明確 ROI 佐證 | Capex > 22% 且無 ROI 路徑說明 | 市場對過度 Capex 的容忍度有限 |
| OpenAI 依賴風險 | OpenAI 合作關係穩定，無重大條款變化 | OpenAI 與 Microsoft 關係生變或 OpenAI 轉向其他雲端 | 結構性依賴風險 |
| 企業 IT 預算 | 法說會無客戶縮減支出描述 | 多個大客戶縮減或延遲 Azure 合約 | 宏觀壓力的領先指標 |
| 監管 / 反壟斷 | 無新增重大調查 | 歐盟或美國開啟新的捆綁銷售調查 | Teams + Office 捆綁已有前例 |

---

## 層五｜估值定價

### EV/EBITDA 錨點

| 情境 | Forward EV/Adj. EBITDA | 說明 |
|---|---|---|
| 歷史中位數 | ~22x | 含 AI 成長溢價後中位數上移 |
| Bear | 17–19x | Azure 趨緩 + Capex 過重 |
| Base | 21–24x | Azure 維持 30%+ + Copilot 漸進變現 |
| Bull | 26–32x | Azure 加速至 35%+ + Copilot ARR 明確揭露 |

### Re-rating 觸發條件

| 觸發條件 | 預期估值反應 |
|---|---|
| Azure CC YoY 重新加速至 35%+ | EV/EBITDA 從 22x 推向 26x+ |
| Copilot 相關收入首次揭露具體 ARR（如 $5B+）| 成長敘事強化，推動 Bull 倍數 |
| RPO YoY 加速至 25%+ | 未來收入能見度提升，估值折現率下降 |

---

## 三秒判斷法（Microsoft）

財報出來，先問三句：

1. Azure CC YoY 有沒有 ≥ 33%？有沒有比上季加速或持平？
2. 營業利益率有沒有 ≥ 43%？費用成長有沒有低於營收成長？
3. 法說會有沒有提到 AI 服務對 Azure 貢獻的具體 pp 數？Copilot 有沒有新的量化揭露？

**判讀：**
- 三句全 YES → EV/EBITDA 往 24–26x 修復
- Azure 達標但 Copilot 無量化 → Base 維持，等下季
- Azure 趨緩 → Bear，估值下壓至 18–20x
