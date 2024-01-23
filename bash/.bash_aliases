# My custom aliases:

# `ls` command
#   -a      all
#   -A      all, but exclude `.` and `..`
#   -l      <permissions> <#links> <owner> <group> <size> <time> <file>
#   -g      exclude owner
#   -o      exclude group
#   -h      human readable sizes
#   -F      classify (*/=>@|)
#   -R      recursive
#   -1      One per line

alias l='ls -F --group-directories-first'
alias la='ls -A'
alias ll='l -o'
alias lv='la -lF'
alias lr='la -FR'

# Remove "Zone.Identifier files"
alias rmzi='find . -type f | grep ":Zone.Identifier" | xargs rm'

# For reminding me how to use ansi escape colors
alias colors='~/bin/ansi_colors'

# Launching Notepad from WSL Ubuntu
alias npp="/mnt/c/Windows/System32/notepad.exe"

# For redirecting to Windows clipboard
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"