


brokenSymlinks() {
    local target_path="$1"

    if [[ -L "$target_path" && ! -e "$target_path" ]]; then
        if [[ $SIMULATE == true ]]; then
            echo "$(yellow)Removing broken symlink: $target_path$(reset)"
        else
            echo "Removing broken symlink: $target_path"
            unlink "$target_path"
        fi
        return 0
    fi
    return 1
}

existingFiles() {
    local target_path="$1"

	if [[ -f "$target_path" && ! -L "$target_path" ]]; then
		if [[ $SIMULATE == true ]]; then
			echo "$(yellow)Backing up file: $target_path$(reset)"
		else
			echo "Backing up file: $target_path"
			# Use the full path from home directory for backup structure
			local rel_path="${target#$HOME/}"
			local backup_path="$backup_root/$(dirname "$rel_path")"
			mkdir -p "$backup_path"
			mv "$target_path" "$backup_path/"
		fi
		return 0
	fi
	return 1
}

# Function to backup directories
# Will read from stdin to get stow output, grep for conflicts, and handle them
function handle_conflicts() {
	local conflicts=($(rg '\* [\w\s]+: (\S*)' -or '$1' | sort | uniq))
	[[ ${#conflicts[@]} -eq 0 ]] && return -1;
	echo "$(bold)Install Conflicts:$(reset)"
	# echo "$(small)  backing up...$(reset)"
	printf "\t$(small)~/%s$(reset)\n" "${conflicts[@]}"

	local backup_root="$ROOT_DIR/backups"
	mkdir -p "$backup_root"

	for target in "${conflicts[@]}"; do
		target_path="$HOME/$target"

		brokenSymlinks "$target_path" \
		|| existingFiles "$target_path" \
		|| panic "Could not handle conflict for $target_path"

	done
}
