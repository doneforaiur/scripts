#!/bin/bash
# Launch gedit, okular and start re-compiling tex file whenever .tex file is updated.

if [ -z "$1" ]
then
	echo "You have to specify which file to process."
else
	if [ -e "$1.tex" ] && [ -e "$1.pdf" ]
	then
		xdotool key 'alt+shift+0' &
		gedit $1.tex &
		okular $1.pdf &
		ls *.tex | entr pdflatex $1.tex
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
			ls *.tex | entr pdflatex $1.tex
		else
			exit 0
		fi
	fi
	
fi

