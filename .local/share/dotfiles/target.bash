target() {
	[[ $# = 0 && -v make_target ]] && { unset make_target; return 0; }
	if [[ $# -ne 1 || -z $1 || ! -d target/$1/ ]]; then
		local targets choice
		_comp_compgen -v targets -C target -- -d
		printf -v choice "%s|" "${targets[@]#target/}"
		>&2 echo "usage: target ${choice%|}"
		return 1
	fi
	# shellcheck disable=SC2034
	make_target=$PWD/target/$1
}
