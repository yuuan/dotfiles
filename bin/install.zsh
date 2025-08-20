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
  \e[32m-r, --force-reload  \e[mreload .zshrc after it's installed

\e[33mTARGETS:\e[m
  \e[32mcoffeelint, git, jshint, nvim, peco, screen, tig, tmux, tpm, vim, zsh, afx, starship, atuin, wezterm, claude\e[m
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

	function __installing_caption() {
		__caption "# Installing \`$*\` configurations..."
	}

	function __loading_caption() {
		__caption "# Loading \`$*\` configurations..."
	}

	function __done_caption() {
		__caption "# Done."
	}

	function __br() {
		if ! $quiet; then
			echo
		fi
	}

	function __exec() {
		local command; command="$*"

		if ! $quiet; then
			__info "> $command"
			eval $command
		else
			eval $command > /dev/null
		fi
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

		__done_caption

		__ls -a "$HOME/.coffeelint.json"
		__br
	}

	function __install_git() {
		__installing_caption "git"
		__link "$DOTFILES/git/config.d" "$HOME/.gitconfig.d"
		__link "$DOTFILES/git/gitignore" "$HOME/.gitignore"

		if [[ -n $(cat $HOME/.gitconfig | grep '.gitconfig.d' 2> /dev/null) ]]; then
			__info "Include setting is exists."
		else
			__info "Add include setting to '~/.gitconfig'"
			cat <<'INCLUDE' >> $HOME/.gitconfig
[include]
	path = ~/.gitconfig.d/index.inc
INCLUDE
		fi

		__done_caption

		__ls -a "$HOME/.gitignore" "$HOME/.gitconfig"
		__ls -d "$HOME/.gitconfig.d"
		__ls -a "$HOME/.gitconfig.d/"
		__br
	}

	function __install_jshint() {
		__installing_caption "jshint"

		__link "$DOTFILES/jshintrc" "$HOME/.jshintrc"

		__done_caption

		__ls -a "$HOME/.jshintrc"
		__br
	}

	function __install_peco() {
		__installing_caption "peco"

		local PECO_DIR PECO_OLD_DIR;

		PECO_DIR="$HOME/.config/peco"
		PECO_OLD_DIR="$HOME/.peco"

		__rm "$PECO_OLD_DIR"

		__mkdir "$PECO_DIR"
		__link "$DOTFILES/peco/config.json" "$PECO_DIR/config.json"

		__done_caption

		__ls -d "$PECO_DIR"
		__ls -a "$PECO_DIR/"
		__br
	}

	function __install_screen() {
		__installing_caption "screen"

		__link "$DOTFILES/screenrc" "$HOME/.screenrc"

		__done_caption

		__ls -d "$HOME/.screenrc"
		__br
	}

	function __install_tig() {
		__installing_caption "tig"

		__link "$DOTFILES/tig/tigrc" "$HOME/.tigrc"

		__done_caption

		__ls -a "$HOME/.tigrc"
		__br
	}

	function __install_tmux() {
		__installing_caption "tmux"

		local TMUX_DIR TMUX_CONF TMUX_CONFIGS TMUX_PLUGINS TMUX_PLUGINS_TPM_DIR

		TMUX_DIR="$HOME/.tmux"
		TMUX_CONF="$HOME/.tmux.conf"
		TMUX_CONFIGS="$TMUX_DIR/conf.d"

		__mkdir "$TMUX_DIR"

		__link "$DOTFILES/tmux/tmux.conf" "$TMUX_CONF"
		__link "$DOTFILES/tmux/conf.d" "$TMUX_CONFIGS"

		__install_tpm

		__done_caption

		__ls -d "$TMUX_CONF" "$TMUX_DIR"
		__ls -a "$TMUX_DIR/"
		__ls -a "$TMUX_CONFIGS/"
		__br
	}

	function __install_tpm() {
		__installing_caption "tmux - TPM"

		local TMUX_DIR TMUX_PLUGINS TMUX_PLUGINS_TPM_DIR

		TMUX_DIR="$HOME/.tmux"
		TMUX_PLUGINS="$TMUX_DIR/plugins"
		TMUX_PLUGINS_TPM="$TMUX_PLUGINS/tpm"

		if [[ ! -d "$TMUX_PLUGINS" ]]; then
			__mkdir "$TMUX_PLUGINS"

			if [ ! -d "$TMUX_PLUGINS_TPM" ]; then
				__exec "git clone --depth 1 https://github.com/tmux-plugins/tpm \"$TMUX_PLUGINS_TPM\""
			fi
		fi

		__exec $TMUX_PLUGINS_TPM/bin/install_plugins
	}

	function __install_vim() {
		__installing_caption "vim"
		__link "$DOTFILES/vim/vimrc" "$HOME/.vimrc"

		__mkdir "$HOME/.vim/backup/"
		__mkdir "$HOME/.vim/swp/"
		__mkdir "$HOME/.vim/undo/"

		__rm "$HOME/.vim/vimrc.init.d"
		__rm "$HOME/.vim/bundle"
		__rm "$HOME/.vim/vimrc.d"

		__link "$DOTFILES/vim/conf.d" "$HOME/.vim/conf.d"
		__link "$DOTFILES/vim/ftplugin" "$HOME/.vim/ftplugin"
		__link "$DOTFILES/vim/snippets" "$HOME/.vim/snippets"

		__done_caption

		__ls -d "$HOME/.vimrc" "$HOME/.vim"
		__ls -a "$HOME/.vim/"
		__br
	}

	function __install_nvim() {
		local NVIM_CONFIG_DIR; NVIM_CONFIG_DIR="$HOME/.config/nvim"
		local NVIM_CONFIG; NVIM_CONFIG="$NVIM_CONFIG_DIR/init.lua"

		__installing_caption "nvim"

		__mkdir "$NVIM_CONFIG_DIR"

		__rm "$NVIM_CONFIG_DIR/init.vim"

		__link "$DOTFILES/nvim/init.lua" "$NVIM_CONFIG"
		__link "$DOTFILES/nvim/lua" "$NVIM_CONFIG_DIR/lua"
		__link "$DOTFILES/nvim/after" "$NVIM_CONFIG_DIR/after"
		__link "$DOTFILES/nvim/ftplugin" "$NVIM_CONFIG_DIR/ftplugin"
		__link "$DOTFILES/nvim/ftdetect" "$NVIM_CONFIG_DIR/ftdetect"
		__link "$DOTFILES/nvim/snippets" "$NVIM_CONFIG_DIR/snippets"
		__mkdir "$NVIM_CONFIG_DIR/backup/"

		__done_caption

		__ls -d "$NVIM_CONFIG" "$NVIM_CONFIG_DIR/lua" "$NVIM_CONFIG_DIR/ftdetect" "$NVIM_CONFIG_DIR/ftplugin" "$NVIM_CONFIG_DIR/snippets"
		__ls -a "$NVIM_CONFIG_DIR"
		__br
	}

	function __install_zsh() {
		__installing_caption "zsh"

		local ZSH_CONFIG; ZSH_CONFIG="$HOME/.config/zsh"

		__mkdir "$ZSH_CONFIG"
		__mkdir "$ZSH_CONFIG/functions"

		__link "$DOTFILES/zsh/functions" "$ZSH_CONFIG/functions/shared"
		__link "$DOTFILES/zsh/conf.d" "$ZSH_CONFIG/conf.d"
		__link "$DOTFILES/zsh/helpers.zsh" "$ZSH_CONFIG/helpers.zsh"

		__link "$DOTFILES/zsh/addons" "$ZSH_CONFIG/addons"

		__link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
		__link "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"

		__done_caption

		__ls -d "$HOME/.zshrc" "$HOME/.zshenv"
		__ls -a "$ZSH_CONFIG"
		__br
	}

	function __install_afx() {
		__installing_caption "afx"

		local AFX_BIN_DIR; AFX_BIN_DIR="$HOME/.local/bin"
		local AFX_CONFIG_DIR; AFX_CONFIG_DIR="$HOME/.config/afx"

		if ! command -v afx &>/dev/null; then
			curl -sL https://raw.githubusercontent.com/babarot/afx/HEAD/hack/install \
				| AFX_BIN_DIR="$AFX_BIN_DIR" bash
		fi

		__mkdir "$AFX_CONFIG_DIR"

		__link "$DOTFILES/zsh/addons/plugins.yaml" "$AFX_CONFIG_DIR/plugins.yaml"

		__done_caption

		__ls "$AFX_BIN_DIR/afx"
		__ls -a "$AFX_CONFIG_DIR"
		__br
	}

	function __install_starship() {
		__installing_caption "starship"

		if (( ! $+commands[starship] )); then
			curl -sS https://starship.rs/install.sh | sh
		fi

		local STARSHIP_CONFIG_DIR; STARSHIP_CONFIG_DIR="$HOME/.config"

		__mkdir "$STARSHIP_CONFIG_DIR"

		__link "$DOTFILES/zsh/addons/starship.toml" "$STARSHIP_CONFIG_DIR/starship.toml"

		__done_caption

		__ls -a "$STARSHIP_CONFIG_DIR/starship.toml"
		__br
	}

	function __install_atuin() {
		__installing_caption "atuin"

		if (( ! $+commands[atuin] )); then
			curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh \
				| ATUIN_INSTALL_DIR="$HOME/.local/bin" sh
		fi

		local ATUIN_CONFIG_DIR; ATUIN_CONFIG_DIR="$HOME/.config/atuin"
		local ATUIN_CONFIG; ATUIN_CONFIG="$ATUIN_CONFIG_DIR/config.toml"

		__mkdir "$ATUIN_CONFIG_DIR"

		__rm "$ATUIN_CONFIG"
		__link "$DOTFILES/zsh/addons/atuin.toml" "$ATUIN_CONFIG"

		__done_caption

		__ls -a "$ATUIN_CONFIG_DIR/"
		__br
	}

	function __install_wezterm() {
		__installing_caption "wezterm"

		local WEZTERM_CONFIG_DIR; WEZTERM_CONFIG_DIR="$HOME/.config/wezterm"
		local WEZTERM_CONFIG; WEZTERM_CONFIG="$WEZTERM_CONFIG_DIR/wezterm.lua"

		__mkdir "$WEZTERM_CONFIG_DIR"

		__rm "$WEZTERM_CONFIG"
		__link "$DOTFILES/wezterm/wezterm.lua" "$WEZTERM_CONFIG"

		__done_caption

		__ls -a "$WEZTERM_CONFIG_DIR/"
		__br
	}

	function __install_claude() {
		__installing_caption "claude"

		local CLAUDE_CONFIG_DIR; CLAUDE_CONFIG_DIR="$HOME/.claude"

		__mkdir "$CLAUDE_CONFIG_DIR"

		__link "$DOTFILES/claude/settings.json" "$CLAUDE_CONFIG_DIR/settings.json"
		__link "$DOTFILES/claude/commands" "$CLAUDE_CONFIG_DIR/commands"

		__done_caption

		__ls -a "$CLAUDE_CONFIG_DIR/"
		__br
	}

	function __install() {
		if [[ "$*" =~ "all" ]]; then
			__install_coffeelint
			__install_git
			__install_jshint
			__install_peco
			__install_screen
			__install_tig
			__install_tmux
			__install_vim
			__install_nvim
			__install_zsh
			__install_afx
			__install_starship
			__install_atuin
			__install_wezterm
			__install_claude
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
					tig)
						__install_tig
						;;
					tmux)
						__install_tmux
						;;
					tpm)
						__install_tpm
						;;
					vim)
						__install_vim
						;;
					nvim|neovim)
						__install_nvim
						;;
					zsh-only)
						__install_zsh
						__load_zshrc
						;;
					zsh)
						__install_zsh
						__install_afx
						__install_starship
						__install_atuin
						__load_zshrc
						;;
					afx)
						__install_afx
						;;
					starship)
						__install_starship
						;;
					atuin)
						__install_atuin
						;;
					wezterm)
						__install_wezterm
						;;
					claude)
						__install_claude
						;;
					*)
						__warn "\`$1\` is invalid target."
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
			autoload -U compinit; compinit -u

			__done_caption
		fi
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
			-f|--force)
				force=true
				;;
			-q|--quiet)
				quiet=true
				;;
			-r|--force-reload)
				reloads=true
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
