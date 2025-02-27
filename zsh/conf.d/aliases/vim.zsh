# ----------------------------------------
# Vim のためのエイリアスの設定
# ----------------------------------------

if (( $+commands[nvim] )); then
	alias vim='nvim'
	alias vimdiff='nvim -d'
fi

function viag() {
	vim -p $(ag -l "$@")
}
