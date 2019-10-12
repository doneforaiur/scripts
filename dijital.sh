#!/bin/bash
# Launch gedit, okular and start re-compiling tex file whenever .tex file is updated.


xdotool key 'alt+shift+0'
okular $1.pdf & gedit $1.tex &
ls *.tex | entr pdflatex $1.tex
