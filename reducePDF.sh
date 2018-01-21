#!/bin/bash
if ! command -v pdftops &> /dev/null || ! command -v ps2pdf &> /dev/null
then
	echo "You need the commands 'pdftops' and 'ps2pdf'."
	echo "Please install the proper packages and try again."
	exit 1
fi	

rPDF() {
	pdftops $1 && rm $1 && ps2pdf ${1%.*}.ps && rm ${1%.*}.ps
}

export -f rPDF

if command -v parallel &> /dev/null
then
	parallel rPDF ::: $@ 
else
	echo "Please install 'parallel' to be able to convert more than one PDF at the same time."
	for f in $@
	do
		rPDF $f
	done
fi

