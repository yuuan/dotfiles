# ----------------------------------------
# 基本設定
# ----------------------------------------

# バックグラウンドプロセスを高速に
#setopt NOBGNICE

# メールチェックを無効にする
#MAILCHECK=0

# 終了時に実行中のプロセスに `HUP` シグナルを送る
#setopt HUP

# `${fg[white]}` の書式で色指定を利用する
autoload -U colors
colors

# 補完候補などで 8bit 文字を通す
setopt PRINT_EIGHT_BIT

# Ctrl-W で削除する時に区切りとみなさない文字
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# `cd` 時に自動的に `pushd` する
setopt AUTOPUSHD

# `zmv` コマンドを有効にする
autoload -U zmv
