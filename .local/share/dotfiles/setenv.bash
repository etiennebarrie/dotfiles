setenv() {
	if [ $# -eq 0 ]; then
		[ ! -v setenv_UNSETENV ] || eval -- "$setenv_UNSETENV"
		return
	fi
	[ -v setenv_UNSETENV ] || printf -v setenv_UNSETENV "PS1=%q\nunset setenv_UNSETENV\n" "$PS1"
	for var do
		local name=${var%%=*}
		setenv_UNSETENV+="unset $name"$'\n'
		PS1+="$name=\${$name} "
	done
	export "${@?}"
}
