# ----------------------------------------
# 補完の設定
# ----------------------------------------

# 自作した補完ファイルを追加
fpath=($ZSHHOME/functions $fpath)

# compinit は zplug で行うためコメントアウト
#autoload -U compinit
#compinit

# カーソルの位置から補完を開始する
setopt COMPLETE_IN_WORD

# 補完候補を一覧表示
setopt AUTO_LIST

# TAB キーで順に補完候補を切り替える
setopt AUTO_MENU

# ディレクトリ名の補完で末尾に `/` を付加し次の補完に備える
setopt AUTO_PARAM_SLASH

# ファイル名の展開でディレクトリにマッチした場合末尾に `/` を付加する
setopt MARK_DIRS

# 補完候補一覧でファイルの種別を記号で表示
setopt LIST_TYPES

# `--prefix=/usr` などの `=` 以降も補完する
setopt MAGIC_EQUAL_SUBST

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt AUTO_RESUME

# 補完候補をキャッシュする
zstyle ':completion:*' use-cache true

# `sudo` の後に補完するコマンドのパス
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
#zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %F{yellow}%d%f'
zstyle ':completion:*:descriptions' format '%F{yellow}- %d -%f'
zstyle ':completion:*:corrections' format '%F{yellow}%d %F{red}(errors: %e)%f'
zstyle ':completion:*:options' description 'yes'
