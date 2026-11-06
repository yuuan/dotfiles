# ----------------------------------------
# Vim のためのエイリアスの設定
# ----------------------------------------

if (( $+commands[nvim] )); then
	alias vim='nvim'
	alias vimdiff='nvim -d'
fi

# 検索にヒットしたファイルを vim のタブで開く
function virg() {
	local -a files
	files=(${(0)"$(rg -l0 "$@")"})
	(( ${#files} )) || return 1
	vim -p -- "${files[@]}"
}
alias viag='virg'
