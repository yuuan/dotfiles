if [ `groups | tr " " "\n" | grep "^wheel$"` ]; then
	alias service='sudo /sbin/service'
fi

