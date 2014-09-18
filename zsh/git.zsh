function git-hash() {
	git log --oneline --branches | peco | awk '{print $1}'
}

function git-changed-files() {
	git status --short | peco | awk '{print $2}'
}

alias -g H=`${git-hash}`
alias -g F=`${git-changed-files}`

alias st='git status'
alias gb='git branch -a'

