# Load zsh-completions.zsh
fpath=($ZSHHOME/zsh-completions/src $fpath)

rm -f ~/.zcompdump; compinit

