#!/bin/bash
# auto-commit.sh — notes/への書き込み後にgit自動コミット
# PostToolUse (Write) フックで非同期実行される

VAULT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# arscontextaバルトのマーカーチェック
if [ ! -f "$VAULT_ROOT/.arscontexta" ]; then
    exit 0
fi

# git設定チェック
GIT_CONFIG=$(grep "^git:" "$VAULT_ROOT/.arscontexta" 2>/dev/null | head -1)
if [[ "$GIT_CONFIG" == *"false"* ]]; then
    exit 0
fi

# 書き込まれたファイルを確認（フック入力は stdin の JSON。tool_input.file_path に入る）
WRITTEN_FILE=$(python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('tool_input', {}).get('file_path', '') or data.get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null)

# notes/またはops/内のファイルのみコミット
if [[ "$WRITTEN_FILE" != *"/notes/"* ]] && [[ "$WRITTEN_FILE" != *"/ops/"* ]] && [[ "$WRITTEN_FILE" != *"/inbox/"* ]]; then
    exit 0
fi

cd "$VAULT_ROOT" || exit 0

# 変更があれば自動コミット
if git diff --quiet && git diff --staged --quiet; then
    exit 0
fi

git add "$WRITTEN_FILE" 2>/dev/null || true
RELATIVE_FILE=$(echo "$WRITTEN_FILE" | sed "s|$VAULT_ROOT/||")
git commit -m "vault: update $RELATIVE_FILE" --no-verify 2>/dev/null || true

exit 0
