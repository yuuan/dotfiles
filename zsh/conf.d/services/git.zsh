# ----------------------------------------
# `git` コマンドに関する設定
# ----------------------------------------

function __services::git::commit::select() {
	git log --color --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %s%C(red)%d%C(reset)' \
		| fzf-tmux --ansi --prompt 'commit>' \
		| awk '{print $1}'
}

function __services::git::branch::select() {
	git branch -a |
		awk '{print $NF}' |
		fzf-tmux -- \
			--layout=reverse --info=hidden --no-multi --prompt="branch> " \
			--preview="echo {} | xargs git log --color=always --graph --pretty=format:'<%C(red)%h%C(reset)> %s%C(yellow)%d%C(reset) %C(blue)(%an)%C(reset)'" |
		head -n 1
}

function __services::git::changed_files::select() {
	git status --short | fzf-tmux --prompt "changed file>" | awk '{print $2}'
}

function __services::git::branch::switch() {
	local BRANCH=$(__services::git::branch::select)

	if [ -n "$BRANCH" ]; then
		git switch "$BRANCH"
	fi
}

if which fzf-tmux &> /dev/null; then
	alias -g @HASH='$(__services::git::commit::select)'
	alias -g @H='$(__services::git::commit::select)'
	alias -g @BRANCH='$(__services::git::branch::select)'
	alias -g @B='$(__services::git::branch::select)'
	alias -g @FILE='$(__services::git::changed_files::select)'
	alias -g @F='$(__services::git::changed_files::select)'

	GLOBAL_ALIASES=(${GLOBAL_ALIASES:-} '@HASH' '@H' '@BRANCH' '@B' '@FILE' '@F')
fi
