#!/bin/bash

# NOTE: although this script is functional with "source" as a way to 
# change the directory directly to the created script location
# there are some aestetical bugs when running with "source"
# for example: --help will substitute /bin/bash for $0 instead of program name

# NOTE: to make this script also change the directory of user with the invoke of source,
# i had to obfuscate the act of exiting the program:
# this:
		# exit sequence
		#if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
		#	else return 0
		#fi
# would be equal to:
		# exit 1
# if the script was not meant to be source'd.


declare -a languages=( "python" "bash" )
declare -A extensions=( ["python"]="py" ["bash"]="sh" )
lang_dir="-exercises"
diff_dir="kyu"
skel_file="-skeleton."
help_skel_file=""




function main () {
	if [[ $# -ne 5 && $# -ne 1 ]]; then
		>&2 echo "$0: Invalid argument count (see -h)."
		# exit sequence
		if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
			else return 0
		fi
	fi
	local difficulty
	local language
	local scriptname

	while [[ $# -ne 0 ]]; do
		case $1 in
			"-d" | "--difficulty")
				if [[ $# -lt 2 ]]; then
					>&2 echo "$0: -d / --difficulty has no parameter"
				fi
				difficulty="$2"
				shift 2
				;;
			"-l" | "--language")
				if [[ $# -lt 2 ]]; then
					>&2 echo "$0: -l / --language has no parameter"
				fi
				language="$2"
				shift 2
				;;
			"-h" | "--help")
				if [[ $# -ne 1 ]]; then
					>&2 echo "$0: -h / --help should be a standalone argument."
					# exit sequence
					if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
						else return 0
					fi
				fi
				shift
				show-help
				# exit sequence
				if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
					else return 0
				fi
				;;
			*)
				scriptname="$1"
				shift
				;;
		esac
	done

	### argument checks

	if ! (if-valid-language $language) ; then
		>&2 echo "\"$language\" invalid or not currently operational language."
		# exit sequence
		if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
			else return 0
		fi
	fi
	if ! (if-valid-difficulty $difficulty) ; then
		>&2 echo "\"$difficulty\" invalid difficulty level."
		# exit sequence
		if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
			else return 0
		fi
	fi
	if ! (if-valid-extension $scriptname $language ) ; then
		>&2 echo -n "\"$scriptname\" -> "
		append-valid-extension $scriptname $language
		>&2 echo "\"$scriptname\""
	fi


	### directory and file checks
	# directory checks should ALWAYS go before file checks
	# if "lang_dir" does not exist, offer to create it
	# if "diff_dir" does not exist, offer to create it
	# if "skel_file"does not exist, enable user to input file name
	# if "scriptname" already exists, offer to proceed
	#  that way scriptname will be wiped to contain skel_file
		
	# general offer syntax:
		# "Do you want to create dir / send file / proceed with scriptname" -> input
			# if yes on dir 	create dir		CONTINUE
			# if yes on skelfile	ask for file	mv file CONTINUE
			# if yes on scriptname				CONTINUE
			# if no						TERMINATE


	lang_dir="${language}${lang_dir}"
	if ! [[ -d $lang_dir ]]; then
		>&2 echo "\"$lang_dir\" directory does not exist."
		>&2 echo "Create \"$lang_dir\"?"
		if if-yes ; then
			mkdir "$lang_dir"
		else
			# exit sequence
			if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
				else return 0
			fi
		fi
	fi
	diff_dir="${difficulty}$diff_dir"
	if ! [[ -d "${lang_dir}/$diff_dir" ]]; then
		>&2 echo "\"$diff_dir\" directory does not exist."
		>&2 echo "Create: \"${lang_dir}/$diff_dir\"?"
		if if-yes ; then
			mkdir "${lang_dir}/$diff_dir"
		else
			# exit sequence
			if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
				else return 0
			fi
		fi
	fi
	# check if scriptname already in use
	if [[ -a "${lang_dir}/${diff_dir}/${scriptname}" ]]; then
		>&2 echo "\"${scriptname}\" already exists in \"${lang_dir}/${diff_dir}\""
		>&2 echo -n "Proceed (this will wipe the file)?"
		if ! if-yes ; then
			# exit sequence
			if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
				else return 0
			fi
		fi
	fi
	skel_file=".${language}${skel_file}${extensions[$language]}"
	if ! [[ -a "${lang_dir}/$skel_file" ]]; then
		>&2 echo "\"$skel_file\" file does not exist."
		>&2 echo -n "Input file?"
		if if-yes ; then
			for (( ;; )); do
				get-skel-file && break
			done

		else
			# exit sequence
			if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then exit 1
				else return 0
			fi
		fi

	fi
	if [[ $help_skel_file != "" ]]; then
		mv "$help_skel_file" "${lang_dir}/${skel_file}"
	fi
	cp "${lang_dir}/${skel_file}" "${lang_dir}/${diff_dir}/${scriptname}"
	chmod u+x "${lang_dir}/${diff_dir}/${scriptname}"
	cd "${lang_dir}/${diff_dir}/"


}

function if-valid-language () {
	local input="$1"
	for language in "${languages[@]}"; do
		if [[ $input == $language ]]; then
			return 0
		fi
	done
	return 1
}
function if-valid-difficulty () {
	local difficulty="$1"
	if [[ $difficulty =~ ^[1-8]$ ]]; then
		return 0
	fi
	return 1
}
function if-valid-extension () { 
	local scriptname="$1"
	local language="$2"
	if [[ $scriptname == *".${extensions[$language]}" ]]; then
		return 0
	fi
	return 1
}
function append-valid-extension () {
	# do not delete possible extensions	
	scriptname="$1"
	local language="$2"
	scriptname="$scriptname.${extensions[$language]}"
}

function show-help () {
	>&2 echo "Usage: $0 <-d|--difficulty> <-l|--language> <name>"
	>&2 echo ""
	>&2 echo "-d | --difficulty	-> kata difficulty level ( digit[1-8] ) "
	>&2 echo "-l | --language		-> kata language "
	>&2 echo "name			-> kata script name"
	>&2 echo "Avaliable languages: ${languages[*]}"
	>&2 echo "TIP: source $0 ... --> change into dir where <name> was created."
}

function if-yes ()
{
	declare -a yes=( "y" "ye" "yes" "Y" "YE" "YES" )
	declare -a no=("n" "no" "N" "NO" )
	for (( ;; )) ; do
		read -p ": "
		for option in "${yes[@]}"; do
			if [[ "$option" == "$REPLY" ]]; then
				return 0
			fi
		done
		for option in "${no[@]}"; do
			if [[ "$option" == "$REPLY" ]]; then
				return 1
			fi
		done
	done
}

function get-skel-file ()
{
	# it should be noted that this can't be used directly in a while or for loop
	# this is because this function is meant to modify a global parameter, but
	# putting it inside a for or while statement creates a subshell
	help_skel_file="USER_INPUT"
	read -p "File: " help_skel_file
	if [[ -a "$help_skel_file" ]]; then
		return 0
	fi
	return 1
}

main "$@"
