# ------------------------------------------------------------
# セッション切断時にマウス操作が文字で表示されるのをリセット
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
