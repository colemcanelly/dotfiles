#!/usr/bin/env bash

# Author: Cole McAnelly
# Description: This script automates the setup of dotfiles from a GitHub repository
# Run: curl -sSL https://raw.githubusercontent.com/colemcanelly/dotfiles/refs/heads/master/download.sh | bash

check_cmds() {
	local fail="false"
	for cmd in "$@"; do
		command -v "$cmd" &> /dev/null && continue;
		printf '%s: command not found\n' "$cmd"
		fail="true"
	done
	$fail && exit 1
};

panic() {
	echo "$1" >&2
	exit 1
}

REQS=($(curl -fsS https://raw.githubusercontent.com/colemcanelly/dotfiles/refs/heads/master/requirements.txt))
check_cmds git curl "${REQS[@]}"

REPO_SSH="git@github.com:colemcanelly/dotfiles.git"
SSH_AGENT_SCRIPT="$(curl -sSL https://raw.githubusercontent.com/colemcanelly/dotfiles/refs/heads/master/packages/utils/.local/lib/auth/ssh-login.sh)"


generate_ssh_key() {
	echo "Generating SSH key..."
	read -p "Enter your email for SSH key: " email
	ssh-keygen -t ed25519 -C "$email"
}

load_ssh_key() {
	bash <<< "$SSH_AGENT_SCRIPT" || panic "Failed to load SSH key"
}

check_ssh_key() {
	ssh -T git@github.com
	case $? in
		1|0)	return 0 ;;
		*)	return 1 ;;
	esac
}

verify_ssh_key() {
	while ! check_ssh_key; do
		echo "SSH key verification failed. Please ensure your SSH key is added to your GitHub account and try again."
		read -p "Press Enter to retry..."
	done
}

setup_ssh() {
	test -f $HOME/.ssh/id_ed25519 || generate_ssh_key
	load_ssh_key
	verify_ssh_key || exit 1

	git remote set-url origin $REPO_SSH || panic "Failed to set remote URL"
}

download() {
	local loc="$HOME/.config/.dotfiles"
	test -d "$loc" && panic "Nothing to do"
	mkdir -p $(dirname "$loc")

	git clone --recursive "$REPO_SSH" "$loc" || panic "Failed to clone repository"
	cd "$loc" || panic "Failed to change directory"
}

main() {
	setup_ssh || panic "SSH setup failed."
	download
	./install || panic "Installation failed."

	echo "Setup complete! Your dotfiles have been installed and your SSH key is configured for GitHub."
}
main
