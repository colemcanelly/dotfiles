#!/usr/bin/env bash

# Cole McAnelly

# For Git PS1
# source /usr/lib/git-core/git-sh-prompt;
source ~/.bash_git;
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWUPSTREAM="verbose"

__myps1_inject_exitcode() {
    local code=$1
    local reset=`tput sgr0`;

    if [ "$code" -ne "0" ]; then
        local red=`tput setaf 1`;
        local ex="✗";
        echo "${red} ${ex}"
    else
        local green=`tput setaf 34`;
        local check="✓";
        echo "${green} ${check}"
    fi
}

__myps1() {
    local reset=`tput sgr0`;
    
    # background
    local bg_gray=`tput setab 240`;
    
    # text
    local bold=`tput bold`;
    local white=`tput setaf 7`;
    local git_color=`tput setaf 213`;
    local main_color=`tput setaf 032`;

    # symbols
    local prompt_char="$";

    if [ "`id -u`" -eq 0 ]; then    # root
        prompt_char="#"
        main_color=`tput setaf 1`;  # red
        git_color=`tput setaf 214`; # gold
    fi

    local INIT='${debian_chroot:+($debian_chroot)}';
    
    # Symbols
    local ARROW="➜\[${reset}\]";
    local BOX_TOP="\n\[${main_color}\]╭╴\[${reset}\]";
    local BOX_BOT="\n\[${main_color}\]╰╴\[${reset}\]";

    # Information
    local EXIT="\[${bg_gray}\]\$(__myps1_inject_exitcode \$?)";
    local TIME="\[${white}\] \t \[${reset}\]"
    local USER="\[${main_color}\]\u\[${reset}\]";
    local DIR=" [\[${main_color}\]\W\[${reset}\]]";
    local GIT="\$(__git_ps1 '(\[${git_color}\]%s\[${reset}\])')";
    local PROMPT="\[${bold}\]${prompt_char}\[${reset}\] ";

    local ps1="$BOX_TOP$(__myps1_debian_chroot)$EXIT $TIME $USER $ARROW $DIR $GIT $BOX_BOT$PROMPT";

    echo "$ps1";
}

# To test, for example, print output before changes and after changes
# and see if the diff is correct.
# Uncomment for testing:
# __myps1;

PS1="$(__myps1)"; export PS1;
