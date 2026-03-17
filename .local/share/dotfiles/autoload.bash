autoload() {
	local lib=${1?} fn dir
	dir=$(dirname "${BASH_SOURCE[0]}") || return
	for fn do
		eval "
			$fn() { : autoload
				source ${dir}/${lib}.bash || return
				$fn \"\$@\"
			}
			"
	done
}
