#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

# Source global definitions
if [ -f /etc/zshrc ]; then
	source /etc/zshrc
fi

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

autoload -U colors
colors

#alias rm="rm -i"
#alias cp="cp -i"
alias mv="mv -i"

case ${OSTYPE} in
	darwin*)
		alias ls="ls -FG"
		;;
	linux* | cygwin*)
		alias ls='ls -F --time-style=+"%Y/%m/%d %H:%M:%S" --color=auto'
		;;
esac

alias la="ls -a"
alias ll="ls -lh"
alias lal="ls -alh"

alias hist='history | grep'
alias service='sudo /sbin/service'
alias ..='cd ..'

alias st='git status'
alias gb='git branch -a'

export EDITOR='vim'

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[Z" reverse-menu-complete
bindkey "^R" history-incremental-search-backward
bindkey "^K" kill-line

setopt noflowcontrol
bindkey "^S" history-incremental-search-forward
bindkey "^Q" push-line-or-edit
stty stop undef

#
# History
#
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt append_history
setopt hist_no_store
setopt hist_verify
#setopt share_history
setopt hist_ignore_dups
#setopt hist_reduce_blanks
setopt hist_ignore_space

setopt auto_list
setopt auto_menu
setopt auto_param_slash
setopt list_types
setopt mark_dirs
setopt print_eight_bit
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
setopt auto_resume
setopt autopushd
setopt magic_equal_subst
zstyle ':completion:*' use-cache true

export ZSHHOME="${HOME}/.zsh"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
		-x $ZSHHOME ]; then
	for i in $ZSHHOME/*; do
		[[ ${i##*/} = *.zsh ]] &&
			[ \( -f $i -o -h $i \) -a -r $i ] && . $i
	done
fi

#
# load local setting
#
if [ -f ~/.zshrc.local ]; then
	source ~/.zshrc.local
fi
if [ -f ~/.zshrc-local ]; then
	source ~/.zshrc-local
fi

