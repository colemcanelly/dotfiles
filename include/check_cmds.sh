#!/usr/bin/env bash

function check_cmds() { 
    for cmd in "$@"; do
        if command -v $cmd &> /dev/null; then continue; fi
        panic "Error: $cmd is not installed."
    done
};