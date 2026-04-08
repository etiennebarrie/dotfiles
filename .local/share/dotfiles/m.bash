m() {
	if [ $# -ne 0 ]; then
		local d dir="$1" IFS=: p
		shift
		if [[ "$dir" = /* ]]; then
			 mvim "$dir" "+cd $dir" "$@"; return
		fi
		for p in $CDPATH; do
			d="$p"/"$dir"
			if [ -d "$d" ]; then
				mvim "$d" "+cd $d" "$@"; return
			fi
		done
		set -- "$dir" "$@"
		mvim "$@"; return
	fi
	mvim "${@:-.}"
}
