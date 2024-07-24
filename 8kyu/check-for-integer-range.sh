#!/bin/bash

function main () {
	if [[ $# -eq 0 ]]; then
		>&2 echo "$0: No arguments given."
		exit 1
	elif [[ $# -gt 6 ]]; then
		>&2 echo "$0: Too many arguments given (must be <= 6)"
		exit 1
	elif [[ $(( $# % 2)) -eq 1 && $# -ne 1 ]]; then 	# dont exec on -h or --help
                >&2 echo "$0: Invalid argument count (must be key->value pairs)"	
		exit 1
	fi

	comm=""
	strt=""
	end=""

	while [[ $# -gt 0 ]]; do
		case $1 in 
			"-h" | "--help")
				shift
				>&2 echo "$0: Usage: $0 -c <command-name> -s <start> -e <end>"
				>&2 echo "Takes in command-name and invokes it with a single integer"
				>&2 echo "that is in range [<start>, <end>)"
			       	>&2 echo "(include start, exclude end)"
				exit 1
				;;
			"-c")
				shift;
				comm="$1"
				shift
				;;
			"-s")
				shift
				strt="$1"
				shift
				;;
			"-e")
				shift
				end="$1"
				shift
				;;
			*)
				>&2 echo "$0: invalid argument: \"$1\"."
				shift
				exit 1
		esac
	done
	if ! [[ $strt =~ ^-?[0-9]+$ ]]; then
		>&2 echo "$0: \"$strt\" is not a valid integer."
		exit 1
	elif ! [[ $end =~ ^-?[0-9]+$ ]]; then
		>&2 echo "$0: \"$end\" is not a valid integer."
		exit 1
	fi
	strt=$(( $strt ))
	end=$(( $end ))
	if [[ $strt -lt $end ]]; then
		for (( it = $strt; $it < $end ;  it++ )); do
			echo "($it)-> \"$($comm $it)\""
		done
	else
		for (( it=$strt; it -lt $end ;  it-- )); do
			echo "($it)-> \"$($comm $it)\""
		done
	fi


}


main $@
