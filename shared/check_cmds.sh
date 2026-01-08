source ~/.posix/lib/errors.sh

function check_cmds() {
    for cmd in "$@"; do
        if command -v $cmd &> /dev/null; then continue; fi
        throw "Error: $cmd is not installed."
    done
};
