# EC2 でのエラー対策
# ref http://qiita.com/ikeisuke/items/3a010e7922795eb79d76

autoload -Uz compinit; compinit


# PATH の設定

path=(
	$HOME/.go/bin
	./vendor/bin
	./node_modules/.bin
	$path
)
