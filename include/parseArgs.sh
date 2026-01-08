

shopt -s extglob


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
    command ls -1 $ROOT_DIR/packages/
}


parseArgs() {
    local tool_args=();
    local default_dirs=($(list));
    local name="${0}"

    # Parse options and collect tool names
    while [[ $# -gt 0 ]]; do
    	arg="$1"
    	case "$arg" in
    	-v|--version)
    		printf "${name} - Install dotfiles using GNU Stow\nv${VERSION}\n"
    		exit 0
    		;;
    	-h|--help)
    		usage $name
    		exit 0
    		;;
    	-l|--list)
            list
            exit 0
            ;;
    	--name)
    		shift
    		name="$1"
    		shift
    		;;
    	--name=*)
    		shift
    		name="${arg#*=}"
    		;;
    	-R|--restow) shift; RESTOW=true ;;
    	-s|--simulate) shift; SIMULATE=true ;;
    	-*|--*) panic "Error: Unsupported flag $arg" ;;
    	*)
    		if [[ " ${default_dirs[*]} " =~ " ${arg%/} "  ]]; then
    			shift
    			tool_args+=("${arg}")
    		else
    			panic "Error: Invalid argument $arg";
    		fi ;;
    	esac
    done

    DIRS=("${tool_args[@]:-"${default_dirs[@]}"}")
}
