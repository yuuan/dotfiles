# ----------------------------------------
# コマンド履歴の設定
# ----------------------------------------

# 履歴ファイルの保存先
HISTFILE=~/.zsh_history

# メモリに保存される履歴の件数
HISTSIZE=1000000

# 履歴ファイルに保存される履歴の件数
SAVEHIST=1000000

# 開始と終了を記録
setopt EXTENDED_HISTORY

# 履歴ファイルを上書きするのではなく追記する
setopt APPEND_HISTORY

# `!!` などを実行する前に確認する
setopt HIST_VERIFY

# `history` コマンドは記録しない
setopt HIST_NO_STORE

# 他のプロンプトと履歴を共有
#setopt SHARE_HISTORY

# 直前のコマンドと同じなら記録しない
setopt HIST_IGNORE_DUPS

# 既にコマンドが記録されていた場合は古い方を削除
setopt HIST_IGNORE_ALL_DUPS

# 余分な空白は詰めて記録
setopt HIST_REDUCE_BLANKS

# スペースで始まるコマンド行は記録しない
setopt HIST_IGNORE_SPACE

# 全ての履歴を表示する
function history-all { history -E 1 }
