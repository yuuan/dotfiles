# pageant.exe

if [ -n "$SSH_CLIENT" ]; then
	local LOCAL_TMP_DIR=$HOME/.ssh-agent

	if [ ! -d $LOCAL_TMP_DIR ]; then
		mkdir -p $LOCAL_TMP_DIR
	else
		find -L $LOCAL_TMP_DIR -type l | while read f; do
			rm "$f"
		done
	fi

	local client=$(echo $SSH_CLIENT | awk '{print sprintf("%s-%s",$1,$2)}' | sed -e 's/[^0-9]/-/g')
	local agent="$LOCAL_TMP_DIR/ssh-agent-$USER-$client"

	if [ -S "$SSH_AUTH_SOCK" ]; then
		case $SSH_AUTH_SOCK in
		/tmp/*/agent.[0-9]*)
			ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
		esac
	elif [ -S $agent ]; then
		export SSH_AUTH_SOCK=$agent
	#else
	#	 echo "no ssh-agent"
	fi
fi
