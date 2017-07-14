# ----------------------------------------
# `peco` でプロセスを選択し PID を取得
# ----------------------------------------

function process-id {
	if [[ `whoami` = 'root' ]]; then
		ps aux | peco --prompt "PROCESS>" | awk '{print $2}'
	else
		ps aux | grep "^$USER" | peco --prompt "PROCESS>" | awk '{print $2}'
	fi
}

if which peco &> /dev/null; then
	alias -g @PID='$(process-id)'

	GLOBAL_ALIASES=(${GLOBAL_ALIASES:-} @PID)
fi
