# ----------------------------------------
# キーバインドの設定
# ----------------------------------------

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^U" kill-whole-line
bindkey "^W" vi-backward-kill-word
bindkey "^@" quote-region
bindkey "^_" quote-line

# Home
bindkey "^[[1~" beginning-of-line

# End
bindkey "^[[4~" end-of-line

# Delete
bindkey "^[[3~" delete-char

# Shift + Tab
bindkey "^[[Z" reverse-menu-complete

# Ctrl + Left
bindkey "^[[1;5D" backward-word

# Ctrl + Right
bindkey "^[[1;5C" forward-word

# Ctrl + Up
bindkey "^[[1;5A" beginning-of-line

# Ctrl + Down
bindkey "^[[1;5B" end-of-line

# Ctrl + S と Ctrl + Q を無効化
setopt NOFLOWCONTROL
bindkey "^S" history-incremental-search-forward
bindkey "^Q" push-line-or-edit
stty stop undef
