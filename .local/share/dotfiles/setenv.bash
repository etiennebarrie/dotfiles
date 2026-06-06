setenv() {
	if [ $# -eq 0 ]; then
		[ ! -v setenv_UNSETENV ] || eval -- "$setenv_UNSETENV"
		return
	fi
	[ -v setenv_UNSETENV ] || printf -v setenv_UNSETENV "PS1=%q\nunset setenv_UNSETENV\n" "$PS1"
	for var do
		setenv_UNSETENV="unset ${var%%=*}; $setenv_UNSETENV"
	done
	PS1="${PS1}${*} "
	export "${@?}"
}
