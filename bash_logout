# clear console on logout
[ "$SHLVL" = 1 ] &&
	[ -x /usr/bin/clear_console ] &&
	/usr/bin/clear_console -q

# clear tab title on SSH connections
echo -e "\033]0;\033\\"
