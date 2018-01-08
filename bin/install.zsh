#!/bin/zsh -u

DOTFILES="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

() {
	# 変数宣言

	declare force quiet reloads
	declare -a targets

	force=false
	quiet=false
	reloads=false
	targets=()


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
  \e[32mcoffeelint, git, jshint, nvim, peco, screen, tmux, vim, zsh\e[m
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

	function __ask() {
		__question $*
		if read -q; then
			echo; return 0
		else
			echo; return 1
		fi
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
		local command; command="$*"
		__info "> $command"
		eval $command
	}

	function __mkdir() {
		local directory; directory="$*"
		[[ ! -d "$directory" ]] && __exec "mkdir -p '$directory'"
	}

	function __touch() {
		local file; file="$*"
		[[ ! -f "$file" ]] && __exec "touch '$file'"
	}

	function __rm() {
		local target; target="$*"
		if [ -L "$target" ]; then
			__info "> rm -f \"$target\""
			if __ask "remove symbolic link '$target'? [y/N]: "; then
				rm -f "$target"
			fi
		elif [ -f "$target" ]; then
			__info "> rm -f \"$target\""
			if __ask "remove file '$target'? [y/N]: "; then
				rm -f "$target"
			fi
		elif [ -d "$target" ]; then
			__info "> rm -rf \"$target\""
			if __ask "remove directory '$target'? [y/N]: "; then
				rm -rf "$target"
			fi
		fi
	}

	function __link() {
		local -a commands; commands=("ln" "-s" "'$1'" "'$2'")

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
			local -a options targets dialects

			options=("-lhF")

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

			case ${OSTYPE:-} in
				darwin*)
					diarects+=("-G")
					;;
				linux* | cygwin*)
					diarects+=("--time-style=+%Y/%m/%d %H:%M:%S" "--color=always")
					;;
			esac

			local target
			for target in ${targets[@]}; do
				echo
				echo "$target:"

				ls ${diarects[@]} ${options[@]} "$target" | grep --color=never ":"
			done
		fi
	}


	# インストール処理

	function __install_coffeelint() {
		__installing_caption "coffeelint"
		__link "$DOTFILES/coffeelint.json" "$HOME/.coffeelint.json"

		__ls -a "$HOME/.coffeelint.json"

		echo
	}

	function __install_git() {
		__installing_caption "git"
		__link "$DOTFILES/git/config.d" "$HOME/.gitconfig.d"

		if [[ -n $(cat $HOME/.gitconfig | grep '.gitconfig.d' 2> /dev/null) ]]; then
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

	function __install_jshint() {
		__installing_caption "jshint"
		__link "$DOTFILES/jshintrc" "$HOME/.jshintrc"

		__ls -a "$HOME/.jshintrc"

		echo
	}

	function __install_peco() {
		__installing_caption "peco"
		__link "$DOTFILES/peco" "$HOME/.peco"

		__ls -d "$HOME/.peco"
		__ls -a "$HOME/.peco/"

		echo
	}

	function __install_screen() {
		__installing_caption "screen"
		__link "$DOTFILES/screenrc" "$HOME/.screenrc"

		__ls -dr "$HOME/.screenrc"

		echo
	}

	function __install_tmux() {
		__installing_caption "tmux"

		local TMUX_DIR TMUX_CONF TMUX_CONFIGS TMUX_PLUGINS TMUX_PLUGINS_TPM_DIR

		TMUX_DIR="$HOME/.tmux"
		TMUX_CONF="$HOME/.tmux.conf"
		TMUX_CONFIGS="$TMUX_DIR/conf.d"
		TMUX_PLUGINS="$TMUX_DIR/plugins"
		TMUX_PLUGINS_TPM="$TMUX_PLUGINS/tpm"

		__link "$DOTFILES/tmux/tmux.conf" "$TMUX_CONF"
		__link "$DOTFILES/tmux/conf.d" "$TMUX_CONFIGS"

		__mkdir "$TMUX_PLUGINS"

		if [ ! -d "$TMUX_PLUGINS_TPM" ]; then
			__exec "git clone --depth 1 https://github.com/tmux-plugins/tpm \"$TMUX_PLUGINS_TPM\""
		fi

		__ls -dr "$TMUX_CONF" "$TMUX_DIR"
		__ls -a "$TMUX_DIR/"
		__ls -a "$TMUX_CONFIGS/"
		__ls -a "$TMUX_PLUGINS/"

		echo
	}

	function __install_vim_modules() {
		__mkdir "$HOME/.vim/backup/"
		__mkdir "$HOME/.vim/swp/"
		__mkdir "$HOME/.vim/undo/"

		__rm "$HOME/.vim/vimrc.init.d"
		__rm "$HOME/.vim/bundle"

		__link "$DOTFILES/vim/vimrc.d" "$HOME/.vim/vimrc.d"
		__link "$DOTFILES/vim/ftplugin" "$HOME/.vim/ftplugin"
		__link "$DOTFILES/vim/snippets" "$HOME/.vim/snippets"
	}

	function __install_vim() {
		__installing_caption "vim"
		__link "$DOTFILES/vim/vimrc" "$HOME/.vimrc"

		__install_vim_modules

		__ls -dr "$HOME/.vimrc" "$HOME/.vim"
		__ls -a "$HOME/.vim/"

		echo
	}

	function __install_nvim() {
		__installing_caption "nvim"
		__link "$DOTFILES/vim/vimrc" "$HOME/.config/nvim/init.vim"

		__install_vim_modules

		__ls -dr "$HOME/.config/nvim/init.vim" "$HOME/.vim"
		__ls -a "$HOME/.vim/"

		echo
	}

	function __install_zsh() {
		__installing_caption "zsh"

		local ZSHHOME; ZSHHOME="$HOME/.zsh"

		[[ -L "$ZSHHOME" ]] && __rm "$ZSHHOME"

		__mkdir "$ZSHHOME"
		__link "$DOTFILES/zsh/functions" "$ZSHHOME/functions"
		__link "$DOTFILES/zsh/zshrc.d" "$ZSHHOME/zshrc.d"
		__link "$DOTFILES/zsh/helpers.zsh" "$ZSHHOME/helpers.zsh"
		__link "$DOTFILES/zsh/dircolors.conf" "$ZSHHOME/zshrc.d"

		__link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
		__link "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
		__touch "$HOME/.zshrc.local"
		__touch "$HOME/.zshenv.local"

		__mkdir "$HOME/.zplug"
		__install_zplug

		__ls -dr "$HOME/.zshrc" "$HOME/.zshenv"
		__ls -a "$HOME/.zsh/"

		echo
	}

	function __install_zplug() {
		if [[ ! -f $HOME/.zplug/zplug ]]; then
			__exec "curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh"
		fi
	}

	function __install() {
		if [[ "$*" =~ "all" ]]; then
			__install_coffeelint
			__install_git
			__install_jshint
			__install_peco
			__install_screen
			__install_tmux
			__install_vim
			__install_nvim
			__install_zsh
			__load_zshrc
		else
			while (( $# > 0 )); do
				case "$1" in
					coffeelint)
						__install_coffeelint
						;;
					git)
						__install_git
						;;
					jshint)
						__install_jshint
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
					nvim|neovim)
						__install_nvim
						;;
					zsh)
						__install_zsh
						__load_zshrc
						;;
					zplug)
						__install_zplug
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
} $@
