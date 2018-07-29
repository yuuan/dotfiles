# ----------------------------------------
# 履歴に関する関数
# ----------------------------------------

# 全ての履歴を表示する
function history-all {
	history -i 1
}

# よく使うコマンドをランキング表示
function history-best {
	history 1 | sed -E 's/^[ ]*//g' | sed -E 's/ +/ /g' | cut -d' ' -f2 | sort | uniq -c | sort -nr | head -n ${1:-20} | nl -w 2
}

# `peco` でコマンド履歴を表示する関数
function history-peco {
	BUFFER=$(\history -n 1 | __zshrc::tac | LANG=ja_JP.UTF-8 peco --query "$LBUFFER")
	CURSOR=$#BUFFER

	if [ -n "${CLEAR_SCREEN_AFTER_SELECTING_HISTORY:-}" ]; then
		zle clear-screen
	fi
}

# Widget を登録
zle -N history-peco

# `b4b4r07/history` がインストールされているか
function history-is-installed {
	which history &> /dev/null
}

# Ctrl-R で履歴を表示
if ! history-is-installed; then
	if which peco &> /dev/null; then
		# 履歴の表示に `peco` を使う
		bindkey '^R' history-peco
	else
		# ZSH が持つインクリメンタルサーチ
		bindkey '^R' history-incremental-search-backward
	fi
fi

# `b4b4r07/history` のエイリアス
alias history-b4b4r07="command history"
alias hist="command history"
