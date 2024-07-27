#!/bin/bash

function main () {
	if [[ $# -gt 2 || $# -eq 0 ]]; then
		>&2 echo "Invalid argument count (must be 2 or 1 for help)"
		exit 1
	fi

	while [[ $# -ne 0 ]]; do
		case $1 in 
			"-h" | "--help")
				>&2 echo "Usage: $0 <current-pos> <dice-roll>"
				>&2 echo "Output end player position resulting from moving"
				>&2 echo "the player at <current-pos> by 2 x <dice-roll>"
				exit 1
				;;
			*)
				if [[ $# -lt 2 ]]; then
					>&2 echo "Invalid argument count (must be 2 or 1 for help)"
					exit 1
				fi
				currentpos=$1
				shift
				diceroll=$1
				shift
				;;
		esac
	done
	echo "$(( $currentpos + $diceroll * 2 ))"
}
main "$@"
