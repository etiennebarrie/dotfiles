wt() {
	[[ $# == 1 ]] || { >&2 echo "usage: ${FUNCNAME[0]} branch"; return 1; }
	local dir=../$1
	git worktree list --porcelain | grep -qFx "branch refs/heads/$1" ||
		git worktree add "$dir" "$1"
	cd "$dir" || return
}
