c() {
	if [ -x bin/console ]; then
		bin/console "$@"
	else
		bin/rails console "$@"
	fi
}
