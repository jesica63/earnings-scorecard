# earnings-scorecard — 美股財報檢核 Scorecard 系統

這個 repo 是 `earnings-scorecard` skill 的**唯一真本（canonical source）**。
`SKILL.md` 是完整、自足的單檔 skill，支援美股＋台股財報檢核。

## 為什麼有這個 repo（背景）

2026-07 以前，這個 skill 散在三個地方且已互相漂移：

| 位置 | 形態 | 狀態 |
|------|------|------|
| `~/skills/美股財報檢核SKILL/`（Obsidian vault） | 子模組式、缺 SKILL.md | 舊架構，已封存到該資料夾的 `archive/legacy-skill/` |
| `~/.codex/skills/earnings-scorecard/` | 子模組式 | 最舊（2026-05），未使用（沒在用 Codex） |
| Cowork（local-agent-mode）skills-plugin | 22KB 單檔 | 實際被載入、最新（2026-06-13） |

結果是：在 vault 改門檻，但實際載入的是 Cowork 那份，改了沒生效。
本 repo 以 **Cowork 6/13 單檔版**為基準建立，終結漂移。

## 更新流程（務必照這個走）

```bash
cd ~/skills/earnings-scorecard
# 1. 改 SKILL.md（門檻、Peer 配對、Regime 加權等）
# 2. 版控
git add SKILL.md && git commit -m "說明改了什麼" && git push
# 3. 同步到 Cowork 實際載入的位置
./sync-to-cowork.sh          # 覆蓋前自動備份；--dry 可先預覽
```

## 不要做的事

- ❌ 不要在 `~/skills/美股財報檢核SKILL/` 改 skill——那裡已經沒有 skill 檔，只是資料/封存夾。
- ❌ 不要直接編輯 Cowork 的 Library 路徑——它由 Cowork 管、會被覆蓋。改這裡、用腳本同步過去。

## sync-to-cowork.sh

用 `find -print0` 動態尋找 Cowork 的 skill 路徑（不寫死 session UUID，Cowork 重生路徑也找得到），
覆蓋前備份 `.bak-時間戳`，內容一致則略過。找不到目標會明確報錯。

---
*Repo: jesica63/earnings-scorecard（private）。最後更新：2026-07-25*
