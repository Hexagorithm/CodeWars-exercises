#!/bin/bash

function main(){ 
	if [[ $# -gt 2 ]]; then
		>&2 echo "$0: too many arguments.(> 2)"
		exit 1
	elif [[ $# -eq 0 ]]; then
		>&2 echo "$0: no arguments."
		exit 1
	fi
	while [[ $# -ne 0 ]]; do
		case "$1" in 
			"-h" | "--help")
				shift
				echo "$0: Usage: $0 <positive-integer> <string>"
				echo "repeat <string>, <positive-integer> times"
				exit 1
				;;
			*)
				int=$1
				if ! [[ $int =~ ^[0-9]+$ ]]; then
					echo "$0: \"$int\" not valid positive integer"
					exit 1
				fi
				if [[ $# -lt 2 ]]; then
					echo "$0: \"$int\" not followed by string."
					exit 1
				fi
				shift
				string="$1"
				shift
				;;
		esac
	done
	fullstring=""
	while [[ $int -ne 0 ]]; do
		int=$(( $int - 1))
		fullstring="${fullstring}$string"
	done
	echo "$fullstring"
		
}

main $@
