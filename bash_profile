if which mvim >/dev/null; then
	export EDITOR="mvim -f"
	export BUNDLER_EDITOR="mvim"
else
	export EDITOR=vim
fi
export LC_CTYPE=en_US.UTF-8
export PATH=/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
export NODE_PATH=node_modules:/usr/local/lib/node:/usr/local/lib/node_modules

source ~/.bashrc
