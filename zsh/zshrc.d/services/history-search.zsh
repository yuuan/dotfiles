# ----------------------------------------
# コマンド履歴に `peco` を使う
# ----------------------------------------

function _tac() {
	if which tac &> /dev/null; then
		tac
	elif which gtac &> /dev/null; then
		gtac
	else
		tail -r
	fi
}

# `peco` でコマンド履歴を表示する関数
function peco-select-history() {
	BUFFER=$(\history -n 1 | _tac | LANG=ja_JP.UTF-8 peco --query "$LBUFFER")
	CURSOR=$#BUFFER

	if [ -n "${CLEAR_SCREEN_AFTER_SELECTING_HISTORY:-}" ]; then
		zle clear-screen
	fi
}

# コマンド履歴の表示に `peco` を使う
if which peco &> /dev/null; then
	zle -N peco-select-history
	bindkey '^R' peco-select-history
else
	bindkey '^R' history-incremental-search-backward
fi
