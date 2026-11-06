# ----------------------------------------
# Vim のためのエイリアスの設定
# ----------------------------------------

if (( $+commands[nvim] )); then
	alias vim='nvim'
	alias vimdiff='nvim -d'
fi

function virg() {
	vim -p $(rg -l "$@")
}
alias viag='virg'
