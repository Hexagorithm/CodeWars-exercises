#!/bin/bash

function main () {
	if [[ $# -ne 1 ]]; then
		>&2 echo "$0: Invalid argument count (must be == 1)."
		exit 1
	fi

	while [[ $# -ne 0 ]];do
		case $1 in 
			"-h" | "--help")
				>&2 echo "Usage: $0 <y-beads-count>"
				>&2 echo "Output the number of x beads before the yth bead"
				>&2 echo "in a sequence:"
				>&2 echo "y x x y x x y x x y x x y x x y ..."
				>&2 echo "(y-beads-count must be a positive integer)."
				exit 1
				;;
			*)
				ybeads=$1
				shift
				;;
		esac
	done
	if ! [[ $ybeads =~ ^[0-9]+$ ]]; then
		>&2 echo "\"$ybeads\" is not a valid positive integer."
		exit 1
	fi
	echo "$(( $ybeads < 2 ? 0 : ($ybeads - 1) * 2))"
}

main "$@"
