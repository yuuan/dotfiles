#!/bin/sh
#
# Claude Code が走らせた Bash ツールの入力を JSONL に落とす。
# WSL2 / macOS / Windows (Git Bash) のどれでも同じものが動くよう POSIX sh で書く。

# jq が無いマシンではログを諦める (notify.sh と同じく機能単位で degrade させる)
command -v jq > /dev/null 2>&1 || exit 0

INPUT=$(cat)

LOG_DIR="$HOME/.claude/history"
LOG_FILE="$LOG_DIR/tools.jsonl"
mkdir -p "$LOG_DIR"

# jq の -R オプションで生の文字列として読み込み、fromjson で JSON にパース
# これにより制御文字のエラーを回避
# (echo だとバックスラッシュを解釈する sh があるので printf で流す)
printf '%s\n' "$INPUT" | jq -R 'fromjson // {}' | jq -c \
	--arg at "$(date +%Y-%m-%dT%H:%M:%S%z)" \
	'{
		at: $at,
		session_id: .session_id,
		transcript_path: .transcript_path,
		cwd: .cwd,
		tool_name: .tool_name,
		tool_input: .tool_input
	}' \
	>> "$LOG_FILE"
