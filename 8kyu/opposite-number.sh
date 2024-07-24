#!/bin/bash
function main() {

	if [[ "$#" -ne 1 ]]; then
		>&2 echo "$0: too little or too many arguments"
		exit 1
	fi

	while [[ "$#" -gt 0 ]]; do
		case "$1" in 
			"-h" | "--help")
				shift
				>&2 echo "$0: Usage: $0 <integer/decimal>"
				exit 1
				;;
			*)
				string="$1"
				shift
				if [[ $(is-number $string) == false ]]; then
					>&2 echo "$0: \"$string\" not a valid integer/decimal."
					exit 1
				fi
				number="$(get-number $string)"
				echo "$(echo "$number * (-1)" | bc)"
				;;
	esac
done	

}



function is-number(){
	if [[ "$1" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
		echo -n "true"
	else
		echo -n "false"
	fi
}

function get-number() {
	echo -n "$(echo "$1" | bc)"
}

main $@
