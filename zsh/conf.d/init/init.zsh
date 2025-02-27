export ZSH_CONFIG="${HOME}/.config/zsh"

# ヘルパー関数を読み込む
source "${ZSH_CONFIG}/helpers.zsh"

# 先に読ませたい環境ごとの設定を読み込む
__helpers::source "${HOME}/.zshenv.init"

# Go のインストール先
GOPATH="${GOPATH:-${HOME}/.go}"

# PATH の設定
__helpers::unshift_path \
	"${HOME}/.local/bin" \
	"${GOPATH}/bin" \
	"${HOME}/.composer/vendor/bin" \
	"${HOME}/.yarn/bin"

# 自作した補完ファイルを追加
fpath=(
	${ZSH_CONFIG}/functions
	${ZSH_CONFIG}/functions/shared
	$fpath
)

# 環境ごとの設定を読み込む
__helpers::source "${HOME}/.zshenv.local"
