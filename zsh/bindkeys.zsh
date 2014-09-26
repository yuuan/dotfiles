bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[Z" reverse-menu-complete
bindkey "^R" history-incremental-search-backward
bindkey "^K" kill-line

setopt noflowcontrol
bindkey "^S" history-incremental-search-forward
bindkey "^Q" push-line-or-edit
stty stop undef

