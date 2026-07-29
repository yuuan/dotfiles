#!/bin/zsh

INPUT=$(cat)

LOG_DIR="$HOME/.claude/history"
LOG_FILE="$LOG_DIR/tools.jsonl"
mkdir -p "$LOG_DIR"

# jq の -R オプションで生の文字列として読み込み、fromjson で JSON にパース
# これにより制御文字のエラーを回避
echo "$INPUT" | jq -R 'fromjson // {}' | jq -c \
	--arg at "$(date +%Y-%m-%dT%H:%M:%S%z)" \
	'{
		at: $at,
		session_id: .session_id,
		transcript_path: .transcript_path,
		cwd: .cwd,
		tool_name: .tool_name,
		tool_input: .tool_input
	}' \
	>> $LOG_FILE
