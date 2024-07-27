#!/bin/bash

function main () {
	if [[ $# -ne 1 ]]; then
		>&2 echo "$0: Invalid argument count (must be =1)"
		exit 1
	fi
	while [[ $# -gt 0 ]]; do
		case $1 in
			"-h" | "--help")
				>&2 echo "$0: Usage: $0 <positive-integer>"
				>&2 echo "Situation specific script"
				exit 1
				;;
			*)
				number=$1
				shift
				;;
		esac
	done
	if ! [[ $number =~ ^[0-9]+$ ]];then
		>&2 echo "$0: \"$number\" is not a valid positive integer"
		exit 1;
	fi
	number=$(( $number ))
	if [[ $number -ge 10 ]]; then
		echo "Great, now move on to tricks"
	else
		echo "Keep at it until you get it"
	fi

	

}

main $@

