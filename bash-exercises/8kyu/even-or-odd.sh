#!/bin/bash
if [[ "$#" -ne 1 ]]; then 
	>&2 echo "No arguments given!" 
	exit 1;
fi


function is-integer ()
{
	local string="$1"
	if [[ $string =~ ^-?[0-9]+$ ]]; then
		echo "YES"
	else
		echo "NO"
	fi

}
function even-or-odd ()
{
	local integer=$(($1))
	if [[ $(( $integer % 2 )) -eq 0 ]]; then
		echo -n "Even"
	else
		echo -n "Odd"
	fi
}


while [[  $# -gt 0 ]]; do
	case "$1" in
		"-h" | "--help") 
			shift # shifts 1
			>&2 echo "Usage: $0 <integer>"  
			;;
		*)	
			integer="$1"
			shift
			if [[ "$( is-integer $integer)" == "NO"  ]]; then
				>&2 echo "$integer not valid integer"
			else
				>&2 echo "$integer valid integer"
				echo "$( even-or-odd $integer)"
			fi
			;;
	esac
done
