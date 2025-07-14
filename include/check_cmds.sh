#!/usr/bin/env bash

function check_cmds() { 
    for cmd in "$@"; do
        if command -v $cmd &> /dev/null; then continue; fi
        echo "Error: $cmd is not installed." >&2
        exit 1
    done
};