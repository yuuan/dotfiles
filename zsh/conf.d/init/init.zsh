export ZSH_CONFIG="${HOME}/.config/zsh"

source "${ZSH_CONFIG}/helpers.zsh"

# Go のインストール先
GOPATH="${GOPATH:-${HOME}/.go}"

# PATH の設定
path=(
	$path
	${HOME}/.local/bin
	${GOPATH}/bin
	${HOME}/.composer/vendor/bin
	${HOME}/.yarn/bin
)

# 自作した補完ファイルを追加
fpath=(
	${ZSH_CONFIG}/functions
	${ZSH_CONFIG}/functions/shared
	$fpath
)
