demo() {
	if [[ ! -v demo_save ]]; then
		demo_save="unset PS0 PS1 PS2 PS3 PS4 PROMPT_COMMAND demo_save;"$(
			declare -p   PS0 PS1 PS2 PS3 PS4 PROMPT_COMMAND 2>/dev/null |
				sed -e 's/^declare -. //')
		unset PS0 PS2 PS3 PROMPT_COMMAND
		PS1="\$ " PS4="+ "
	else
		eval -- "$demo_save"
	fi
}
