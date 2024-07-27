#!/bin/bash

function main () {
	if [[ $# -ne 1 && $# -ne 3 ]]; then
		>&2 echo "$0: Invalid argument count(must be 3 or 1 for help)."
		exit 1
	fi
	while [[ $# -ne 0 ]]; do
		case $1 in
			"-h" | "--help")
				>&2 echo "Usage: $0 <length> <width> <height>"
				>&2 echo "Output the volume of cuboidof given parameters"
				>&2 echo "parameters must be valid decimal numbers"
				exit 1
				;;
			*)
				length=$1
				shift
				width=$1
				shift
				height=$1
				shift
				;;
		esac
	done
	declare -a values=( $length $width $height )
	for value in "${values[@]}"; do
		if ! [[ $value =~ ^[0-9]+([.][0-9]+)?$ ]]; then
			>&2 echo "\"$value\" is not a valid positive integer."
			exit 1
		fi
	done
	echo "$( echo "$length * $width * $height" | bc)"
}

main "$@"
