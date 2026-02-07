

not_found() {
	if test -x /usr/lib/command-not-found; then
		/usr/lib/command-not-found -- "$1"
	else
		echo "Command '$1' not found."
	fi
}


function check_cmds() {
    for cmd in "$@"; do
        command -v $cmd &> /dev/null && continue;
        not_found "$cmd"
    done
};
