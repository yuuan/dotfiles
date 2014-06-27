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

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' max-exports 7

zstyle ':vcs_info:*' formats '%R' '%S' '%b' '' '%s'
zstyle ':vcs_info:*' actionformats '%R' '%S' '%b' '%a' '%s'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
	zstyle ':vcs_info:*' check-for-changes true
	zstyle ':vcs_info:*' formats '%R' '%S' '%b' '' '%s' '%c' '%u'
	zstyle ':vcs_info:*' actionformats '%R' '%S' '%b' '(%a)' '%s' '%c' '%u'
fi

zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

function current-branch () {
	local repository branch action st color

	STY= LANG=en_US.UTF-8 vcs_info
	if [[ -n "$vcs_info_msg_1_" ]]; then
		repository="$vcs_info_msg_0_"
		branch="$vcs_info_msg_2_"
		if [[ -n "$vcs_info_msg_5_" ]]; then
			action="($vcs_info_msg_5_)"
		fi

		if is-at-least 4.3.10; then
			if [[ -n "$vcs_info_msg_6_" ]]; then
				color="%F{red}"
			elif [[ -n "$vcs_info_msg_5_" ]]; then
				color="%F{yellow}"
			else
				color="%F{blue}"
			fi
		else
			if [[ -z `echo "$PWD" | grep -E -i "/\.git(/.*)?$"` ]]; then
				st=`git status 2> /dev/null`
				if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
					color="%F{blue}"
				elif [[ -n `echo "$st" | grep "^no changes "` ]]; then
					color="%F{yellow}"
				elif [[ -n `echo "$st" | grep "^# Changes to be committed"` ]]; then
					color="%B%F{red}"
				else
					color="%F{red}"
				fi
			fi
		fi

		print -n "$color$branch$action%f%b "
	fi
}


setopt prompt_subst

RPROMPT='[`current-branch`%~]'

SPROMPT="%F{magenta}correct: %R -> %r [nyae]? %f"

