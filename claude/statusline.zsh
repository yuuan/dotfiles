#!/bin/zsh -f
#
# Claude Code のステータス行。stdin からセッション JSON を受け取り、1 行だけ出力する:
#   📁 dir / branch | 🔥 7d 41% / 5h 23% ↻14:30 | 🧠 42% (424K/1M) [Model]
# スキーマ: https://code.claude.com/docs/en/statusline
#
# 描画のたびに起動されるので、起動コストを抑える:
#   - `-f` で rc ファイルを読まない (.zshenv の読み込みだけで 100ms 近くかかる)。
#     jq と git は親から引き継ぐ PATH で見つかる前提
#   - 値の受け渡しはコマンド置換ではなく REPLY を使い、fork を jq と git の 2 回に抑える

zmodload zsh/datetime

# jq が無いマシンではステータス行を諦める (notify.zsh と同じく機能単位で degrade させる)
(( $+commands[jq] )) || exit 0

CYAN=$'\e[36m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
RED=$'\e[31m'
DIM=$'\e[2m'
RESET=$'\e[0m'

# セッション JSON から必要な値を `キー=値` の行として取り出す。
# 値が無い項目は行ごと落とすので、zsh 側では「空文字 = 未設定」として扱える。
# used_percentage は 0 と未設定を区別したいので `//` ではなく null と明示的に比較する。
function __extract() {
	jq -r '
		def blank(d): if . == null or . == "" then d else . end;
		. as $root
		| "dir=" + ($root.workspace.current_dir | blank($root.cwd | blank(".")))
		, "model=" + ($root.model.display_name | blank("Unknown"))
		, "pct=" + (($root.context_window.used_percentage // 0) | floor | tostring)
		, "used=" + (($root.context_window.total_input_tokens // 0) | tostring)
		, "size=" + (($root.context_window.context_window_size // 0) | tostring)
		, (if $root.rate_limits.seven_day.used_percentage != null
			then "seven_pct=" + ($root.rate_limits.seven_day.used_percentage | round | tostring)
			else empty end)
		, (if $root.rate_limits.five_hour.used_percentage != null
			then "five_pct=" + ($root.rate_limits.five_hour.used_percentage | round | tostring)
			else empty end)
		, (if $root.rate_limits.five_hour.resets_at != null
			then "five_resets_at=" + ($root.rate_limits.five_hour.resets_at | tostring)
			else empty end)
	' 2> /dev/null
}

function __percentage() {
	local -i pct="${1:-0}"
	local color

	if (( pct >= 90 )); then
		color="$RED"
	elif (( pct >= 70 )); then
		color="$YELLOW"
	else
		color="$GREEN"
	fi

	REPLY="${color}${pct}%${RESET}"
}

# int() は zsh/mathfunc 依存、printf の %f は偶数丸めで JS の toFixed とズレるため、
# 依存を増やさず丸め方も揃えられる整数演算だけで組む
function __format_tokens() {
	local -i tokens="${1:-0}" tenths

	if (( tokens >= 1000000 )); then
		if (( tokens % 1000000 == 0 )); then
			REPLY="$(( tokens / 1000000 ))M"
		else
			tenths=$(( (tokens * 10 + 500000) / 1000000 ))
			REPLY="$(( tenths / 10 )).$(( tenths % 10 ))M"
		fi
	elif (( tokens >= 1000 )); then
		REPLY="$(( (tokens + 500) / 1000 ))K"
	else
		REPLY="$tokens"
	fi
}

# rate_limits は Claude.ai のサブスクリプション、かつ最初の API 応答以降でのみ現れる。
# 5h / 7d はそれぞれ独立に欠けうるので、無い枠は丸ごと落とす
function __rate_limit() {
	local label="$1" pct="$2" resets_at="$3" at

	REPLY=''
	[[ -n "$pct" ]] || return 0

	__percentage "$pct"
	REPLY="$label $REPLY"

	# resets_at は Unix epoch 秒。ローカルタイムで表示する
	if [[ -n "$resets_at" ]]; then
		strftime -s at '%H:%M' "$resets_at"
		REPLY+=" ${DIM}↻${at}${RESET}"
	fi
}

function __main() {
	local raw
	raw="$(__extract)"

	local -A fields
	local line
	for line in "${(@f)raw}"; do
		[[ -n "$line" ]] && fields[${line%%=*}]="${line#*=}"
	done

	if (( ${#fields} == 0 )); then
		print -r -- "${RED}[statusline error]${RESET} could not read session JSON"
		return 0
	fi

	local dir="${fields[dir]}" branch
	branch="$(git -C "$dir" branch --show-current 2> /dev/null)"

	local location="📁 ${dir:t}"
	[[ -n "$branch" ]] && location+=" / $branch"

	local -a limit_parts
	__rate_limit '7d' "${fields[seven_pct]}" ''
	[[ -n "$REPLY" ]] && limit_parts+=("$REPLY")
	__rate_limit '5h' "${fields[five_pct]}" "${fields[five_resets_at]}"
	[[ -n "$REPLY" ]] && limit_parts+=("$REPLY")

	local tokens='' used size
	if (( ${fields[size]:-0} > 0 )); then
		__format_tokens "${fields[used]:-0}"; used="$REPLY"
		__format_tokens "${fields[size]:-0}"; size="$REPLY"
		tokens=" ${DIM}(${used}/${size})${RESET}"
	fi

	__percentage "${fields[pct]:-0}"

	local -a segments
	segments=("$location")
	(( ${#limit_parts} > 0 )) && segments+=("🔥 ${(j: / :)limit_parts}")
	segments+=("🧠 ${REPLY}${tokens} ${CYAN}[${fields[model]}]${RESET}")

	print -r -- "${(j: | :)segments}"
}

__main
