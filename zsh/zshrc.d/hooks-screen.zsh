# ----------------------------------------
# `screen` のタイトル
# ----------------------------------------

autoload -Uz add-zsh-hook

if [[ -n ${STY:-} ]] || [[ -n ${TMUX_PANE:-} ]]; then

	# screen/tmux のタイトルを取得
	function get-window-name {
		if [[ -n ${TMUX_PANE:-} ]]; then
			tmux display -p '#{window_name}'
		else
			# screen のタイトルの取得方法が解らない
			echo -n
		fi
	}

	# screen/tmux のタイトルを設定
	function set-window-name {
		if [[ -n ${STY:-} ]] || [[ -n ${TMUX_PANE:-} ]]; then
			echo -ne "\ek$*\e\\"
		fi
	}

	# カレントディレクトリを切り替えた後に呼ばれる
	function precmd-function {
		local shell=$(basename ${SHELL:-idle})
		set-window-name-to-command $shell
	}

	# プロンプトを表示する直前に実行
	add-zsh-hook precmd precmd-function

	# コマンド名を表示
	function set-window-name-to-command {
		if [[ -z "$HOST_SCREEN_NAME" ]]; then
			export HOST_SCREEN_NAME=$(hostname | awk 'BEGIN{FS="."}{print $1}')
		fi

		set-window-name "${HOST_SCREEN_NAME}:${PWD:t}:*$1"
	}

	# コマンドを実行する直前に呼ばれる
	function preexec-function {
		local command=(${(s: :)${1}})
		set-window-name-to-command $command
	}

	add-zsh-hook preexec preexec-function

fi
