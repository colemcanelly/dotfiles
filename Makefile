.PHONY: clean profile profile-clean dry

# Bash Profile installation
profile:
	bash ./bash/.profile/.install.sh install

profile-clean:
	bash ./bash/.profile/.install.sh clean


# Testing
dry:
	stow --verbose --simulate --target=$$HOME --restow */


# Main installation
all:
	stow --verbose --target=$$HOME --restow */

clean:
	clean-profile
	stow --verbose --target=$$HOME --delete */