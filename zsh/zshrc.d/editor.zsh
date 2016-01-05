# ----------------------------------------
# 環境変数 `EDITOR` の設定
# ----------------------------------------

if which vim &> /dev/null; then
	export EDITOR=`which vim`
elif which vi &> /dev/null; then
	export EDITOR=`which vi`
fi
