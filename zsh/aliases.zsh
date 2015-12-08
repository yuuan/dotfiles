## confirm before change
#alias rm="rm -i"
#alias cp="cp -i"
alias mv="mv -i"

## ls options
case ${OSTYPE} in
	darwin*)
		alias ls='ls -FG'
		;;
	linux* | cygwin*)
		alias ls='ls -F --time-style=+"%Y/%m/%d %H:%M:%S" --color=auto'
		;;
esac

alias la="ls -a"
alias ll="ls -lh"
alias lal="ls -alh"
alias lz="ls -lZ"
alias laz="ls -laZ"

alias ..='cd ..'
