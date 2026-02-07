src_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $src_dir/colors.sh
unset src_dir


# ################# UTILS #################
function checkTrace() {
    local args=("$@");
    if [[ " $@ " =~ " --trace " ]]; then
        printf "${args[@]/--trace/}";
        return 1
    fi
    printf "${args[@]}";
    return 0
}

function trace() {
    for (( i = ${#FUNCNAME[@]} - 1; i > 0; --i )); do
        local func="${FUNCNAME[i]}"
        local line="${BASH_LINENO[i - 1]}"
        local src="${BASH_SOURCE[i]}"
        printf '%s\n' "     at $func() in $src:$line" >&2
    done
}

# ################# EXPORTS #################

# For use in shell-level functions
#
# # This will not exit the login shell, but will terminate the current script
#
function throw() {
    local args
    args=($( checkTrace "$@" ));
    local trace=$?;

    echo "$(small)[error]$(reset)" "${args[@]}" >&2
    ((trace)) && trace ;

	  kill -INT $$
}

# For use in command-level scripts
# # This will exit the entire script with a status code of 1
#
# > Warning: This will exit the entire shell if sourced in a login shell
function panic() {
    local args
    args=($( checkTrace "$@" ));
    local trace=$?;

  	echo "$(small)[panic]$(reset)" "${args[@]}" >&2
  	((trace)) && trace ;

  	exit 1
}
