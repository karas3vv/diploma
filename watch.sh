#!/bin/bash

cd -- "$(dirname -- "$0")/text" || exit 1

while inotifywait -e close_write ./*.tex ./*.bib ./*.sty ./*.cls ./*.bst ./figures/*.tex; do
    pdflatex -no-shell-escape -interaction=nonstopmode -halt-on-error diploma.tex &&
        bibtex diploma &&
        pdflatex -no-shell-escape -interaction=nonstopmode -halt-on-error diploma.tex &&
        pdflatex -no-shell-escape -interaction=nonstopmode -halt-on-error diploma.tex
done
