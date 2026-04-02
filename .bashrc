if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local
fi
[[ ! $- = *i* ]] && return

alias ..='cd ..'
alias ...='cd ../..'

if [[ -n $HOMEBREW_PREFIX && -r $HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh ]]; then
	source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
elif [[ -r /usr/lib/git-core/git-sh-prompt ]]; then
	source /usr/lib/git-core/git-sh-prompt
fi

# shellcheck disable=SC2034
GIT_PS1_SHOWSTASHSTATE=1
# shellcheck disable=SC2154
PS1='$(r=$?;(( $r )) && echo "\[\e[1;31m\]✘$r\[\e[m\] ")'
PS1_short_path() {
	local pwd IFS p
	pwd=$PWD IFS=:
	for p in $CDPATH; do
		pwd=${pwd#"$p/"}
	done
	echo "${pwd//~/\~}"
}
PS1=$PS1'$(PS1_short_path)$(__git_ps1 " (%s)")'
PS1=$PS1'$(echo "${shell_ruby:+ \[\e[2;31m\]ruby:\[\e[1;91m\]}${shell_ruby-}${shell_ruby:+\[\e[m\]}")'
PS1=$PS1'${make_target:+ [}${make_target#*\/target/}${make_target:+]}'
PS1=$PS1' \$ '

if [[ -n $SSH_CONNECTION || $OSTYPE != darwin* ]]; then
	PS1='\[\e]1;\w — \u@\H\e\\\]\[\033[01;32m\]\u@\H\[\033[00m\] '"$PS1"
fi
# shellcheck disable=SC2016
PROMPT_COMMAND+=('printf "\e[7m⏎\e[0m%$((COLUMNS-1))s\\r"')

source ~/.local/share/dotfiles/autoload.bash

autoload c
autoload commit
autoload demo
autoload make
autoload mkdird
autoload setenv
autoload target

unset autoload

alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc'
o() { open "${@:-.}"; }

rb() {
	if [[ $1 != -* ]]; then
		set -- -e "puts(($*))"
	fi
	ruby --disable=gems --enable=frozen-string-literal -I ~/.local/lib/ruby -rb "$@"
}
if ! type -f rb >&/dev/null; then
	echo '#!/bin/bash' >| ~/.local/bin/rb &&
	type rb | tail +2  >> ~/.local/bin/rb &&
	echo 'rb "$@"'     >> ~/.local/bin/rb &&
	chmod +x              ~/.local/bin/rb
fi

alias rg='RIPGREP_CONFIG_PATH=~/.config/ripgrep rg'

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
if type bat &>/dev/null; then
	alias cat=bat
elif type batcat &>/dev/null; then
	alias cat=batcat
fi
alias s='bin/rails server'

if type mvim &>/dev/null; then
	alias vi=vim
	alias bundle='BUNDLER_EDITOR=mvim bundle'
fi

alias brew='HOMEBREW_NO_ENV_HINTS=1 brew'

clone() {
	local command
	command=$(command clone "$@") || return $?
	case $command in
		(cd:*) cd "${command#cd:}" || return $?;;
	esac
}

dif() {
	git diff --no-index "$@"
}

io() {
	"$@" 2> >(sed 's/^/err: /') > >(sed 's/^/out: /')
}

HISTSIZE=100000
HISTCONTROL='ignoreboth:erasedups'
HISTIGNORE='git ci *:git co *:git pf:git pull:git s*:m *'
shopt -s histappend lithist

alias j=jobs
alias kk='kill %%'
shopt -s checkjobs huponexit

export LESS=FRXx4i
tabs -4

-ruby() {
	local candidate shell='' version=${1-}
	[[ -v init ]] && shell=no
	# no version asked and using system or shell ruby: keep it
	[[ ! $version && ( ! -v ruby_path || -v shell_ruby ) ]] && return
	case $version in
		system)
			[[ ${ruby_path-} ]] && PATH=${PATH//"$ruby_path":/}
			unset ruby_path
			return ;;
		unset)
			[[ $ruby_path ]] && PATH=${PATH//"$ruby_path":/}
			ruby_path=
			unset shell_ruby
			return ;;
		'') [[ -r .ruby-version ]] && <.ruby-version read -r version || return 1 ;;
		*) : "${shell:=yes}" ;;
	esac
	for candidate in \
		~/.{ruby,rubies}/{"${version#ruby-}",ruby-"${version#ruby-}"}/bin
	do
		if [[ -x $candidate/ruby ]]; then
			[[ ${ruby_path-} ]] && PATH=${PATH//"$ruby_path":/}
			PATH=$candidate:$PATH
			ruby_path=$candidate
			[[ $shell = yes ]] && shell_ruby=${version}
			return 0
		fi
	done
	return 1
}
PROMPT_COMMAND+=("-ruby")
init=on "-ruby" "$(<~/.ruby-version)" || >&2 echo "Ruby wasn't found"
