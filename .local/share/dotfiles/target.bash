target() {
	[[ $# = 0 ]] && { unset make_target; return 0; }
	if [[ $# -gt 1 || ! -d target/"$1" ]]; then
		local targets=()
		while read -r target; do
			targets+=("${target#target/}")
		done < <(find target -d -depth 1)
		printf -v targets "%s|" "${targets[@]}"
		>&2 echo "usage: target ${targets%?}"
		return 1
	fi
	# shellcheck disable=SC2034
	make_target=target/$1
}
