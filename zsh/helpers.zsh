# ----------------------------------------
# ヘルパー関数
# ----------------------------------------

# 指定したファイルを読み込む
function __zshrc::source() {
	local f
	for f in "$@"; do
		[ \( -f "$f" -o -h "$f" \) -a -r "$f" ] && source "$f"
	done
}

# 指定したディレクトリ内の `.zsh` ファイルを読み込む
function __zshrc::sources() {
	local d f
	for d in "$@"; do
		if [ -n "$d" -a -d "$d" -a -r "$d" -a -x "$d" ]; then
			for f in $d/*; do
				[[ ${f##*/} = *.zsh ]] && __zshrc::source "$f"
			done
		fi
	done
}

# 最終行から逆順に出力
function __zshrc::tac() {
	if which tac &> /dev/null; then
		tac
	elif which gtac &> /dev/null; then
		gtac
	else
		tail -r
	fi
}
