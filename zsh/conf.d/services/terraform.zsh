# ----------------------------------------
# `terraform` コマンドに関する設定
# ----------------------------------------

function __services::terraform::files::list() {
    \ls -1 *.tf
}

function __services::terraform::files::select() {
	local FILES=$(__services::terraform::files::list)

	if [ "$?" != 0 ]; then
		return $?
	fi

	echo "${FILES}" |
		fzf-tmux -- \
		--cycle --layout=reverse --info=hidden --no-multi --prompt="files> " \
		--preview="cat {}"
}

function __services::terraform::resources::list() {
	local FILE=$1

	if [ -z "${FILE}" ]; then
		return 1
	fi

	if [ ! -f "${FILE}" ]; then
		return 1
	fi

	cat "${FILE}" | grep ^resource | sed -e 's/resource "//g' | sed -e 's/" "/./g' | sed -e 's/" {//g'
}

function __services::terraform::resources::targets::show() {
	local FILE=$1
	local RESOURCES=$(__services::terraform::resources::list "${FILE}")

	if [ -z "${RESOURCES}" ]; then
		return 1
	fi

	echo -n "${RESOURCES}" | sed -e 's/^/-target=/' | tr '\n' ' '
}

function __services::terraform::resources::targets::select() {
	local FILE=$(__services::terraform::files::select)

	if [ "$?" != 0 ]; then
		echo -n '--canceled-by-zsh-global-alias'
		return $?
	fi

	if [ -z "${FILE}" ]; then
		echo -n '--canceled-by-zsh-global-alias-because-file-not-found'
		return 1
	fi

	local TARGETS=$(__services::terraform::resources::targets::show "${FILE}")

	if [ "$?" != 0 ]; then
		echo -n '--canceled-by-zsh-global-alias-because-resource-not-found'
		return $?
	fi

	echo -n "${TARGETS}"
}

alias TF="__services::terraform::resources::targets::show"

if (( $+commands[fzf-tmux] )); then
	alias -g @TF='$(__services::terraform::resources::targets::select)'

	GLOBAL_ALIASES=(${GLOBAL_ALIASES:-} '@TF')
fi
