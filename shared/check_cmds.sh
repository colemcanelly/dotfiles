src_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $src_dir/errors.sh

function check_cmds() {
    for cmd in "$@"; do
        if command -v $cmd &> /dev/null; then continue; fi
        throw "Command '$cmd' not found"
    done
};

unset src_dir
