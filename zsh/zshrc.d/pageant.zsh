# ----------------------------------------
# `ssh-agent` と `pageant.exe` のための設定
# ----------------------------------------

# pageant.exe

function ssh-agent-refresh() {
	if [ -n "$SSH_CLIENT" ]; then
		local LOCAL_TMP_DIR=$HOME/.ssh/.agents

		if [ ! -d $LOCAL_TMP_DIR ]; then
			mkdir -p $LOCAL_TMP_DIR
			echo "'$LOCAL_TMP_DIR/' was created."
		else
			find $LOCAL_TMP_DIR -xtype l | while read f; do
				rm "$f"
				echo "'$f' was removed."
			done
		fi

		local client=$(echo $SSH_CLIENT | awk '{print sprintf("%s-%s",$1,$2)}' | sed -e 's/[^0-9]/-/g')
		local agent="$LOCAL_TMP_DIR/ssh-agent-$USER-$client"

		if [ -S "$SSH_AUTH_SOCK" ]; then
			case $SSH_AUTH_SOCK in
			/tmp/*/agent.[0-9]*)
				echo "'$SSH_AUTH_SOCK' was linked from '$agent'."
				ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
			esac
		elif [ -S $agent ]; then
			echo "'$SSH_AUTH_SOCK' was changed to '$agent'."
			export SSH_AUTH_SOCK=$agent
		else
	#		echo "no ssh-agent"
		fi
	fi
}

ssh-agent-refresh
