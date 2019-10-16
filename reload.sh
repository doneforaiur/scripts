#!/bin/bash
# Script for refresing Opera page. Use with "entr".


xdotool search --onlyvisible --class Opera windowfocus key 'ctrl+r' 
xdotool sleep 0.5
xdotool search --onlyvisible --class gedit windowfocus --sync
