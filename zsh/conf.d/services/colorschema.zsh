# ----------------------------------------
# 配色の設定
# ----------------------------------------

# `ls` コマンドにカラースキーマが設定されていたら補完にも使う
if [ -n "${LS_COLORS}" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
else
    # Zsh 用に適当な LS_COLORS を設定する
    export ZSH_LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

    zstyle ':completion:*' list-colors ${(s.:.)ZSH_LS_COLORS}
fi
