source ~/.posix/lib/colors.sh

function panic() {
	echo "$(small)[panic]$(reset)" "$@" >&2
	exit 1
}
