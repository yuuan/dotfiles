# ----------------------------------------
# プロンプトの設定
# ----------------------------------------

PROMPT_COLOR="blue"

if [[ -z "$HOST_SCREEN_NAME" ]]; then
	export HOST_SCREEN_NAME=$(hostname | awk 'BEGIN{FS="."}{print $1}')
fi

if [ ${UID} = 0 ]; then
	PROMPT_COLOR="red"
elif [[ -n `hostname | grep "feoh"` ]]; then
	PROMPT_COLOR="cyan"
elif [[ -n `hostname | grep "conoha"` ]]; then
	PROMPT_COLOR="yellow"
elif [[ -n `hostname | grep "gitlab"` ]]; then
	PROMPT_COLOR="yellow"
elif [[ -n `uname -sr | grep "CYGWIN"` ]] || [[ -n `uname -sr | grep "MINGW"` ]]; then
	PROMPT_COLOR="cyan"
elif [[ -n `echo "$HOST_SCREEN_NAME" | grep "\.\(stg\|prd\)"` ]]; then
	PROMPT_COLOR="red"
elif [[ -n `hostname | grep "^ip-[0-9]\{1,3\}-[0-9]\{1,3\}-[0-9]\{1,3\}-[0-9]\{1,3\}$"` ]]; then
	PROMPT_COLOR="green"
elif [[ -n `hostname | grep "\.compute\.amazonaws\.com$"` ]]; then
	PROMPT_COLOR="green"
fi

PROMPT="%F{$PROMPT_COLOR}[%n@$HOST_SCREEN_NAME]%(!.#.$) %f"
PROMPT2="%F{$PROMPT_COLOR}%_> %f"

#
# Show branch name in Zsh's right prompt
#

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' max-exports 7

autoload -Uz is-at-least
if is-at-least 4.3.10; then
	zstyle ':vcs_info:*' check-for-changes true
	zstyle ':vcs_info:*' formats '%R' '%S' '%b' '' '%s' '%c' '%u'
	zstyle ':vcs_info:*' actionformats '%R' '%S' '%b' '(%a)' '%s' '%c' '%u'
else
	zstyle ':vcs_info:*' formats '%R' '%S' '%b' '' '%s'
	zstyle ':vcs_info:*' actionformats '%R' '%S' '%b' '%a' '%s'
fi

zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

function current-branch () {
	local repository branch action st color

	if [[ -n "${CURRENT_BRANCH_DISABLED:+$CURRENT_BRANCH_DISABLED}" ]]; then
		print -n "%f%b"
	else
		STY= LANG=en_US.UTF-8 vcs_info 2> /dev/null
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
	fi
}


setopt prompt_subst

RPROMPT='[`current-branch`%~]'
SPROMPT="%F{magenta}correct: %R -> %r [nyae]? %f"
