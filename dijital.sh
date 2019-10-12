#!/bin/bash
# Launch gedit, okular and start re-compiling tex file whenever .tex file is updated.

usage="$(basename "$0") Usage; [-o | -only_tex FILE] 
		  [-a | -all_files FILE] 
		  [-h | -help] 

	-o -only_tex   Recompile when only .tex files updated [DEFAULT]
	-a -all_files  Recompile when any files updated    
	-h -help       Show this help text"

only_tex='true'

while getopts ':ho:a:' option; do
  case $option in
    'h' | 'help') echo "$usage"; exit;;
    'o' | 'only_tex') OT=true; shift ;;
	'a' | 'all_files') OT=false; shift ;;

    ':') printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   	*) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done

if [ -z "$1" ]
then
	echo "You have to specify which file to process."
else
	if [ -e "$1.tex" ] && [ -e "$1.pdf" ]
	then
		xdotool key 'alt+shift+0' &
		gedit $1.tex &
		okular $1.pdf &
		if [ $OT ]
		then 
			ls *.tex | entr pdflatex $1.tex
		else		
			ls * | entr pdflatex $1.tex
		fi
	else
		echo "Either .PDF or .TEX files are missing."
		echo "Create? [Y/n]"
		read user_input
		if [ $user_input == 'Y' ]
		then
			touch $1.tex $1.pdf & 
			xdotool key 'alt+shift+0' &
			gedit $1.tex &
			convert xc:none -page A4 $1.pdf &
			okular $1.pdf &		
			if [ $OT ]
			then 
				ls *.tex | entr pdflatex $1.tex
			else		
				ls * | entr pdflatex $1.tex
			fi
		else
			exit 0
		fi
	fi
	
fi

