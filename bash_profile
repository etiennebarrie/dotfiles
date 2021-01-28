export LANG=en_US.UTF-8

[ -d "${brewpath:=/opt/homebrew}" ] || unset brewpath
export PATH=~/bin:~/.cargo/bin:/usr/local/bin${brewpath:+:$brewpath/bin}:/usr/bin:/bin${brewpath:+:$brewpath/sbin}:/usr/sbin:/sbin
export CDPATH=.:~/src/github.com

export NODE_PATH=node_modules:/usr/local/lib/node:/usr/local/lib/node_modules
export GOPATH=~

if which mvim >/dev/null; then
	export EDITOR="mvim -f"
	export BUNDLER_EDITOR="mvim"
else
	export EDITOR=vim
fi

source ~/.bashrc
