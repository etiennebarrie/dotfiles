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

mkdird() {
	local d
	d=$(date +%F)
	mkdir "$d"
	cd "$d" || return 1
}
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
o() { open "${@:-.}"; }
m() { mvim "${@:-.}"; }
alias r='if ! touch tmp/restart.txt >/dev/null 2>&1; then mkdir -v tmp; touch tmp/restart.txt; fi'
alias vi=vim

alias s='bin/rails server'
alias c='[ -x bin/console ] && bin/console || bin/rails console'

export HISTSIZE=10000
export HISTCONTROL='ignoreboth:erasedups'
shopt -s histappend

if ! type -t chruby >/dev/null && [ -d /usr/local/share/chruby ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

# https://twitter.com/tpope/status/165631968996900865
export PATH=.git/safe/../../bin:$PATH
