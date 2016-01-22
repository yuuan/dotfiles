#!/bin/zsh -u

# 変数宣言

local dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"
local force=false
local quiet=false
local reloads=false
local -a targets=()


# 共通処理

function __warn() {
	echo -e "\e[31m$*\e[m" >&2
}

function __die() {
	__warn "$@"
	exit 1
}

function __encode() {
	if [[ -p /dev/stdout ]]; then
		cat - | sed -E 's/\\e[[0-9]*m//g'
	else
		cat - | sed -E 's/\\e//g'
	fi
}

function __help() {
	cat <<HELP | __encode
\e[33mUSAGE:\e[m
  ./bin/install.zsh [OPTIONS] [TARGETS]

\e[33mOPTIONS:\e[m
  \e[32m-h, --help          \e[mshow this help message and usage
  \e[32m-f, --force         \e[mremove existing destination files
  \e[32m-q, --quiet         \e[mdon't output any message
  \e[32m--init              \e[minitialize git's submodules (default)
  \e[32m-r, --force-reload  \e[mreload .zshrc after it's installed

\e[33mTARGETS:\e[m
  \e[32mgit, peco, screen, tmux, vim, zsh\e[m
HELP
}

function __caption() {
	if ! $quiet; then
		echo -e "\e[33m$*\e[m"
	fi
}

function __info() {
	if ! $quiet; then
		echo -e "\e[32m$*\e[m"
	fi
}

function __question() {
	echo -en "\e[32m$*\e[m"
}

function __initializing_caption() {
	__caption "# Initializing \`$*\`..."
}

function __installing_caption() {
	__caption "# Installing \`$*\` configurations..."
}

function __loading_caption() {
	__caption "# Loading \`$*\` configurations..."
}

function __exec() {
	local command=$*
	__info "> $command"
	eval $command
}

function __mkdir() {
	local directory="$*"
	[[ ! -d "$directory" ]] && __exec "mkdir -p '$directory'"
}

function __link() {
	local -a commands=("ln" "-s" "'$1'" "'$2'")

	if $force; then
		commands[2]+="f"
	else
		commands[2]+="i"
	fi

	if [[ -d "$1" ]]; then 
		commands[2]+="n"
	fi

	__exec "${commands[@]}"
}

function __ls {
	if ! $quiet; then
		local -a options
		local -a targets
		local -a dialects
		local result

		while (($# > 0)); do
			case "$1" in
				-*)
					options+=("$1")
					;;
				*)
					targets+=("$1")
					;;
			esac
			shift
		done

		case ${OSTYPE} in
			darwin*)
				diarects+=("-G")
				;;
			linux* | cygwin*)
				diarects+=("--time-style=+%Y/%m/%d %H:%M:%S" "--color=always")
				;;
		esac

		echo
		echo "${targets[@]}:"

		result=$(ls -lhF ${diarects[@]} ${options[@]} ${targets[@]})

		if [[ "${options[@]}" =~ "a" ]]; then
			echo $result | tail -n +3
		else
			echo $result | tail -n +1
		fi
	fi
}


# 初期化

function __install_submodules() {
	__initializing_caption "submodules"
	pushd $dotfiles
	__exec "git submodule update --init"
	__exec "git submodule status"
	popd

	echo "initialized."
	echo
}

# インストール処理

function __install_git() {
	__installing_caption "git"
	__link "$dotfiles/git/config.d" "$HOME/.gitconfig.d"

	if [[ -n $(cat $HOME/.gitconfig | grep '.gitconfig.d') ]]; then
		__info "Include setting is exists."
	else
		__info "Add include setting to '~/.gitconfig'"
		cat <<'INCLUDE' >> $HOME/.gitconfig
	[include]
		path = ~/.gitconfig.d/index.inc
INCLUDE
	fi

	__ls -d "$HOME/.gitconfig" "$HOME/.gitconfig.d"
	__ls -a "$HOME/.gitconfig.d/"

	echo
}

function __install_peco() {
	__installing_caption "peco"
	__link "$dotfiles/peco" "$HOME/.peco"

	__ls -d "$HOME/.peco"
	__ls -a "$HOME/.peco/"

	echo
}

function __install_screen() {
	__installing_caption "screen"
	__link "$dotfiles/screenrc" "$HOME/.screenrc"

	__ls -dr "$HOME/.screenrc"

	echo
}

function __install_tmux() {
	__installing_caption "tmux"
	__link "$dotfiles/tmux.conf" "$HOME/.tmux.conf"

	local TMUX_PLUGINS="$HOME/.tmux/plugins"
	local TMUX_PLUGINS_POWERLINE_DIR="$TMUX_PLUGINS/tmux-powerline"

	__mkdir "$TMUX_PLUGINS"

	if [ ! -d $TMUX_PLUGINS_POWERLINE_DIR ]; then
		__exec "git clone git://github.com/erikw/tmux-powerline.git $TMUX_PLUGINS_POWERLINE_DIR"
		cd $TMUX_PLUGINS_POWERLINE_DIR
		__exec "/bin/sh $TMUX_PLUGINS_POWERLINE_DIR/generate_rc.sh"
	fi

	__ls -dr "$HOME/.tmux.conf" "$HOME/.tmux"
	__ls -a "$HOME/.tmux/"
	__ls -a "$HOME/.tmux/plugins/"

	echo
}

function __install_vim() {
	__installing_caption "vim"
	__mkdir "$HOME/.vim/backup/"
	__mkdir "$HOME/.vim/swp/"
	__mkdir "$HOME/.vim/undo/"

	__link "$dotfiles/vimrc" "$HOME/.vimrc"
	__link "$dotfiles/vim/vimrc.init.d" "$HOME/.vim/vimrc.init.d"
	__link "$dotfiles/vim/vimrc.d" "$HOME/.vim/vimrc.d"
	__link "$dotfiles/vim/ftplugin" "$HOME/.vim/ftplugin"

	if [ ! -d $HOME/.vim/bundle/ ]; then
		__exec "mkdir -p $HOME/.vim/bundle/"
		__exec "git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim"
	fi

	__ls -dr "$HOME/.vimrc" "$HOME/.vim"
	__ls -a "$HOME/.vim/"

	echo
}

function __install_zsh() {
	__installing_caption "zsh"
	__link "$dotfiles/zsh" "$HOME/.zsh"
	__link "$dotfiles/zshrc" "$HOME/.zshrc"

	__mkdir "$HOME/.zplug"

	if [[ ! -f $HOME/.zplug/zplug ]]; then
		__exec "curl -fLo $HOME/.zplug/zplug --create-dirs git.io/zplug"
	fi

	__ls -dr "$HOME/.zshrc" "$HOME/.zsh"
	__ls -a "$HOME/.zsh/"

	echo
}

function __install() {
	__install_submodules

	if [[ "$*" =~ "all" ]]; then
		__install_git
		__install_peco
		__install_screen
		__install_tmux
		__install_vim
		__install_zsh
		__load_zshrc
	else
		while (( $# > 0 )); do
			case "$1" in
				git)
					__install_git
					;;
				peco)
					__install_peco
					;;
				screen)
					__install_screen
					;;
				tmux)
					__install_tmux
					;;
				vim)
					__install_vim
					;;
				zsh)
					__install_zsh
					__load_zshrc
					;;
				submodules)
					;;
				*)
					__warn "\`$1\` is invalid target."
					echo
					;;
			esac
			shift
		done
	fi
}

function __load_zshrc() {
	__loading_caption "zsh"

	if ! $quiet && ! $reloads; then
		__question 'load `.zshrc`? [y/N]: '
		if read -q; then
			echo; reloads=true
		else
			echo
		fi
	fi

	if $reloads; then
		set +eu
		__exec "source $HOME/.zshrc"
		set -eu

		rm -f $HOME/.zcompdump
		autoload -U compinit; compinit

		echo "loaded."
	fi

	echo
}


# コマンドライン引数の確認

if [[ $# -eq 0 ]]; then
	__help && exit 0
fi

while (( $# > 0 )); do
	case "$1" in
		-h|--help|help)
			__help && exit 0
			;;
		-y|--yes)
			force=true
			;;
		-q|--quiet)
			quiet=true
			;;
		-r|--force-reload)
			reloads=true
			;;
		--init|--initialize)
			targets+=("submodules")
			;;
		-*|--*)
			__die "$1: Unknown option"
			;;
		*)
			targets+=("$1")
			;;
	esac
	shift
done


# インストール

if [[ ${#targets[@]} -gt 0 ]]; then
	__install $targets
fi
