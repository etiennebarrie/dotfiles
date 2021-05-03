# shellcheck disable=SC1090,SC1091
if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local
fi

if command -v brew >/dev/null; then
	PREFIX="$(brew --prefix)"
	if [ -r "$PREFIX"/etc/bash_completion ]; then
		source "$PREFIX"/etc/bash_completion
	fi
else
	PREFIX=/usr/local
	if [ -r /etc/bash_completion ]; then
		source /etc/bash_completion
	fi
fi
_git_lb() { _git_log; }

PS1='\w$(__git_ps1 " (%s)") \$ '
if [[ -n "$SSH_CONNECTION" && $- = *i* ]]; then
	PS1='\[\e]1;\w — \u@\H\e\\\]\u@\H '"$PS1"
fi
PROMPT_COMMAND='printf "\033[7m⏎\033[0m%$((COLUMNS-1))s\\r"'";$PROMPT_COMMAND"

mkdird() {
	local d
	d=$(date +%F)
	mkdir "$d"
	cd "$d" || return 1
}
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc'
o() { open "${@:-.}"; }
m() {
	if [ $# -ne 0 ] && [ -d "$1" ]; then
		mvim "${@:-.}" "+cd $1";
	else
		mvim "${@:-.}";
	fi
}
alias r='if ! touch tmp/restart.txt >/dev/null 2>&1; then mkdir -v tmp; touch tmp/restart.txt; fi'
alias vi=vim

alias s='bin/rails server'
c() {
	if [ -x bin/console ]; then
		bin/console "$@"
	else
		bin/rails console "$@"
	fi
}
ci() { hub ci-status --verbose "${1:-@{upstream\}}"; }
demo() {
	if [ "$OLD_PS1" ]; then
		PS1="$OLD_PS1"
		unset OLD_PS1
	else
		OLD_PS1="$PS1"
		PS1="\$ "
	fi
}
clone() {
	eval "$(env clone "$@")"
}

setenv() {
	if [ -z "$NO_ENV_PS1" ]; then
		NO_ENV_PS1="$PS1"
	fi
	if [ $# -eq 0 ]; then
		PS1="$NO_ENV_PS1"
		unset NO_ENV_PS1
		eval "$UNSETENV"
		return
	fi
	for var do
		UNSETENV="unset ${var%%=*}; $UNSETENV"
	done
	PS1="${PS1}${*} "
	export "${@?}"
}

HISTSIZE=10000
HISTCONTROL='ignoreboth:erasedups'
shopt -s histappend
export LESS=FRXx4
tabs -4

if ! type -t chruby >/dev/null && [ -d ${PREFIX:-/usr/local}/share/chruby ]; then
  source ${PREFIX:-/usr/local}/share/chruby/chruby.sh
  source ${PREFIX:-/usr/local}/share/chruby/auto.sh
fi

# https://twitter.com/tpope/status/165631968996900865
PATH=.git/safe/../../bin:$PATH

unset PREFIX
