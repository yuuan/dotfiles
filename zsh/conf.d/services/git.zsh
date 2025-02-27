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
		# https://git-scm.com/docs/git-status#_short_format
		git status --porcelain | awk -v FS="" '
		{
			second = substr($0, 2, 1);
			if (second == " ") next;

			if (second == "?") status = "\x1b[31m(untracked)\x1b[0m";
			else if (second == "M") status = "\x1b[32m(modified)\x1b[0m";
			else if (second == "T") status = "\x1b[32m(type changed)\x1b[0m";
			else if (second == "D") status = "\x1b[35m(deleted)\x1b[0m";
			else if (second == "A") status = "\x1b[32m(added)\x1b[0m";
			else if (second == "R") status = "\x1b[32m(renamed)\x1b[0m";
			else if (second == "C") status = "\x1b[32m(copied)\x1b[0m";
			else if (second == "U") status = "\x1b[36m(unmerged)\x1b[0m";
			else status = "\x1b[38m(unknown)\x1b[0m";

			printf "%s|%s\n", substr($0, 4), status;
		}'
	)
	if [ -z "$files" ]; then
		return
	fi

	column -ts'|' <<< "$files" |
	fzf-tmux -- \
		--ansi --exact --info=hidden --no-sort --multi --prompt 'file>' \
		--preview='[[ "{2}" != *untracked* ]] && git diff --color=always -- {1} || bat --style=plain --color always {1}' |
	awk '{print $1}'
}

function __services::git::changed_files::add() {
	for arg in "$@"; do
		# オプションじゃない引数がひとつでもあれば引数全部 git add して終了
		if [[ "$arg" != -* || "$arg" == "-A" ]]; then
			git add "$@"
			git status
			return
		fi
	done

	local additional = function() {
		local $files=$1
		local -a additions

		IFS=$'\n'  # 改行を区切り文字に設定
		for file in $files; do
			[ -e "$file" ] && additions+=("$file")
		done
		unset IFS

		return additions
	}

	local deletable = function() {
		local $files=$1
		local -a deletions

		IFS=$'\n'  # 改行を区切り文字に設定
		for file in $files; do
			[ -e "$file" ] || deletions+=("$file")
		done
		unset IFS

		return deletions
	}

	local files=$(__services::git::changed_files::select)

	if [ -n "$files" ]; then

		if (( ${#additions[@]} > 0 )); then
			if ! git add "$@" -- $additions; then
				echo
				printf "\e[31m%s\e[m\n" "failed:"
				echo git add "$@" -- $additions
			fi
		fi

		if (( ${#deletions[@]} > 0 )); then
			if ! git rm -- $deletions; then
				echo
				printf "\e[31m%s\e[m\n" "failed:"
				echo git rm -- $deletions
			fi
		fi

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
