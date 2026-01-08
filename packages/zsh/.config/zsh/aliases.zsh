source ~/.bash_aliases

# Bulk Rename/Move/Copy/Link
autoload -Uz zmv
alias zcp='zmv -C'
alias zln='zmv -L'

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'