#!/usr/bin/env bash

_PROFILE="./bash/.bash_profile"


# Ask Y/n
function ask () {
    read -p "$1 (Y/n): " resp
    if [ -z "$resp" ]; then
        response_lc="y" # empty is Yes
    else
        response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitsive
    fi 

    [ "$response_lc" = "y" ]
}


# Remove dotfiles from profile
function clean () {
    if ask "Remove dotfiles from profile?"; then
        sed -i '/dotfiles/d' "$_PROFILE"
    fi
}

# Install dotfiles into profile
function install () {
    echo "running install"
    echo >> $_PROFILE
    echo '# >>> Install Custom dotfiles >>>' >> $_PROFILE
    # Ask which files should be sourced
    echo "Do you want $_PROFILE to source: "
    for file in ./bash/.profile/*; do
        if [ -f "$file" ] && [ $(basename "$file") != ".install.sh" ]; then
            # echo $(basename "$file")
            filename=$(basename "$file")
            if ask "${filename}?"; then
                echo "source $(realpath "$file")" >> "$_PROFILE"
            fi
        fi
    done
    echo '# <<< Install Custom dotfiles <<<' >> $_PROFILE
}

case $1 in
    clean) "$@"; exit;;
    install) "$@"; exit;;
esac