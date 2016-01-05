if which vim &> /dev/null; then
	export EDITOR=`which vim`
elif which vi &> /dev/null; then
	export EDITOR=`which vi`
fi
