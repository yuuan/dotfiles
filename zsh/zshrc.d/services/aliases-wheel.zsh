# ----------------------------------------
# `wheel` に属するユーザに対する設定
# ----------------------------------------

if [ `groups | tr " " "\n" | grep "^wheel$"` ]; then
	alias service='sudo /sbin/service'
fi
