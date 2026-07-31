#!/usr/bin/env bash
#
# sync-to-cowork.sh
# 把本 repo 的完整 skill 目錄（SKILL.md ＋ 四個子模組 ＋ 備料 SOP）同步到
# Cowork（local-agent-mode）實際載入的 earnings-scorecard skill 目錄。
#
# 用法：
#   ./sync-to-cowork.sh          # 同步（覆蓋前自動備份 .bak-時間戳）
#   ./sync-to-cowork.sh --dry    # 只顯示會動哪些檔，不實際覆蓋
#
# 設計重點：Cowork 的路徑帶 session UUID、會變動，所以用 find -print0 動態尋找
# skill 目錄本身，不寫死 UUID。找到幾個目錄就同步幾份；目錄內逐檔獨立比對、
# 獨立備份、獨立複製。

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 要同步的檔案：SKILL.md ＋ 五個子模組 ＋ 備料 SOP
# （更新：2026-07-31，新增 optical-networking.md；新增子模組時務必同步補進本清單，
#   否則 Cowork 端的路由表會指向不存在的檔案）
FILES=(
  "SKILL.md"
  "semiconductor.md"
  "platform.md"
  "software.md"
  "consumer-tech.md"
  "optical-networking.md"
  "財報Scorecard-備料SOP.md"
)

# Cowork skills-plugin 根目錄；UUID 子層用 find 動態尋找。
# 路徑含空格（"Application Support"），全程用引號與 -print0，勿改成裸 glob。
PLUGIN_ROOT="$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin"

DRY=0
case "${1:-}" in
  "")     DRY=0 ;;
  --dry)  DRY=1 ;;
  *)
    # 打錯參數（--dryrun、-dry、--dry-run…）不可靜默進入實際覆蓋模式
    echo "✗ 未知參數：$1" >&2
    echo "  用法：$(basename "$0") [--dry]" >&2
    exit 64
    ;;
esac

for f in "${FILES[@]}"; do
  if [[ ! -f "$REPO_DIR/$f" ]]; then
    echo "✗ 找不到來源 $REPO_DIR/$f" >&2
    exit 1
  fi
done

# 用 find -print0 收集目標「目錄」，安全處理帶空格的路徑
target_dirs=()
if [[ -d "$PLUGIN_ROOT" ]]; then
  while IFS= read -r -d '' d; do
    target_dirs+=( "$d" )
  done < <(find "$PLUGIN_ROOT" -type d -path "*/skills/earnings-scorecard" -print0 2>/dev/null)
fi

if (( ${#target_dirs[@]} == 0 )); then
  echo "✗ 沒找到 Cowork 的 earnings-scorecard skill 目錄。" >&2
  echo "  可能 Cowork 尚未安裝此 skill，或路徑結構已變。手動確認：" >&2
  echo "  ls \"$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin/\"" >&2
  exit 2
fi

echo "來源目錄：$REPO_DIR"
echo "找到 ${#target_dirs[@]} 個 Cowork 目標目錄："
stamp="$(date +%Y%m%d-%H%M%S)"

for d in "${target_dirs[@]}"; do
  echo "  目錄：$d"
  for f in "${FILES[@]}"; do
    src="$REPO_DIR/$f"
    tgt="$d/$f"

    if [[ ! -f "$tgt" ]]; then
      if (( DRY )); then
        echo "    + 會新增（--dry 未執行）：$tgt"
      else
        cp "$src" "$tgt"
        echo "    ✓ 已新增：$tgt"
      fi
      continue
    fi

    if cmp -s "$src" "$tgt"; then
      echo "    = 已一致，略過：$tgt"
      continue
    fi

    if (( DRY )); then
      echo "    ~ 會覆蓋（--dry 未執行）：$tgt"
    else
      cp "$tgt" "$tgt.bak-$stamp"   # 覆蓋前備份
      cp "$src" "$tgt"
      echo "    ✓ 已同步（原檔備份為 $(basename "$tgt").bak-$stamp）：$tgt"
    fi
  done
done

(( DRY )) && echo "（--dry 模式，未實際覆蓋）"
echo "完成。"
