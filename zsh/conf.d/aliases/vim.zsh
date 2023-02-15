# ----------------------------------------
# Vim のためのエイリアスの設定
# ----------------------------------------

if which nvim &> /dev/null; then
	alias vim='nvim'
	alias vimdiff='nvim -d'
fi

function viag() {
	vim -p $(ag -l "$@")
}
