#
# Pronpt
#

if [ ${UID} = 0 ]; then
	PROMPT="%F{red}[%n@%m]%(!.#.$) %f"
	PROMPT2="%F{red}%_> %f"
elif [[ -n `hostname | grep "dti"` ]]; then
	PROMPT="%F{cyan}[%n@%m]%(!.#.$) %f"
	PROMPT2="%F{cyan}%_> %f"
elif [[ -n `hostname | grep "v157-7-154-240"` ]]; then
	PROMPT="%F{yellow}[%n@%m]%(!.#.$) %f"
	PROMPT2="%F{yellow}%_> %f"
else
	PROMPT="%F{blue}[%n@%m]%(!.#.$) %f"
	PROMPT2="%F{blue}%_> %f"
fi


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

SPROMPT="%F{magenta}correct: %R -> %r [nyae]? %f"

