# ----------------------------------------
# 履歴に関する関数
# ----------------------------------------

# 全ての履歴を表示する
function history-all {
	history -i 1
}

# よく使うコマンドをランキング表示
function history-best {
	history 1 | sed -E 's/^[ ]*//g' | sed -E 's/ +/ /g' | cut -d' ' -f2 | sort | uniq -c | sort -nr | head -n ${1:-20} | nl -w 2
}
