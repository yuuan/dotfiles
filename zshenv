autoload -Uz compinit; compinit

path=(
	$HOME/.go/bin
	./vendor/bin
	./node_modules/.bin
	$path
)
