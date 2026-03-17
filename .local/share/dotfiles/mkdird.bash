mkdird() {
	local d
	d=~/tmp/$(date +%F)
	mkdir "$d"
	cd "$d" || return 1
}
