#!/bin/bash


# Declare variables
SHORTCUTS=(
	window_managers/i3/mode
	window_managers/i3/modes/navigate
	window_managers/i3/modes/resize
	window_managers/i3/modes/trade
)

# Remove all shortcuts file
rm -rf ~/.config/sxhkd/docs/shortcuts 2> /dev/null
touch ~/.config/sxhkd/docs/shortcuts

for SHORTCUT in ${SHORTCUTS[@]}; do
	# Shortcuts
	# 1. Grabs commands and adds column and row tags
	# 2. Grabs description and adds column and row tags
	# 3. Removes newlines (put everything on one line with new column and row tags)
	# 4. Grabs data using delimiters and puts it in correct format
	cat ~/.config/sxhkd/hotkeys/$SHORTCUT \
		| sed '/#;/{n;s/\(.*\)/🅒\1\🅒🅡/}' \
		| sed 's/#;\s*\(.*\)\s*/🅡🅒\1🅒/' \
		| tr -d '\n' \
		| grep -o '🅡[^🅡]*🅡' \
		| sed 's/🅡🅒\(.*\)🅒🅒\(.*\)🅒🅡/\1\---\2/' \
		> ~/.config/sxhkd/docs/$SHORTCUT

	# Add to all shortcuts file
	cat ~/.config/sxhkd/docs/$SHORTCUT >> ~/.config/sxhkd/docs/shortcuts
done

