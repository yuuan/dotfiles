local ZSHRC_DIR="${ZSH_HOME}/conf.d"

# Zsh の基本的な設定
__helpers::sources "${ZSHRC_DIR}/core"

# AFX の設定
if (( $+commands[afx] )); then
	source <(afx completion zsh); compdef _afx afx
	source <(afx init)
fi

# Starship の設定
if (( $+commands[starship] )); then
	source <(starship init zsh)
fi

# Atuin の設定
if (( $+commands[atuin] )); then
	source <(atuin init zsh --disable-up-arrow)
fi

# `conf.d` 内のファイルを読み込む
__helpers::sources "${ZSHRC_DIR}/functions"
__helpers::sources "${ZSHRC_DIR}/services"
__helpers::sources "${ZSHRC_DIR}/aliases"
