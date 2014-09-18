function git-hash() {
	git log --oneline --branches | peco | awk '{print $1}'
}

alias -g H=`${git-hash}`

