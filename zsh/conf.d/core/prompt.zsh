# ----------------------------------------
# プロンプトの設定
# ----------------------------------------

#
# ホストの表示名
#

if [[ -z "${HOST_SCREEN_NAME}" ]]; then
	export HOST_SCREEN_NAME=${HOSTNAME:-$(hostname | awk 'BEGIN{FS="."}{print $1}')}
fi

#
# プロンプトの色を決定
#

function __prompt::show_color() {
	local HASHER=${${commands[sha256sum]:+"sha256sum"}:-${${commands[shasum]:+"shasum -a 256"}:-"cat"}}

	# 管理者は赤
	if [ ${UID} = 0 ]; then
		echo -n "red"

	# 本番とステージング環境は赤
	elif [[ "${HOST_ENVIRONMENT:-}" =~ "production|staging" ]]; then
		echo -n "red"

	# サーバは茶色
	elif [[ "${HOST_SCREEN_NAME}" =~ "^(conoha|gitlab|redmine)$" ]]; then
		echo -n "172"

	# AWS では黄色
	elif [[ "${HOSTNAME}" =~ "^ip-[0-9]{1,3}-[0-9]{1,3}-[0-9]{1,3}-[0-9]{1,3}$" ]]; then
		echo -n "178"
	elif [[ "${HOSTNAME}" =~ "\.compute\.amazonaws\.com$" ]]; then
		echo -n "178"

	# VPS では黄色
	elif [[ $(echo "${HOST_SCREEN_NAME}" | ${=HASHER}) =~ "^a4dfea152a9c7e27c2fbc44fd0566604675c54a4c3e935a02034520edbc49126" ]]; then
		echo -n "178"

	# macOS は緑
	elif [[ ${OSTYPE} =~ "darwin*" ]]; then
		echo -n "070"

	# WSL は緑
	elif [[ $(uname -sr) =~ "Microsoft" ]]; then
		echo -n "070"

	# Cygwin/MinGW は緑
	elif [[ $(uname -sr) =~ "^(CYGWIN|MINGW)$" ]]; then
		echo -n "070"

	# プライベートは青
	elif [[ $(echo "${USER}" | ${=HASHER}) =~ "^9cec2a69978d16c588d56d037e52891884b91899591022fb15ed20f809af3000" ]]; then
		echo -n "039"

	# 仕事用は黄色
	elif [[ $(echo "${USER}" | ${=HASHER}) =~ "^7d014540ab9e1e807b98c8ae6dfcb891caff0ef11262937afd792a07516b15a1" ]]; then
		echo -n "178"

	# それ以外は ANSI 青
	else
		echo -n "blue"
	fi
}

#
# 左プロンプトの書式をリセット
#

function __prompt::init_color() {
	PROMPT_COLOR="${PROMPT_COLOR:-$(__prompt::show_color)}"
	PROMPT="%F{${PROMPT_COLOR}}[%n@${HOST_SCREEN_NAME}]%(!.#.$) %f"
	PROMPT2="%F{${PROMPT_COLOR}}%_> %f"
}

__prompt::init_color


#
# ブランチ情報を取得するための初期設定
#

autoload -Uz is-at-least

if is-at-least 4.3.10; then
	autoload -Uz vcs_info
	zstyle ':vcs_info:*' enable git svn hg
	zstyle ':vcs_info:*' max-exports 7

	zstyle ':vcs_info:*' check-for-changes true
	zstyle ':vcs_info:*' formats '%R' '%S' '%b' '' '%s' '%c' '%u'
	zstyle ':vcs_info:*' actionformats '%R' '%S' '%b' '(%a)' '%s' '%c' '%u'

	zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
	zstyle ':vcs_info:bzr:*' use-simple true
else
	export CURRENT_BRANCH_DISABLED="true"
fi


#
# ブランチ名を取得
#

function __prompt::branch::show_color() {
	# `CURRENT_BRANCH_COLOR_DISABLED` を設定すればブランチの表示色を固定できる
	if [[ -n "${CURRENT_BRANCH_COLOR_DISABLED}" ]]; then
		echo -n "%F{cyan}"
	else
		if [[ -n "$vcs_info_msg_6_" ]]; then
			echo -n "%F{red}"
		elif [[ -n "$vcs_info_msg_5_" ]]; then
			echo -n "%F{yellow}"
		else
			echo -n "%F{blue}"
		fi
	fi
}

function __prompt::branch::show_name() {
	local repository branch action st color

	# `CURRENT_BRANCH_DISABLED` を設定すればブランチ名の表示を無効化できる
	if [[ -n "${CURRENT_BRANCH_DISABLED}" ]]; then
		echo -n "%f%b"

	else
		STY= LANG=C vcs_info 2> /dev/null
		if [[ -n "$vcs_info_msg_1_" ]]; then
			repository="$vcs_info_msg_0_"
			branch="$vcs_info_msg_2_"
			if [[ -n "$vcs_info_msg_5_" ]]; then
				action="($vcs_info_msg_5_)"
			fi
			color=$(__prompt::branch::show_color)

			echo -n "$color$branch$action%f%b "
		fi
	fi
}

#
# 右プロンプトの書式
#

setopt prompt_subst

RPROMPT='[$(__prompt::branch::show_name)%~ %*]'
SPROMPT="%F{magenta}correct: %R -> %r [nyae]? %f"
