# ----------------------------------------
# `peco` でプロセスを選択し `reptyr` でアタッチ
# ----------------------------------------

function attach-pty {
	if ! which reptyr &> /dev/null; then
		echo -e "\e[31mreptyr is not installed.\e[m"
		return 1
	fi

	if ! which peco &> /dev/null; then
		echo -e "\e[31mpeco is not installed.\e[m"
		return 1
	fi

	local process=$(ps aux | grep "^$USER" | peco | awk '{print $2}')
	[[ -n "$process" ]] && reptyr "$process"
}
