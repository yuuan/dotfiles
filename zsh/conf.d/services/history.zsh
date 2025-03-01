# ----------------------------------------
# 履歴に関する設定
# ----------------------------------------

# `fzf-tmux` でコマンド履歴を表示する関数
function __services::history::select {
	BUFFER=$(\history -n 1 | fzf-tmux -- --prompt "command>" --tac --query "${LBUFFER}")
	CURSOR=${#BUFFER}
}

# Widget を登録
zle -N __services::history::select

# Atuin がインストールされているか
function __services::history::is_installed {
	(( $+commands[atuin] ))
}

# コマンドを実行しその履歴を Autin に保存
function __services::history::eval {
	local CMD=$1

	if [[ -z $CMD ]]; then
		return 127
	fi

	local ATUIN_HISTORY_ID EXIT DURATION END_TIME
	local START_TIME=${EPOCHREALTIME-}

	if __services::history::is_installed; then
		ATUIN_HISTORY_ID=$(atuin history start -- "$CMD")
		START_TIME=${EPOCHREALTIME-}
	fi

	eval "$CMD"

	EXIT=$?

	if __services::history::is_installed; then
		END_TIME=${EPOCHREALTIME-}
		if [[ -n $START_TIME && -n $END_TIME ]]; then
			printf -v DURATION %.0f $(((END_TIME - START_TIME) * 1000000000))
		fi

		(ATUIN_LOG=error atuin history end --exit $EXIT ${DURATION:+--duration=$DURATION} -- $ATUIN_HISTORY_ID &) >/dev/null 2>&1
	fi

	return $EXIT
}

# Ctrl-R で履歴を表示
if ! __services::history::is_installed; then
	if (( $+commands[fzf-tmux] )); then
		# Zsh の `history` に `fzf` を組み合わせて使う
		bindkey '^R' __services::history::select
	else
		# ZSH が持つインクリメンタルサーチ
		bindkey '^R' history-incremental-search-backward
	fi
fi
