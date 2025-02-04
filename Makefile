.PHONY: all clean profile profile-clean dry adopt install

all: adopt install


# Bash Profile installation
profile:
	bash ./bash/.profile/.install.sh install

profile-clean:
	bash ./bash/.profile/.install.sh clean


# Testing
dry:
	stow --verbose --simulate --dotfiles --target=$$HOME */


# Main installation
install: profile-clean profile
	stow --dotfiles --target=$$HOME --restow */

adopt:
	stow --adopt --dotfiles --target=$$HOME */
	git clean -f


clean: clean-profile
	stow --verbose --dotfiles --target=$$HOME --delete */