#!/bin/bash

function main (){
	if [[ $# -ne 4 && $# -ne 1 ]]; then
		>&2 echo "$0: Invalid argument count (must be 1 or 4)"
		exit 1
	fi
	
	while [[ $# -ne 0 ]]; do
		case $1 in
			"-h" | "--help")
				>&2 echo -e "Usage: $0 <p0> <pp> <dp> <p>\n"
				>&2 echo "Calculate how many years till a population, of <p0> inha"
				>&2 echo "-bitants which multiplies <pp> percent every year, also "
				>&2 echo "with <dp> inhabitants arriving independently, will reach"
				>&2 echo "a population of <p> inhabitants."
				>&2 echo "<p0> <dp> <p> must be positive integers"
				>&2 echo "<pp> must be a positive decimal/integer"
				exit 1
				;;
			*)
				if [[ $# -ne 4 ]]; then
					>&2 echo "Invalid argument count."
					exit 1
				fi
				p0="$1"
				pp="$2"
				dp="$3"
				p="$4"
				shift 4
				;;
		esac
	done
	declare -a numbers=($p0 $dp $p)
	for number in ${numbers[@]}; do
		if ! [[ $number =~ ^[0-9]+$ ]];then
			>&2 echo "$0: \"$number\" not a valid positive integer"
			exit 1
		fi
	done
	if ! [[ $pp =~ ^[0-9]+([.][0-9]+)?$ ]]; then
		>&2 echo "$0: \"$pp\" not a valid positive decimal/integer"
		exit 1
	fi
	p0=$(( $p0 ))
	dp=$(( $dp ))
	p=$(( $p ))
	years=0
	while [[ $p0 < $p ]]; do
		years=$(( $years + 1 ))
		p0=$( echo "scale=0; $p0 + $p0 * $pp / 100 + $dp" | bc )
	done
	echo "$years"
}

main "$@"
