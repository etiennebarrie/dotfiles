if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local
fi
[[ $- = *i* ]] || return

alias ..='cd ..'
alias ...='cd ../..'

if [ -r "${HOMEBREW_PREFIX:-/usr/}/share/bash-completion/bash_completion" ]; then
	source "${HOMEBREW_PREFIX:-/usr/}/share/bash-completion/bash_completion"
fi
_git_lb() { _git_log; }

# shellcheck disable=SC2034
GIT_PS1_SHOWSTASHSTATE=1
# shellcheck disable=SC2154
PS1='$(r=$?;(( $r )) && echo "\[\e[1;31m\]✘$r\[\e[m\] ")'
PS1_short_path() {
	local pwd=$PWD IFS=:
	for p in $CDPATH; do
		pwd=${pwd#"$p/"}
	done
	echo "${pwd//~/\~}"
}
PS1="$PS1"'$(PS1_short_path)$(__git_ps1 " (%s)") \$ '
if [[ -n $SSH_CONNECTION || $OSTYPE != darwin* ]]; then
	PS1='\[\e]1;\w — \u@\H\e\\\]\[\033[01;32m\]\u@\H\[\033[00m\] '"$PS1"
fi
PROMPT_COMMAND='printf "\e[7m⏎\e[0m%$((COLUMNS-1))s\\r"'";$PROMPT_COMMAND"

mkdird() {
	local d
	d=~/$(date +%F)
	mkdir "$d"
	cd "$d" || return 1
}
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc'
o() { open "${@:-.}"; }

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
complete -o bashdefault -o default -o nospace -F _cd m

alias r='if ! touch tmp/restart.txt >/dev/null 2>&1; then mkdir -v tmp; touch tmp/restart.txt; fi'
alias vi=vim
if type bat &>/dev/null; then
	alias cat=bat
elif type batcat &>/dev/null; then
	alias cat=batcat
fi
alias s='bin/rails server'
c() {
	if [ -x bin/console ]; then
		bin/console "$@"
	else
		bin/rails console "$@"
	fi
}

demo() {
	if [ -n "$OLD_PS1$OLD_PS2$OLD_PROMPT_COMMAND" ]; then
		PS1="$OLD_PS1"
		PS2="$OLD_PS2"
		PROMPT_COMMAND="$OLD_PROMPT_COMMAND"
		unset OLD_PS1 OLD_PS2 OLD_PROMPT_COMMAND
	else
		OLD_PS1="$PS1"
		OLD_PS2="$PS2"
		OLD_PROMPT_COMMAND="$PROMPT_COMMAND"
		PS1="\$ " PS2="" PROMPT_COMMAND=""
	fi
}

clone() {
	local command
	command=$(env clone "$@") || return $?
	case $command in
		(cd:*) cd "${command#cd:}" || return $?;;
	esac
}

commit() {
	git add .
	# shellcheck disable=SC2016
	git commit --all --message "$ $(history 2 | head -1 | ruby --disable-all -ne 'puts $_.split(" ", 2).last')"
}
io() {
	"$@" 2> >(sed 's/^/err: /') > >(sed 's/^/out: /')
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
complete -o default setenv

HISTSIZE=100000
HISTCONTROL='ignoreboth:erasedups'
HISTIGNORE='git ci *:git co *:git pf:git pull:git s*:m *'

shopt -s histappend
export LESS=FRXx4i
tabs -4

if ! type -t chruby >/dev/null && [ -d "${HOMEBREW_PREFIX:-/usr/local}/share/chruby" ]; then
	source "${HOMEBREW_PREFIX:-/usr/local}/share/chruby/chruby.sh"
	source "${HOMEBREW_PREFIX:-/usr/local}/share/chruby/auto.sh"
fi

# https://twitter.com/tpope/status/165631968996900865
PATH=.git/safe/../../bin:$PATH
