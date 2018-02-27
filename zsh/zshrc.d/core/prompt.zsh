# ----------------------------------------
# プロンプトの設定
# ----------------------------------------

#
# ホストの表示名
#

if [[ -z "$HOST_SCREEN_NAME" ]]; then
	export HOST_SCREEN_NAME=${HOSTNAME:-$(hostname | awk 'BEGIN{FS="."}{print $1}')}
fi

#
# プロンプトの色を決定
#

function prompt-color() {
	# 管理者は赤
	if [ ${UID} = 0 ]; then
		echo -n "red"

	# 本番とステージング環境は赤
	elif [[ "${HOST_ENVIRONMENT:-}" =~ "production|staging" ]]; then
		echo -n "red"

	# サーバは茶色
	elif [[ "$HOST_SCREEN_NAME" =~ "^(conoha|gitlab|redmine)$" ]]; then
		echo -n "172"

	# AWS では ANCI 緑
	elif [[ "$HOSTNAME" =~ "^ip-[0-9]{1,3}-[0-9]{1,3}-[0-9]{1,3}-[0-9]{1,3}$" ]]; then
		echo -n "green"
	elif [[ "$HOSTNAME" =~ "\.compute\.amazonaws\.com$" ]]; then
		echo -n "green"

	# NAS は ANSI 水色
	elif [[ $(echo "$HOST_SCREEN_NAME" | sha256sum) =~ "^2158b18755afe74ed3bc8375947effc06b33e9410c64bb02018f347924a7df33" ]]; then
		echo -n "cyan"

	# VPS では黄色
	elif [[ $(echo "$HOST_SCREEN_NAME" | sha256sum) =~ "^a4dfea152a9c7e27c2fbc44fd0566604675c54a4c3e935a02034520edbc49126" ]]; then
		echo -n "178"

	# Cygwin/MinGW は ANSI 水色
	elif [[ $(uname -sr) =~ "^(CYGWIN|MINGW)$" ]]; then
		echo -n "cyan"

	# プライベートは青
	elif [[ $(echo "$USER" | sha256sum) =~ "^9cec2a69978d16c588d56d037e52891884b91899591022fb15ed20f809af3000" ]]; then
		echo -n "039"

	# 仕事用は緑
	elif [[ $(echo "$USER" | sha256sum) =~ "^7d014540ab9e1e807b98c8ae6dfcb891caff0ef11262937afd792a07516b15a1" ]]; then
		echo -n "070"

	# それ以外は青
	else
		echo -n "blue"
	fi
}

#
# 左プロンプトの書式をリセット
#

function prompt-color-reset() {
	PROMPT="%F{${PROMPT_COLOR:-$(prompt-color)}}[%n@$HOST_SCREEN_NAME]%(!.#.$) %f"
	PROMPT2="%F{$PROMPT_COLOR}%_> %f"
}

prompt-color-reset


#
# ブランチ名を取得
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

function current-branch-color() {
	# `CURRENT_BRANCH_COLOR_DISABLED` を設定すればブランチの表示色を固定化できる
	if [[ -n "${CURRENT_BRANCH_COLOR_DISABLED}" ]]; then
		echo -n "%F{cyan}"

	else
		if is-at-least 4.3.10; then
			# vsc_info から status を取得
			if [[ -n "$vcs_info_msg_6_" ]]; then
				echo -n "%F{red}"
			elif [[ -n "$vcs_info_msg_5_" ]]; then
				echo -n "%F{yellow}"
			else
				echo -n "%F{blue}"
			fi

		else
			# git コマンドから status を取得
			if git rev-parse --show-toplevel >& /dev/null; then
				st=$(git status 2> /dev/null)
				if [[ "$st" =~ "^nothing to" ]]; then
					echo -n "%F{blue}"
				elif [[ "$st" =~ "^no changes " ]]; then
					echo -n "%F{yellow}"
				elif [[ "$st" =~ "^# Changes to be committed" ]]; then
					echo -n "%B%F{red}"
				else
					echo -n "%F{red}"
				fi
			fi
		fi
	fi
}

function current-branch() {
	local repository branch action st color

	# `CURRENT_BRANCH_DISABLED` を設定すればブランチ名の表示を無効化できる
	if [[ -n "${CURRENT_BRANCH_DISABLED}" ]]; then
		echo -n "%f%b"

	else
		STY= LANG=en_US.UTF-8 vcs_info 2> /dev/null
		if [[ -n "$vcs_info_msg_1_" ]]; then
			repository="$vcs_info_msg_0_"
			branch="$vcs_info_msg_2_"
			if [[ -n "$vcs_info_msg_5_" ]]; then
				action="($vcs_info_msg_5_)"
			fi
			color=$(current-branch-color)

			echo -n "$color$branch$action%f%b "
		fi
	fi
}

#
# 右プロンプトの書式
#

setopt prompt_subst

RPROMPT='[$(current-branch)%~]'
SPROMPT="%F{magenta}correct: %R -> %r [nyae]? %f"
