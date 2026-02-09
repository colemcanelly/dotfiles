#!/usr/bin/env bash

# Author: Cole McAnelly
# Description: This script automates the setup of dotfiles from a GitHub repository

check_cmds() {
	local fail="false"
	for cmd in "$@"; do
		command -v $cmd &> /dev/null && continue;
		printf '%s: command not found\n' "$cmd"
		fail="true"
	done
	$fail && exit 1
};

panic() {
	echo "$1" >&2
	exit 1
}

reqs=($(curl -fsS https://raw.githubusercontent.com/colemcanelly/dotfiles/refs/heads/master/requirements.txt))
check_cmds git "${reqs[@]}"


generate_ssh_key() {
	echo "Generating SSH key..."
	read -p "Enter your email for SSH key: " email
	ssh-keygen -t ed25519 -C "$email"
}

check_ssh_key() {
	ssh -T git@github.com
	case $? in
		1|0)	return 0 ;;
		*)	return 1 ;;
	esac
}

load_ssh_key() {
	./packages/utils/.local/lib/auth/ssh-login.sh || panic "Failed to load SSH key. Please check your SSH configuration and try again."
}

verify_ssh_key() {
	while ! verify_ssh_key; do
		echo "SSH key verification failed. Please ensure your SSH key is added to your GitHub account and try again."
		read -p "Press Enter to retry..."
	done
}

setup_ssh() {
	test -f $HOME/.ssh/id_ed25519 || generate_ssh_key
	load_ssh_key
	verify_ssh_key || exit 1

	repo_ssh="git@github.com:colemcanelly/dotfiles.git"
	git remote set-url origin $repo_ssh || panic "Failed to set remote URL. Please check your SSH key and try again."
}

download() {
	local loc="$HOME/.config/.dotfiles"
	test -d $loc && panic "Nothing to do"
	mkdir -p $(dirname $loc)

	local repo_https="https://github.com/colemcanelly/dotfiles.git"

	git clone $repo_https $loc || panic "Failed to clone repository. Please check your internet connection and try again."
	cd $loc
}

download_submodules() {
	git submodule update --init --recursive || panic "Failed to download submodules. Please check your internet connection and try again."
}


main() {
	download
	setup_ssh || panic "SSH setup failed."
	download_submodules
	./install || panic "Installation failed."

	echo "Setup complete! Your dotfiles have been installed and your SSH key is configured for GitHub."
}
main
