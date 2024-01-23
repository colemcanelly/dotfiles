#!/usr/bin/env bash

# myps1
# (Mike Kasberg PS1)
# (Or, Make PS1)

# Modified by Cole McAnelly

# Different functions generate different parts (segments) of the PS1 prompt.
# Each function should leave the colors in a clean state (e.g. call reset if they changed any colors).

# For Git PS1
source /usr/lib/git-core/git-sh-prompt;
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWUPSTREAM="verbose"

# BLUE=`tput setaf 6`;
BLUE=`tput setaf 032`;

__myps1_debian_chroot() {
    # This string is intentionally single-quoted:
    # It will be evaluated when $PS1 is evaluated to generate the prompt each time.
    echo '${debian_chroot:+($debian_chroot)}';
}

__myps1_inject_exitcode() {
    local code=$1
    local reset=`tput sgr0`;

    if [ "$code" -ne "0" ]; then
        local red=`tput setaf 1`;
        local ex="✗";
        echo "${red} ${ex} ${reset}"
    else
        local green=`tput setaf 34`;
        local check="✓";
        echo "${green} ${check} ${reset}"
    fi
}

__myps1_exitcode() {
    # local bg_red=`tput setab 1`;
    local BG_GRAY=`tput setab 240`;
    local white=`tput setaf 15`;
    local reset=`tput sgr0`;

    # We need to run a function at runtime to evaluate the exitcode.
    echo "\[${BG_GRAY}\]\$(__myps1_inject_exitcode \$?)\[${reset}\]"
}

__myps1_time() {
    local BG_GRAY=`tput setab 240`;
    local white=`tput setaf 7`;
    local reset=`tput sgr0`;

    echo "\[${BG_GRAY}${white}\] \t \[${reset}\]"
}

__myps1_username() {
    local reset=`tput sgr0`;

    echo "\[${BLUE}\] \u \[${reset}\]";
}

__myps1_arrow() {
    local bold=`tput bold`;
    local reset=`tput sgr0`;

    echo "➜ \[${reset}\]";
}

__myps1_workdir() {
    local bold=`tput bold`;
    local reset=`tput sgr0`;

    # \w = Full path
    # \W = Working Dir

    echo "[\[${BLUE}\]\W\[${reset}\]]";
}

__myps1_git() {
    local magenta=`tput setaf 213`;
    local reset=`tput sgr0`;

    # Escaping the $ is intentional:
    # This is evaluated when the prompt is generated.
    echo "\$(__git_ps1 ' (\[${magenta}\]%s\[${reset}\])')"
}

__myps1_box_top() {
    local reset=`tput sgr0`;
    echo "\[${BLUE}\]╭╴\[${reset}\]"
}

__myps1_box_bottom() {
    local reset=`tput sgr0`;
    echo "\[${BLUE}\]╰╴\[${reset}\]"
}


__myps1_user_prompt() {
    local bold=`tput bold`;
    local reset=`tput sgr0`;
    
    echo "\[${bold}\]\$\[${reset}\] ";
}

__myps1() {
    local ps1="\n$(__myps1_box_top)$(__myps1_debian_chroot)$(__myps1_exitcode)$(__myps1_time)$(__myps1_username)$(__myps1_arrow) $(__myps1_workdir)$(__myps1_git)\n$(__myps1_box_bottom)$(__myps1_user_prompt)";

    echo "$ps1";
}

# To test, for example, print output before changes and after changes
# and see if the diff is correct.
# Uncomment for testing:
#__myps1;

PS1="$(__myps1)"; export PS1;