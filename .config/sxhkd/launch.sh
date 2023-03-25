#!/bin/sh

# Remove previous instance of sxhkd
killall -9 sxhkd 2> /dev/null

# Update documentation

# Shortcuts
# 1. Grabs commands and adds column and row tags
# 2. Grabs description and adds column and row tags
# 3. Removes newlines (put everything on one line with new column and row tags)
# 4. Grabs data using delimiters and puts it in correct format
cat ~/.config/sxhkd/sxhkdrc \
	| sed '/#;/{n;s/\(.*\)/🅒\1\🅒🅡/}' \
	| sed 's/#;\s*\(.*\)\s*/🅡🅒\1🅒/' \
	| tr -d '\n' \
	| grep -o '🅡[^🅡]*🅡' \
	| sed 's/🅡🅒\(.*\)🅒🅒\(.*\)🅒🅡/\1\---\2/' \
	> ~/.config/sxhkd/docs/shortcuts

# Start new instance of sxhkd
sxhkd -c ~/.config/sxhkd/sxhkdrc -s /var/tmp/sxhkd_status.log -r /var/tmp/sxhkd_redirect.log &
