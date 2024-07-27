#!/bin/bash

function main () {
	if [[ $# -ne 1 ]]; then
		>&2 echo "$0: Invalid argument count (must be == 1)."
		exit 1
	fi
	while [[ $# -ne 0 ]]; do
		case $1 in 
			"-h" | "--help")
				>&2 echo "$0: Usage: $0 <positive-integer>"
				>&2 echo "Output the summation of range [1, positive-integer]"
				>&2 echo "(include positive integer)"
				exit 1
				;;
			*)
				number="$1"
				shift
				;;
		esac
	done
	if ! [[ $number =~ ^[0-9]+$ ]]; then
		>&2 echo "$0: \"$number\" is not a valid positive integer"
		exit 1
	fi
	number=$(( $number ))
	number=$(( $number * ($number+1) / 2))
	echo "$number"
}

main "$@"
