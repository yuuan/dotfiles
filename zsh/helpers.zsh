# ----------------------------------------
# ヘルパー関数
# ----------------------------------------

# 指定したファイルを読み込む
function __helpers::source() {
	local f
	for f in "$@"; do
		[ \( -f "$f" -o -h "$f" \) -a -r "$f" ] && source "$f"
	done
}

# 指定したディレクトリ内の `.zsh` ファイルを読み込む
function __helpers::sources() {
	local d f
	for d in "$@"; do
		if [ -n "$d" -a -d "$d" -a -r "$d" -a -x "$d" ]; then
			for f in $d/*; do
				[[ ${f##*/} = *.zsh ]] && __helpers::source "$f"
			done
		fi
	done
}

function __helpers::contains_path() {
	echo "$PATH" | tr ':' '\n' | grep -Fxq "$1"
}

# PATH の最初にディレクトリを追加
function __helpers::unshift_path() {
	local -a ds
	for d in "$@"; do
		[ -d "$d" ] && ! __helpers::contains_path "$d" && ds=($ds $d)
	done

	path=(
		$ds
		$path
	)
}

# PATH の最後にディレクトリを追加
function __helpers::push_path() {
	local -a ds
	for d in "$@"; do
		[ -d "$d" ] && ! __helpers::contains_path "$d" && ds=($ds $d)
	done

	path=(
		$path
		$ds
	)
}

# 最終行から逆順に出力
function __helpers::tac() {
	if which tac &> /dev/null; then
		tac
	elif which gtac &> /dev/null; then
		gtac
	else
		tail -r
	fi
}

# 指定したコマンドがインストールされているかを表示
function __helpers::need() {
	local -a cmds; cmds=("$@")
	local ret=0

	local width=0
	for cmd in "${cmds[@]}"; do
		(( ${#cmd} > width )) && width=${#cmd}
	done

	for cmd in ${cmds[@]}; do
		printf "%-${width}s | " "$cmd"
		if ! command -v "$cmd"; then
			printf "\e[31m%s\e[m\n" "not installed"
			ret=1
		fi
	done

	return $ret
}
