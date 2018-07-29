# ----------------------------------------
# 特殊関数の設定
# ----------------------------------------

autoload -Uz add-zsh-hook

# カレントディレクトリを変更したときに実行
function __zshrc::services::cd::show-current-directory() {
	echo ${PWD:-}
}

add-zsh-hook chpwd __zshrc::services::cd::show-current-directory
