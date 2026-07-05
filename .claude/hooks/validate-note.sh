#!/bin/bash
# validate-note.sh — notes/に書かれたファイルをYAML検証
# PostToolUse (Write) フックで実行される

VAULT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# arscontextaバルトのマーカーチェック
if [ ! -f "$VAULT_ROOT/.arscontexta" ]; then
    exit 0
fi

# 書き込まれたファイルパスを取得（フック入力は stdin の JSON。tool_input.file_path に入る）
WRITTEN_FILE=$(python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('tool_input', {}).get('file_path', '') or data.get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null)

# notes/内のmdファイルのみ検証（index.mdとmap.mdは除く）
if [[ "$WRITTEN_FILE" != *"/notes/"* ]] || [[ "$WRITTEN_FILE" != *.md ]]; then
    exit 0
fi

if [[ "$(basename "$WRITTEN_FILE")" == "index.md" ]] || [[ "$(basename "$WRITTEN_FILE")" == *"map.md" ]]; then
    exit 0
fi

# ファイルが存在するかチェック
if [ ! -f "$WRITTEN_FILE" ]; then
    exit 0
fi

# YAMLフロントマターチェック
HAS_FRONTMATTER=$(head -1 "$WRITTEN_FILE" | grep -c "^---")
if [ "$HAS_FRONTMATTER" -eq 0 ]; then
    echo "⚠ 検証警告: $WRITTEN_FILE にYAMLフロントマターがありません"
    exit 0
fi

# descriptionフィールドチェック
HAS_DESCRIPTION=$(grep -c "^description:" "$WRITTEN_FILE" 2>/dev/null)
if [ "$HAS_DESCRIPTION" -eq 0 ]; then
    echo "⚠ 検証警告: $WRITTEN_FILE に 'description:' フィールドがありません（必須）"
fi

# topicsフィールドチェック
HAS_TOPICS=$(grep -c "^topics:" "$WRITTEN_FILE" 2>/dev/null)
if [ "$HAS_TOPICS" -eq 0 ]; then
    echo "⚠ 検証警告: $WRITTEN_FILE に 'topics:' フィールドがありません（必須）"
fi

# descriptionが空でないかチェック
DESCRIPTION=$(grep "^description:" "$WRITTEN_FILE" | head -1 | sed 's/^description: *//')
if [ -z "$DESCRIPTION" ] || [ "$DESCRIPTION" = '""' ]; then
    echo "⚠ 検証警告: $WRITTEN_FILE の 'description:' が空です（タイトルを超えた情報を追加してください）"
fi

exit 0
