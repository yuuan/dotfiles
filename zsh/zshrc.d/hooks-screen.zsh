# ----------------------------------------
# `screen` のタイトル
# ----------------------------------------

autoload -Uz add-zsh-hook

if [[ "$STY" ]] || [[ "$TMUX" ]]; then

	# screen/tmux のタイトルを取得
	function get-window-name {
		if [[ "$TMUX" ]]; then
			tmux display -p '#{window_name}'
		else
			# screen のタイトルの取得方法が解らない
			echo -n
		fi
	}

	# screen/tmux のタイトルを設定
	function set-window-name {
		if [[ "$STY" ]] || [[ "$TMUX" ]]; then
			echo -ne "\ek$@\e\\"
		fi
	}

	# カレントディレクトリを切り替えた後に呼ばれる
	function precmd-function {
		set-window-name-to-command
	}

	# プロンプトを表示する直前に実行
	add-zsh-hook precmd precmd-function

	# コマンド名を表示
	function set-window-name-to-command {
		local command=$1
		local directory=${PWD:t}

		# ちょっと強引に `$HOME` を `~` に変換
		[[ "_$PWD" = "_$HOME" ]] && directory='~'

		if [[ "$command" ]]; then
			set-window-name "${directory}(*$command)"
		else
			set-window-name "${directory}"
		fi
	}

	# コマンドを実行する直前に呼ばれる
	function preexec-function {
		local command=(${(s: :)${1}})
		set-window-name-to-command $command
	}

	add-zsh-hook preexec preexec-function

fi
