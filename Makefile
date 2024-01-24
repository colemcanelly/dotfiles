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
install: profile-clean profile
	stow --dotfiles --target=$$HOME --restow */

adopt:
	stow --adopt --dotfiles --target=$$HOME */
	git clean -f

all: adopt install

clean: clean-profile
	stow --verbose --dotfiles --target=$$HOME --delete */