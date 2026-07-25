#!/usr/bin/env bash
#
# sync-to-cowork.sh
# 把本 repo 的 SKILL.md 同步到 Cowork（local-agent-mode）實際載入的 earnings-scorecard skill。
#
# 用法：
#   ./sync-to-cowork.sh          # 同步（覆蓋前自動備份 .bak）
#   ./sync-to-cowork.sh --dry    # 只顯示會動哪些檔，不實際覆蓋
#
# 設計重點：Cowork 的路徑帶 session UUID、會變動，所以用 glob 動態尋找，
# 不寫死 UUID。找到幾份就同步幾份。

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/SKILL.md"

# Cowork skills-plugin 根目錄；UUID 子層用 find 動態尋找。
# 路徑含空格（"Application Support"），全程用引號與 -print0，勿改成裸 glob。
PLUGIN_ROOT="$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin"

DRY=0
[[ "${1:-}" == "--dry" ]] && DRY=1

if [[ ! -f "$SRC" ]]; then
  echo "✗ 找不到來源 $SRC" >&2
  exit 1
fi

# 用 find -print0 + mapfile 收集目標，安全處理帶空格的路徑
targets=()
if [[ -d "$PLUGIN_ROOT" ]]; then
  while IFS= read -r -d '' t; do
    targets+=( "$t" )
  done < <(find "$PLUGIN_ROOT" -type f -path "*/skills/earnings-scorecard/SKILL.md" -print0 2>/dev/null)
fi

if (( ${#targets[@]} == 0 )); then
  echo "✗ 沒找到 Cowork 的 earnings-scorecard skill。" >&2
  echo "  可能 Cowork 尚未安裝此 skill，或路徑結構已變。手動確認：" >&2
  echo "  ls \"$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin/\"" >&2
  exit 2
fi

echo "來源：$SRC"
echo "找到 ${#targets[@]} 份 Cowork 目標："
stamp="$(date +%Y%m%d-%H%M%S)"
for t in "${targets[@]}"; do
  if cmp -s "$SRC" "$t"; then
    echo "  = 已一致，略過：$t"
    continue
  fi
  if (( DRY )); then
    echo "  ~ 會覆蓋（--dry 未執行）：$t"
  else
    cp "$t" "$t.bak-$stamp"        # 覆蓋前備份
    cp "$SRC" "$t"
    echo "  ✓ 已同步（原檔備份為 $(basename "$t").bak-$stamp）：$t"
  fi
done

(( DRY )) && echo "（--dry 模式，未實際覆蓋）"
echo "完成。"
