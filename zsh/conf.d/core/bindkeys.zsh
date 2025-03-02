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
bindkey "^P" vi-put-after
bindkey "^[." insert-last-word

# Home
bindkey "^[[1~" beginning-of-line
bindkey "^[[H" beginning-of-line

# End
bindkey "^[[4~" end-of-line
bindkey "^[[F" end-of-line

# Insert
bindkey -M viins "^[[2~" vi-yank-whole-line
bindkey -M vicmd "^[[2~" vi-insert

# Delete
bindkey "^[[3~" delete-char

# Tab で補完のみして展開はしない
bindkey '^I' complete-word

# Shift + Tab
bindkey "^[[Z" reverse-menu-complete

# Ctrl + S と Ctrl + Q を無効化
setopt NOFLOWCONTROL
bindkey "^S" history-incremental-search-forward
bindkey "^Q" push-line-or-edit
stty -ixon <$TTY >$TTY
