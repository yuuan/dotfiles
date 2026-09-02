#!/bin/sh
#
# Claude Code の通知。使える手段があれば使い、無ければ機能単位で諦める。
# WSL2 / macOS / Windows (Git Bash) のどれでも同じものが動くよう POSIX sh で書く。
#
# WSL2 の notify-send は WinNotifier に転送するラッパーで winnotify と経路が重なる。
# 二重に鳴らさないよう、見つかった最初の 1 つだけを使う。
#
# winnotify は WinNotifier のクライアント。環境ごとに実体が違う:
#   WSL2    ~/.local/bin/winnotify (HTTP 経由で Windows に飛ばす)
#   Windows scoop shim add winnotify 'C:\Software\Utility\WinNotifier\Notify.exe'

message="${1:-OK}"

if command -v osascript > /dev/null 2>&1; then
	# message は argv 経由で渡す。-e に埋め込むと " を含む文面が AppleScript として解釈される
	osascript \
		-e 'on run argv' \
		-e 'display notification (item 1 of argv) with title "Claude Code"' \
		-e 'end run' \
		-- "${message}"
elif command -v winnotify > /dev/null 2>&1; then
	winnotify -t 'Claude Code' -m "${message}"
elif command -v notify-send > /dev/null 2>&1; then
	notify-send "Claude Code" "${message}"
fi

printf '\a'
