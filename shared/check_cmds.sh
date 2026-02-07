
function check_cmds() {
    for cmd in "$@"; do
        command -v $cmd &> /dev/null && continue;
        /usr/lib/command-not-found -- "$cmd"
    done
};
