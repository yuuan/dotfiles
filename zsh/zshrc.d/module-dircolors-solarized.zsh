# ----------------------------------------
# `dircolors-solarized` の読み込み
# ----------------------------------------

# Load dircolors-solarized
if which dircolors > /dev/null; then
	if [[ -n `echo $OS | grep "Windows" 2> /dev/null` ]]; then
		eval $(dircolors -b $ZSHHOME/modules/dircolors-solarized/dircolors.256dark)
	else
		eval $(dircolors $ZSHHOME/modules/dircolors-solarized/dircolors.256dark)
	fi
elif which gdircolors > /dev/null; then
	eval $(gdircolors $ZSHHOME/modules/dircolors-solarized/dircolors.256dark)
fi

# dircolors-solarized for zsh
if [ -n "$LS_COLORS" ]; then
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
