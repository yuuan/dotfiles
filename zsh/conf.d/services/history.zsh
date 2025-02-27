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
