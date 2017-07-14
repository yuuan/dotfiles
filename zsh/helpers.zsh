# 指定したファイルを読み込む
__source() {
	local f
	for f in "$@"; do
		[ \( -f "$f" -o -h "$f" \) -a -r "$f" ] && source "$f"
	done
}

# 指定したディレクトリ内の `.zsh` ファイルを読み込む
__sources() {
	local d f
	for d in "$@"; do
		if [ -n "$d" -a -d "$d" -a -r "$d" -a -x "$d" ]; then
			for f in $d/*; do
				[[ ${f##*/} = *.zsh ]] && __source "$f"
			done
		fi
	done
}

# 文字列をシェルコマンドの引数に与えても安全なようにエスケープする
sh-escape() {
	local s a=() q="'" qq='"'
	for s in "$@"; do
		a+=("'${s//$q/$q$qq$q$qq$q}'")
	done
	echo "${a[*]}"
}
