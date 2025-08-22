# ----------------------------------------
# 補完の設定
# ----------------------------------------

# 補完を有効にする
autoload -Uz compinit && compinit -u

# カーソルの位置から補完を開始する
setopt COMPLETE_IN_WORD

# 補完候補を一覧表示
setopt AUTO_LIST

# Tab キーで順に補完候補を切り替える
setopt AUTO_MENU

# ディレクトリ名の補完で末尾に `/` を付加し次の補完に備える
setopt AUTO_PARAM_SLASH

# ファイル名の展開でディレクトリにマッチした場合末尾に `/` を付加する
setopt MARK_DIRS

# 補完候補一覧でファイルの種別を記号で表示
setopt LIST_TYPES

# `--prefix=/usr` などの `=` 以降も補完する
setopt MAGIC_EQUAL_SUBST

# 補完候補をキャッシュする
zstyle ':completion:*' use-cache true

# `sudo` の後に補完するコマンドのパス
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# Tab キーでの展開を無効にする代わりに展開結果 (_expand) を候補に含める
# _expand:      Glob パターンを展開
# _complete:    通常の補完
# _correct:     コマンド名のスペルミス修正
# _approximate: コマンド名だけでなく引数のスペルミスも修正
zstyle ':completion:*' completer _expand _complete

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*:messages' format '%F{green}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %F{cyan}%d%f'
zstyle ':completion:*:descriptions' format '%K{blue}%F{232} %d %k%F{blue}%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:corrections' format '%K{red} %d (errors: %e)%k%F{red}%f'
zstyle ':completion:*:options' description 'yes'

# make コマンドの補完候補をターゲットに絞る
zstyle ':completion:*:*:make:*' tag-order 'targets'

# `ls` コマンドにカラースキーマが設定されていたら補完にも使う
if [ -n "${LS_COLORS}" ]; then
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
else
	# Zsh 用に適当な LS_COLORS を設定する
	ZSH_LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors ${(s.:.)ZSH_LS_COLORS}
fi
