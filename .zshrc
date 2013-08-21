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

# autoload -U colors
#colors

#
# Show branch name in Zsh's right prompt
#

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

setopt prompt_subst
#setopt re_match_pcre

function rprompt-git-current-branch {
		local name st color gitdir action
		if [[ -n `echo "$PWD" | grep "/\.git(/.*)?$"` ]]; then
			return
		fi
		name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
		if [[ -z $name ]]; then
			return
		fi

		gitdir=`git rev-parse --git-dir 2> /dev/null`
		action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

		st=`git status 2> /dev/null`
		if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
			color=%F{blue}
		elif [[ -n `echo "$st" | grep "^no changes "` ]]; then
			color=%F{yellow}
		elif [[ -n `echo "$st" | grep "^# Changes to be committed"` ]]; then
			color=%B%F{red}
		else
			color=%F{red}
		fi

		echo "$color$name$action%f%b "
}

RPROMPT='[`rprompt-git-current-branch`%~]'

autoload colors
colors
PROMPT="%F{blue}[%n@%m]%(!.#.$) %f"
PROMPT2="%F{blue}%_> %f"
SPROMPT="%F{magenta}correct: %R -> %r [nyae]? %f"

#alias rm="rm -i"
#alias cp="cp -i"
alias mv="mv -i"

alias ls="ls -F --color=auto"
alias la="ls -a"
alias ll="ls -l"
alias lal="ls -al"
alias lv="lv -c"
alias hist="history | grep"
alias service="sudo /sbin/service"
alias ..="cd .."
alias tmux="tmux -2"

export EDITOR='/usr/bin/vim'

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[Z" reverse-menu-complete
bindkey "^R" history-incremental-search-backward

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
#setopt append_history
setopt hist_no_store
setopt hist_verify
setopt share_history
setopt hist_ignore_dups
#setopt hist_reduce_blanks
setopt hist_ignore_space

autoload -U compinit
compinit
setopt auto_list
setopt auto_menu
setopt auto_param_slash
setopt mark_dirs
setopt print_eight_bit
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
setopt auto_resume
setopt autopushd

if [ -f ~/.zshrc-local ]; then
	source ~/.zshrc-local
fi

