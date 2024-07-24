#!/bin/bash

function main () {
	if [[ $# -ne 1 ]]; then
		>&2 echo "$0: invalid argument count( == 1 )!"
		exit 1
	fi
	
	while [[ $# -ne 0 ]]; do
		case $1 in
			"-h" | "--help")
				shift
				>& echo "$0: Usage: $0 <string>"
				>& echo "Output <string> without first and last character"
				;;
			*)
				string=$1
				shift
				;;
		esac
	done

	if [[ ${#string} -lt 2 ]]; then
		>&2 echo "$0: string of invalid length ( >= 2)"
		exit 1
	fi
	string="$(echo -n "${string:1:-1}")"
	echo "$string"
	echo "$lastchar"
}

main $@
