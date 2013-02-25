if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi
source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
PS1='\w$(__git_ps1 " (%s)") \$ '

alias sc='./script/rails console'

alias mkdird='d=`date +%y%m%d`; mkdir $d; cd $d'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
alias o='open .'
alias m='mvim .'
alias be='bundle exec'
alias r='if ! touch tmp/restart.txt >/dev/null 2>&1; then mkdir -v tmp; touch tmp/restart.txt; fi'
alias vi=vim

export HISTSIZE=10000
shopt -s histappend
