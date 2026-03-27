demo() {
	if [[ ! -v demo_save ]]; then
		demo_save=$(declare -p PS1 PS2 PROMPT_COMMAND | sed -e 's/^declare -. //')
		PS1="\$ " PS2="" PROMPT_COMMAND=()
	else
		eval -- "$demo_save"
		unset demo_save
	fi
}
