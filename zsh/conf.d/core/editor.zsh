# ----------------------------------------
# 環境変数 `EDITOR` の設定
# ----------------------------------------

if which nvim &> /dev/null; then
	export EDITOR=nvim
elif which vim &> /dev/null; then
	export EDITOR=vim
elif which vi &> /dev/null; then
	export EDITOR=vi
fi

function edit() {
	$(echo ${=EDITOR:-vim}) "$@"
}
