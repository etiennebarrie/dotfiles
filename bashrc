# shellcheck disable=SC1090,SC1091
if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local
fi

if command -v brew >/dev/null; then
	# brew install bash-completion
	if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
		source "$(brew --prefix)"/etc/bash_completion
	fi
else
	source /etc/bash_completion
fi

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
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
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

export HISTSIZE=10000
export HISTCONTROL='ignoreboth:erasedups'
shopt -s histappend

if ! type -t chruby >/dev/null && [ -d /usr/local/share/chruby ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

# https://twitter.com/tpope/status/165631968996900865
export PATH=.git/safe/../../bin:$PATH
