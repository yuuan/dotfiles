# ----------------------------------------
# 特殊関数の設定
# ----------------------------------------

autoload -Uz add-zsh-hook

# カレントディレクトリを変更したときに実行
function show-current-directory {
	pwd
}

add-zsh-hook chpwd show-current-directory
