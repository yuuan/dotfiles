#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

# Source global definitions
if [ -f /etc/zshrc ]; then
	source /etc/zshrc
fi

export ZSHHOME="${HOME}/.zsh"


# `zshrc.d` 内のファイルを読み込む

local ZSHRC_DIR="${ZSHHOME}/zshrc.d"

if [ -d $ZSHRC_DIR -a -r $ZSHRC_DIR -a -x $ZSHRC_DIR ]; then
	for i in $ZSHRC_DIR/*; do
		[[ ${i##*/} = *.zsh ]] && [ \( -f $i -o -h $i \) -a -r $i ] && source $i
	done
fi


# 環境ごとの設定を読み込む

local ZSHRC_LOCAL="${HOME}/.zshrc.local"

if [ -f $ZSHRC_LOCAL ]; then
	source $ZSHRC_LOCAL
fi


# ブランチ名の表示を無効にする
#export CURRENT_BRANCH_DISABLED=1
