# EC2 でのエラー対策
# ref http://qiita.com/ikeisuke/items/3a010e7922795eb79d76

autoload -Uz compinit; compinit -u


# PATH の設定

path=(
	$HOME/.go/bin
	./vendor/bin
	./node_modules/.bin
	$path
)


# 環境ごとの設定を読み込む

local ZSHENV_LOCAL="${HOME}/.zshenv.local"

if [ -f $ZSHENV_LOCAL ]; then
	source $ZSHENV_LOCAL
fi
