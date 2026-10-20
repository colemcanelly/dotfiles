src_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

source $src_dir/functions.sh
# source $src_dir/prompt.sh
# source ~/.local/lib/auth/ssh-login.sh
eval $(keychain --eval id_ed25519)

eval "$(starship init bash)"

unset src_dir
