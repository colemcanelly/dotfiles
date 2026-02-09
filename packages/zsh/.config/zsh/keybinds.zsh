#!/usr/bin/env zsh


bindkey "^[[1;5C" emacs-forward-word
bindkey "^[[1;5D" emacs-backward-word

bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line
bindkey "\E[H" beginning-of-line
bindkey "\E[F" end-of-line
bindkey "\E[3~" delete-char
