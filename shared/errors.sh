source ~/.posix/lib/colors.sh


# For use in shell-level functions
#
# # This will not exit the login shell, but will terminate the current script
#
function throw() {
	echo "$(small)[error]$(reset)" "$@" >&2
	kill -INT $$
}

# For use in command-level scripts
# # This will exit the entire script with a status code of 1
#
# > Warning: This will exit the entire shell if sourced in a login shell
function panic() {
	echo "$(small)[panic]$(reset)" "$@" >&2
	exit 1
}
