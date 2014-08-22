# Makefile for book publishing...

default: book


book: xxx.pdf


xxx.pdf: manuscript/a-brief-background.md
	pandoc -o xxx.pdf manuscript/a-brief-background.md
