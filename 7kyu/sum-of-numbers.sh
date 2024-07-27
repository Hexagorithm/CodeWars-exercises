# if argument count is not 1 nor 2, arguments invalid
# if --help or -h , show help
# detect if beg < end , switch otherwise
# for loop

#!/bin/bash

function main () { 
	if [[ $# -gt 2 || $# -eq 0 ]]; then
		>&2 echo "$0: invalid argument count (must be == 1 or == 2)"
		exit 1
	fi
	
	while [[ $# -ne 0 ]]; do
		case $1 in
			"-h" | "--help")
				show-help
				shift
				exit 1
				;;
			*)
				if ! [[ $# -ge 2 ]]; then
					>&2 echo "Invalid argument count (beg and end must be specified)"
					exit 1
				fi
				local beg="$1"
				local end="$2"
				shift 2
				;;
		esac
	done
	if ! is-int $beg ; then
		int-not-valid $beg
		exit 1
	elif ! is-int $end ; then
		int-not-valid $end
		exit 1
	fi
	beg=$(($beg))
	end=$(($end))
	echo "$( sum-of-numbers $beg $end )"

}

function show-help () {
	>&2 echo "Usage: $0 <start> <end>"
	>&2 echo ""
	>&2 echo "Output sum of array of integers [<start>;<end>], including edges"
	>&2 echo "(when <start> > <end>, script flips parameters )"
}

function is-int (){
	# zero on success -> if succeeds if zero
	if [[ $1 =~ ^-?[0-9]+$ ]]; then
		return 0
	else 
		return 1
	fi
}

function int-not-valid(){ 
	>&2 echo "\"$1\" not a valid integer."
}

function sum-of-numbers () {
	local beg=$1
	local end=$2

	function sum-of-numbers-inner () {
		local beg=$1
		local end=$2
		local sum=0
		for (( i = $beg ; i <= $end ; i++ )) ; do
			sum=$(( $sum +$i ))
			
		done
		echo "$sum"
	}

	if [[ $beg -lt $end ]]; then
		echo "$(sum-of-numbers-inner $beg $end )"
	else
		echo "$(sum-of-numbers-inner $end $beg )"
	fi

}

main "$@"
