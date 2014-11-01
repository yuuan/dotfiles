# pageant.exe

LOCAL_TMP_DIR=$HOME/.ssh-agent

mkdir -p $LOCAL_TMP_DIR

agent="$LOCAL_TMP_DIR/ssh-agent-$USER"
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

