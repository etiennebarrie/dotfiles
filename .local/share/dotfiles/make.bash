make() {
	[[ -v make_target && $1 != "-C" ]] &&
		set -- -C "${make_target#"$PWD"/}" -j "$(getconf _NPROCESSORS_ONLN)" "$@"
	command make "$@"
}
