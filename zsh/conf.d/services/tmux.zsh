# -----------------------------------------------------------------
# enhancd で選択したディレクトリで新しい tmux ウィンドウを開く
# -----------------------------------------------------------------

function __services::tmux::window::new() {
	local dir=$(__enhancd::sources::history | __enhancd::filter::interactive)

	if [[ -n "$dir" ]]; then
		tmux new-window -c "$dir"
	fi
}

zle -N __services::tmux::window::new

bindkey "\em" __services::tmux::window::new
