#!/bin/sh



# --- trying to get this working for a friend, it doesn't rn
# (ignore)


# 1. move up last line
# 2. clear line
# 3. go to start of line
# 4. print blank space size of $PS1
# 5. print char
# 6. go to start of line
#    as $PS1 will reprint

printf "%b%b%b%s%b%b" \
    "\e[1A" \
    "\033[2K" \
    "\r" \
    "          " \
    "\\u2764" \
    "\r" >> /dev/stdin
