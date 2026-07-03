# ------------------------------------------------------------
# SSH 切断時にマウス操作が文字で表示されるのをリセット
# ------------------------------------------------------------

# マウストラッキングモードの無効化
function unmouse() {
	if [[ $# -gt 0 ]]; then
		echo "unmouse: disable terminal mouse tracking (recover from broken state after SSH disconnect)"
		return 0
	fi
	printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1015l'
}

# Alternate screen モードから抜ける
function unalt() {
	if [[ $# -gt 0 ]]; then
		echo "unalt: exit alternate screen mode (return to main screen)"
		return 0
	fi
	tput rmcup
}

# WezTerm のペインの内容をファイルに保存
function wezterm-capture-pane() {
	if [[ -z $WEZTERM_PANE ]] || (( ! $+commands[wezterm] )); then
		return 1
	fi

	local dir="${XDG_STATE_HOME:-$HOME/.local/state}/wezterm/snapshots"
	mkdir -p "$dir"
	local f="$dir/terminal-$(date +%Y%m%d-%H%M%S)-${(l:5::0:)RANDOM}.log"
	wezterm cli get-text --start-line -100000 > "$f"

	echo "captured: $f ($(wc -l < "$f") lines)"
}

function capture-and-reset() {
	unmouse
	wezterm-capture-pane
	reset
}
