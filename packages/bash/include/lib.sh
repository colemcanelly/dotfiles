src_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

source $src_dir/functions.sh
source $src_dir/prompt.sh
source ~/.local/lib/auth/ssh-login.sh


unset src_dir
