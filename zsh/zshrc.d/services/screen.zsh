# ----------------------------------------
# `screen` のタイトル
# ----------------------------------------

autoload -Uz add-zsh-hook

if [[ -n "$STY$TMUX" ]]; then

	# screen/tmux のタイトルを取得
	function get-window-name {
		if [[ -n "$TMUX" ]]; then
			tmux display -p '#{window_name}'
		else
			# screen のタイトルの取得方法が解らない
			echo -n
		fi
	}

	# screen/tmux のタイトルを設定
	function set-window-name {
		if [[ -n "$TMUX" ]]; then
			tmux rename-window "$@"
		elif [[ -n "$STY" ]]; then
			echo -ne "\ek$@\e\\"
		fi
	}

	# ssh の引数から一番文字数の多いものを取得
	function get-host-name-in-ssh {
		shift
		echo ${(j:\n:)@} | awk '{print length($0), $0}' | sort -nr | head -n 1 | cut -d' ' -f2-
	}

	# sudo 時のコマンド名を取得
	function get-command-name-in-sudo {
		shift
		while (( $# > 0 )); do
			case "$1" in
				-[aghpuUcCrt])
					shift
					;;
				-*)
					;;
				*)
					echo "$1" && break
					;;
			esac
			shift
		done
	}

	# jobs からコマンド名を取得
	function get-command-name-from-jobs {
		get-command-name $(jobs | awk '$2=="+"{for(i=4;i<NF;i++){printf("%s%s",$i,OFS=" ")}print $NF}')
	}

	# コマンド名を取得
	function get-command-name {
		case "$1" in
			sudo)
				get-command-name-in-sudo $*
				;;
			nohup)
				echo "$2"
				;;
			fg)
				get-command-name-from-jobs
				;;
			*)
				echo "$1"
				;;
		esac
	}

	# カレントディレクトリを切り替えた後に呼ばれる
	function precmd-function {
		set-window-name-to-command
	}

	# プロンプトを表示する直前に実行
	add-zsh-hook precmd precmd-function

	# コマンド名を表示
	function set-window-name-to-command {
		local command=$(get-command-name $*)
		local directory=${PWD:t}
		local host

		# ちょっと強引に `$HOME` を `~` に変換
		[[ "_$PWD" = "_$HOME" ]] && directory='~'

		if [[ "$command" = "ssh" ]]; then
			set-window-name "[$(get-host-name-in-ssh $*)]"
		elif [[ -n "$command" ]]; then
			set-window-name "${directory}(*$command)"
		else
			set-window-name "${directory}"
		fi
	}

	# コマンドを実行する直前に呼ばれる
	function preexec-function {
		local -a command;
		command=(${(s: :)${1}})
		set-window-name-to-command $command
	}

	add-zsh-hook preexec preexec-function

fi
