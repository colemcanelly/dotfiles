#!/usr/bin/env zsh


bindkey -e

bindkey "\E[1;5C" emacs-forward-word	# Ctrl + Right Arrow
bindkey "\E[1;5D" emacs-backward-word	# Ctrl + Left Arrow

bindkey "\E[1~" beginning-of-line			# Home
bindkey "\E[4~" end-of-line					# End
bindkey "\E[H" beginning-of-line
bindkey "\E[F" end-of-line
bindkey "\E[3~" delete-char					# Delete
bindkey '^H' backward-kill-word				# Ctrl + Backspace
bindkey '\E[3;5~' kill-word					# Ctrl + Delete
