if [ `groups yuuan | tr " " "\n" | grep "^wheel$"` ]; then
	alias service='sudo /sbin/service'
fi

