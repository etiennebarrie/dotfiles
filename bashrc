if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local
fi

if which brew >/dev/null; then
	# brew install bash-completion
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		source $(brew --prefix)/etc/bash_completion
	fi
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
export HISTCONTROL='ignoreboth:erasedups'
shopt -s histappend

function remove-swf {
    rm -v ~/Downloads/*.swf
}

if ! type -t chruby >/dev/null && [ -d /usr/local/share/chruby ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

# GPG
if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

# https://twitter.com/tpope/status/165631968996900865
export PATH=.git/safe/../../bin:$PATH
