# ----------------------------------------
# `peco` でプロセスを選択し `reptyr` でアタッチ
# ----------------------------------------

function attach-pty {
	if which reptyr &> /dev/null && which peco &> /dev/null; then
		local process=$(ps aux | grep "^$USER" | peco | awk '{print $2}')
		[[ -n "$process" ]] && reptyr "$process"
	else
		echo "reptyr is not installed."
	fi
}
