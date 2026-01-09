src_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $src_dir/colors.sh


function trace() {
    for frame in "${BASH_SOURCE[@]:1}"; do
        echo "    at ${frame}" >&2
    done
}

# For use in shell-level functions
#
# # This will not exit the login shell, but will terminate the current script
#
function throw() {
    local trace=false
    local args=("$@");
    if [[ " $@ " =~ " --trace " ]]; then
        args=("${args[@]/--trace/}");
        trace=true
    fi
    echo "$(small)[error]$(reset)" "${args[@]}" >&2
    [ "$trace" = true ] && trace ;

	kill -INT $$
}

# For use in command-level scripts
# # This will exit the entire script with a status code of 1
#
# > Warning: This will exit the entire shell if sourced in a login shell
function panic() {
    local trace=false
    local args=("$@");
    if [[ " $@ " =~ " --trace " ]]; then
        args=("${args[@]/--trace/}");
        trace=true
    fi

	echo "$(small)[panic]$(reset)" "${args[@]}" >&2
	[ "$trace" = true ] && trace ;

	exit 1
}


unset src_dir
