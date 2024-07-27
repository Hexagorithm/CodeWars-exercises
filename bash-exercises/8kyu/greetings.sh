#!/bin/bash
function main () {
	if [[ $# -ne 1 ]]; then
		>&2 echo "$0: invalid argument count (must be == 1)."
		exit 1
	fi
	
	while [[ $# -ne 0 ]]; do
		case $1 in 
			"-h" | "--help")
				>&2 echo "Usage: $0 <name>"
				>&2 echo "Output greeting message to user <name>"
				exit 1
				;;
			*)
				name=$1
				shift
				;;
		esac
	done
	echo "Hello, $name how are you doing today?"
}
main "$@"
