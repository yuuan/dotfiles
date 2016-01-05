# Load dircolors-solarized
if [[ -n `echo $OS | grep "Windows" 2> /dev/null` ]]; then
	eval $(dircolors -b $ZSHHOME/dircolors-solarized/dircolors.256dark)
elif which dircolors > /dev/null; then
	eval $(dircolors $ZSHHOME/dircolors-solarized/dircolors.256dark)
elif which gdircolors > /dev/null; then
	eval $(gdircolors $ZSHHOME/dircolors-solarized/dircolors.256dark)
fi

# dircolors-solarized for zsh
if [ -n "$LS_COLORS" ]; then
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

