m() (
	local cdpath project=$PWD IFS=:
	for cdpath in $CDPATH; do
		project=${project#"$cdpath/"}
		if (( ${#PWD} != ${#project} )); then
			project=${project#*/}
			break
		fi
	done
	local args
	[[ $project ]] && args=(--servername "$project")
	if [[ $# = 0 ]]; then
		if [[ $project ]] && gvim --serverlist | grep -qixF "$project"; then
			args+=(--remote-expr 'foreground()')
			exec 2>/dev/null # --remote-expr prints an error
		elif git rev-parse --git-dir &>/dev/null; then
			args+=(+:0G)
			git rev-parse --show-toplevel &>/dev/null && args+=(+:GFiles)
		else
			args+=(.)
		fi
	else
		args+=(--remote-tab-silent "$@")
	fi
	exec gvim "${args[@]}"
)
