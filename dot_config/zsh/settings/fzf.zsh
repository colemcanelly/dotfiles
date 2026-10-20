#!/usr/bin/env zsh


export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules"


export FZF_CTRL_R_COMMAND=	# disable fzf ctrl-r
export FZF_TMUX_OPTS="-p 80%,60%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '
if [ -d {} ]; then
	eza --tree --color=always {};
else bat -n --color=always {};
fi'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

source <(fzf --zsh)
