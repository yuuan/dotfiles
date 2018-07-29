# ----------------------------------------
# SSH の設定ファイルに設定されたホスト
# ----------------------------------------

# SSH の設定ファイルに設定されたホストを表示
function ssh-hosts() {
	if [ -f "$HOME/.ssh/config" ]; then
		cat "$HOME/.ssh/config" | grep "Host " | awk '{print $2}'
	fi
}

# SSH の設定ファイルに設定されたホストを選択
function ssh-host-select() {
	ssh-hosts | fzf-tmux --prompt "host>"
}

if which fzf-tmux &> /dev/null; then
	alias -g @HOST='$(ssh-host-select)'

	GLOBAL_ALIASES=(${GLOBAL_ALIASES:-} @HOST)
fi
