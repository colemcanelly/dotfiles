.PHONY: clean profile profile-clean dry

# Bash Profile installation
profile:
	bash ./bash/.profile/.install.sh install

profile-clean:
	bash ./bash/.profile/.install.sh clean


# Testing
dry:
	stow --verbose --simulate --dotfiles --target=$$HOME */


# Main installation
all:
	profile-clean
	profile
	stow --verbose --dotfiles --target=$$HOME --restow */

install:
	stow --verbose --adopt --dotfiles --target=$$HOME */
	git restore .
	all

clean:
	clean-profile
	stow --verbose --dotfiles --target=$$HOME --delete */