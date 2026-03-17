setenv() {
	[[ -z $NO_ENV_PS1 ]] && NO_ENV_PS1=$PS1
	if [ $# -eq 0 ]; then
		PS1=$NO_ENV_PS1
		unset NO_ENV_PS1
		eval "$setenv_UNSETENV"
		unset setenv_UNSETENV
		return
	fi
	for var do
		setenv_UNSETENV="unset ${var%%=*}; $setenv_UNSETENV"
	done
	PS1="${PS1}${*} "
	export "${@?}"
}
