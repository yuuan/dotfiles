# ----------------------------------------
# `git` コマンドに関する設定
# ----------------------------------------

function __services::git::commit::select() {
	git log --color --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %s%C(red)%d%C(reset)' |
	fzf-tmux -- \
		--ansi --exact --no-sort --prompt 'commit>' \
		--preview="git show --color=always {+1}" |
	awk '{print $1}'
}

function __services::git::branch::select() {
	local fmt=$(cat <<- EOF
		%(if:equals=<$(git config user.email)>)%(authoremail)%(then)%(color:default)%(else)%(color:blue)%(end)%(refname:short)|\
		%(committerdate:relative)|\
		%(authorname)
	EOF
	)

	{
		git branch --sort=-committerdate --format=$fmt --color=always
		git branch --remotes --sort=-committerdate --format=$fmt --color=always
	} |
	column -ts'|' |
	fzf-tmux -- \
		--ansi --exact --layout=reverse --info=hidden --no-sort --no-hscroll \
		--preview="git log --color=always --graph --pretty=format:'<%C(red)%h%C(reset)> %s%C(yellow)%d%C(reset) %C(blue)(%an)%C(reset)' -50 {+1}" |
	awk '{print $1}' \
}

function __services::git::branch::current() {
	git branch --contains | cut -d " " -f 2
}

function __services::git::branch::switch() {
	local BRANCH=$(__services::git::branch::select)

	if [ -n "$BRANCH" ]; then
		git switch "$BRANCH"
	fi
}

function __services::git::changed_files::select() {
	local files=$(
		git diff --name-only | awk '{print $0"|\033[33m(changed)\033[0m"}'
		git ls-files --others --exclude-standard | awk '{print $0"|\033[31m(untracked)\033[0m"}'
	)
	if [ -z "$files" ]; then
		return
	fi

	column -ts'|' <<< "$files" |
	fzf-tmux -- \
		--ansi --exact --info=hidden --no-sort --multi --prompt 'file>' \
		--preview='[[ "{2}" == *changed* ]] && git diff --color=always -- {1} || bat --style=plain --color always {1}' |
	awk '{print $1}'
}

function __services::git::changed_files::add() {
	for arg in "$@"; do
		if [[ "$arg" != -* || "$arg" == "-A" ]]; then
			git add "$@"
			git status
			return
		fi
	done

	local files=$(__services::git::changed_files::select)

	if [ -n "$files" ]; then
		git add "$@" -- $files
		git status
	fi
}
compdef _git-add __services::git::changed_files::add

if which fzf-tmux &> /dev/null; then
	alias -g @HASH='$(__services::git::commit::select)'
	alias -g @H='$(__services::git::commit::select)'
	alias -g @BRANCH='$(__services::git::branch::select)'
	alias -g @B='$(__services::git::branch::select)'
	alias -g @CURRENT_BRANCH='$(__services::git::branch::current)'
	alias -g @CB='$(__services::git::branch::current)'
	alias -g @FILE='$(__services::git::changed_files::select)'
	alias -g @F='$(__services::git::changed_files::select)'

	GLOBAL_ALIASES=(${GLOBAL_ALIASES:-} '@HASH' '@H' '@BRANCH' '@B' '@CURRENT_BRANCH' '@CB' '@FILE' '@F')
fi

alias ga='__services::git::changed_files::add'
