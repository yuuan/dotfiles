# ----------------------------------------
# `enhancd` の設定
# ----------------------------------------

# `enhancd` で `fzf-tmux` を使う
export ENHANCD_FILTER="${ENAHNCD_FILTER:-fzf-tmux:fzf:peco}"

# `cd` 後に実行するコマンド
export ENHANCD_HOOK_AFTER_CD="pwd"
