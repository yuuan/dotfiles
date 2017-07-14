# ----------------------------------------
# `git` コマンドに関する設定
# ----------------------------------------

function git-hash() {
	git log --oneline --branches | peco --prompt "GIT COMMIT>" | awk '{print $1}'
}

function git-branch() {
	git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"
}

function git-changed-files() {
	git status --short | peco --prompt "CHANGES FILES" | awk '{print $2}'
}

if which peco &> /dev/null; then
	alias -g @HASH='$(git-hash)'
	alias -g @H='$(git-hash)'
	alias -g @BRANCH='$(git-branch)'
	alias -g @B='$(git-branch)'
	alias -g @FILE='$(git-changed-files)'
	alias -g @F='$(git-changed-files)'

	GLOBAL_ALIASES=(${GLOBAL_ALIASES:-} @HASH @H @BRANCH @B @FILE @F)
fi

alias s='git status'
alias st='git status'
alias gr='git graph'
alias gb='git branch -a'
alias gd='git diff'
alias gdc='git diff --cached'
