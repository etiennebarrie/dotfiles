commit() {
	git add .
	# shellcheck disable=SC2016
	git commit --all --message "$ $(history 2 | head -1 | ruby --disable-all -ne 'puts $_.split(" ", 2).last')"
	git show --format=medium --no-patch --stat
}
