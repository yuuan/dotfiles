# ----------------------------------------
# `wheel` に属するユーザに対する設定
# ----------------------------------------

if [ `groups | tr " " "\n" | grep "^wheel$"` ]; then
	if [ -f /sbin/service ]; then
		alias service='sudo /sbin/service'
	fi
fi
