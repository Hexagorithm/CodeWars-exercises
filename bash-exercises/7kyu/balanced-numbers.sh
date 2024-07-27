#!/bin/bash

# get input, -h, --help or number
# check if number is positive integer
# check whether number has 2 or 1 middle digit
# get the length of the number

# fish out the number values:
	# if middle digits are 2;
		# lower-ten = length-of-number /  2 - 1
		# higher-ten = length-of-number / 2 + 1
			# 1221
			# lower-ten -> 4 / 2 - 1-> 1 which makes 10, Good
			# higer-ten -> 4 / 2 + 1 -> 3 which makes 1000 Good
	# elif middle digits are 1;

		# lower-ten = length-of-number / 2
		# higher-ten = length-of-number / 2 + 1 
			# 121
			# lower-ten -> 3 / 2 -> 1 which makes 10
			# higher-ten-> 3 / 2 + 1 -> 2 which makes 100


	# right-number = number % lower-ten
	# left-number  = number / higher-ten

# function takes in extracted number, calculates the digits:
	# to handle number == 0, preinit result to be 0
	# while number is !0 
	# modulo by 10
	# integer dvision by 10 till zero

function show-help () {
	>&2 echo "Usage: $0 <positive integer>"
	>&2 echo ""
	>&2 echo "Checks if number is balanced or not."
	exit 1
}

function is-pos-int () {
	# zero -> number is integer
	# one  -> number is not 
	# this is done with having If statement evaluation in mind
	if [[ $1 =~ ^[0-9]+$ ]]; then
		return 0;
	else
		return 1;
	fi

}

function main () {
	if [[ $# -ne 1 ]]; then
		>&2 echo "$0: Invalid argument count (must be == 1)."
		exit 1
	fi
	while [[ $# -ne 0 ]]; do
		case $1 in
			"-h" | "--help")
				show-help
				;;
			*)
				local int="$1"
				shift
				;;
				
		esac
	done
	if  ! is-pos-int $int ; then
		echo "$int is not a valid integer."
		exit 1
	fi
	local length=${#int}
	int=$(($int))
	local lowerten=$(( $length / 2 + (length % 2 == 0 ? -1 : 0) ))
	local higherten=$(( $length / 2 + 1 ))
	lowerten=$((  10**$lowerten))
	higherten=$(( 10**$higherten))
	local lowersum=0
	for (( it=$(( $int % $lowerten )) ; it > 0 ; it = $(($it / 10 )) )); do
		lowersum=$(($lowersum + ($it % 10)))
	done
	local highersum=0
	for (( it=$(( $int / $higherten )) ; it > 0 ; it = $(($it / 10 )) )); do
		highersum=$(($highersum+ ($it % 10)))
	done
	if [[ $highersum == $lowersum ]]; then
		echo "Balanced"
	else
		echo "Not Balanced"
	fi



}

main "$@"
