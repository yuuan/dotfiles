local ZSHRC_DIR="${ZSH_HOME}/conf.d"

# Zsh の基本的な設定
__helpers::sources "${ZSHRC_DIR}/core"

# Starship の設定
if command -v starship &> /dev/null; then
	eval "$(starship init zsh)"
fi

# AFX の設定
if command -v afx &> /dev/null; then
	source <(afx completion zsh); compdef _afx afx
	source <(afx init)
fi

# `conf.d` 内のファイルを読み込む
__helpers::sources "${ZSHRC_DIR}/functions"
__helpers::sources "${ZSHRC_DIR}/services"
__helpers::sources "${ZSHRC_DIR}/aliases"
