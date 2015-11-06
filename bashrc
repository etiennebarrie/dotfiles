if which brew >/dev/null; then
	# brew install bash-completion
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		source $(brew --prefix)/etc/bash_completion
	fi
	source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
else
	source /etc/bash_completion
fi

PS1='\w$(__git_ps1 " (%s)") \$ '

alias mkdird='d=`date +%y%m%d`; mkdir $d; cd $d'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
alias o='open .'
alias m='mvim .'
function be { bundle check >/dev/null || bundle install && bundle exec $@; }
alias r='if ! touch tmp/restart.txt >/dev/null 2>&1; then mkdir -v tmp; touch tmp/restart.txt; fi'
alias vi=vim

alias s='bin/rails server'
alias c='bin/rails console'

export HISTSIZE=10000
shopt -s histappend

function remove-swf {
    rm -v ~/Downloads/*.swf
}

if ! type -t chruby >/dev/null; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi
