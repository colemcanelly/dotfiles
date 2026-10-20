setopt extendedglob

for f in ~/.config/zsh/settings/*.zsh~*lib.zsh; do source $f; done
