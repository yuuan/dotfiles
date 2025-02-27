# ----------------------------------------
# `fzf` でプロセスを選択し PID を取得
# ----------------------------------------

function process-id {
	if [[ `whoami` = 'root' ]]; then
		ps aux | fzf-tmux --prompt "process>" | awk '{print $2}'
	else
		ps aux | grep "^${USER}" | fzf-tmux --prompt "process>" | awk '{print $2}'
	fi
}

if (( $+commands[fzf-tmux] )); then
	alias -g @PID='$(process-id)'

	GLOBAL_ALIASES=(${GLOBAL_ALIASES:-} '@PID')
fi
