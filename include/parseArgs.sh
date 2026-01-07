
usage() {
	msg=$(cat <<-EOF
		Installs dotfiles to home directory using GNU Stow.

		Usage: $1 [options] [tool1 tool2 ...]

		Arguments:
		  tool              (Optional) Name of the tool/directory to stow (e.g., vim, zsh). If no tools are specified, all tools will be stowed.

		Options:
		  -s, --simulate    Simulate the installation without making changes
		  -R, --restow      Restow all directories, even if they are already stowed
		  -l, --list        List all available tools
		  -h, --help        Show this help message

		EOF
	)
	echo "$msg"
}


list() {
    ls -d !(include|backups|test)/ | sed 's/\/$//g'
}


# Parse options and collect tool names
while [[ $# -gt 0 ]]; do
	arg="$1"
	case "$arg" in
	-v|--version)
		printf "${NAME} - Install dotfiles using GNU Stow\nv${VERSION}\n"
		exit 0
		;;
	-h|--help)
		usage $NAME
		exit 0
		;;
	-l|--list)
        list
        exit 0
        ;;
	--name)
		shift
		NAME="$1"
		shift
		;;
	--name=*)
		shift
		NAME="${arg#*=}"
		;;
	-R|--restow) shift; RESTOW=true ;;
	-s|--simulate) shift; SIMULATE=true ;;
	-*|--*) panic "Error: Unsupported flag $arg" ;;
	*)
		if [[ " $(echo */) " =~ " ${arg%/}/ "  ]]; then
			shift
			tool_args+=("${arg}")
		else
			panic "Error: Invalid argument $arg";
		fi ;;
	esac
done
