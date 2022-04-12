export LANG=en_US.UTF-8

export PATH=~/bin:~/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export CDPATH=.:~/src/github.com

export NODE_PATH=node_modules:/usr/local/lib/node:/usr/local/lib/node_modules
export GOPATH=~

for HOMEBREW_PREFIX in /opt/homebrew /usr/local ; do
	if [[ -x "$HOMEBREW_PREFIX/bin/brew" ]]; then
		eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
		break
	fi
done
export HOMEBREW_NO_ENV_HINTS=1

if which mvim >/dev/null; then
	export EDITOR="mvim -f"
	export BUNDLER_EDITOR="mvim"
else
	export EDITOR=vim
fi

source ~/.bashrc
