#!/usr/bin/env bash


function panic() {
	echo "$(small)[panic]$(reset)" "$@" >&2
	exit 1
}
