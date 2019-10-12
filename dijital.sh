#!/bin/bash
# Launch gedit, okular and start re-compiling tex file whenever .tex file is updated.

usage="Dijital 2019   Mirza Atlı

[-o | -only_tex  FILE] 
[-a | -all_files FILE] 
[-h | -help] 

-o -only_tex   Recompile when only .tex files updated [DEFAULT]
-a -all_files  Recompile when any files updated    
-h -help       Show this help text"

only_tex='true'
FILE=$1
while getopts ':hoa' option; do
  case $option in
    'h' | 'help') echo "$usage"; exit;;
    'o' | 'only_tex') only_tex=true
					  FILE="$2"
					  shift 2
					  ;;
	'a' | 'all_files') only_tex=false
					   FILE="$2"
					   shift 2
					   ;;

    ':') printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   	*) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
	shift $((OPTIND -1))
done

if [ -z "$FILE" ]
then
	echo "You have to specify which file to process."
else
	if [ -e "$FILE.tex" ] && [ -e "$FILE.pdf" ]
	then
		xdotool key 'alt+shift+0' &
		gedit $FILE.tex &
		okular $FILE.pdf &
		if [ $only_tex = true ]
		then 
			ls *.tex | entr pdflatex $FILE.tex
		else		
			ls * | entr pdflatex $FILE.tex
		fi
	else
		echo "Either .PDF or .TEX files are missing."
		echo "Create? [Y/n]"
		read user_input
		if [ $user_input == 'Y' ]
		then
			touch $FILE.tex $FILE.pdf & 
			xdotool key 'alt+shift+0' &
			gedit $FILE.tex &
			convert xc:none -page A4 $FILE.pdf &
			okular $FILE.pdf &		
			if [ $only_tex = true ]
			then 
				ls *.tex | entr pdflatex $FILE.tex
			else		
				ls * | entr pdflatex $FILE.tex
			fi
		else
			exit 0
		fi
	fi
	
fi

