# Makefile for book publishing...

all: book

.PHONY: all clean book preview
.SUFFIXES:
.SUFFIXES: .latex .pdf

LATEX = pdflatex
LATEX_FLAGS = --output-directory=$(outdir) --interaction=nonstopmode

srcdir = manuscript
outdir = build
manifest = $(srcdir)/Book.txt
#sources = $(shell sed -e '/#.*$/d;/^\s*$/d' manuscript/Book.txt)
#sources = $(addprefix $(srcdir)/,$(shell cat $(manifest)))
sources =\
	$(srcdir)/a-brief-background.md \
	$(srcdir)/getting-started.md #\
	#$(srcdir)/index.md

bookname = aaa

book: $(outdir)/$(bookname).pdf

preview: clean book
	evince $(outdir)/$(bookname).pdf

$(outdir):
	mkdir $(outdir)

$(outdir)/$(bookname).latex: $(sources) | $(outdir)
#	pandoc -f markdown -t latex -o $@ --template=template/template-test.latex --chapters $(sources)
	pandoc \
		--from=markdown \
		--to=latex \
		--standalone \
		--chapters \
		--metadata=documentclass:book \
		--metadata=fontsize:10pt \
		--metadata=classoption:draft \
		--metadata=citecolor:black \
		--metadata=urlcolor:black \
		--metadata=linkcolor:black \
		--metadata=author:"Jared Reisinger" \
		--metadata=date:"January 1, 2015" \
		--metadata=title-meta:"Advanced Markdown for Book Publishing" \
		--metadata=author-meta:"Jared Reisinger" \
		--include-in-header=template/header.latex \
		--include-before-body=template/before-body.latex \
		--include-after-body=template/after-body.latex \
		--output=$@ \
		$(sources)

#		--table-of-contents \ # handled in before-body...
#		--metadata=title:"Advanced Markdown for Book Publishing" \

# .latex.idx:
# 	latex $@

# .ids.ind:
# 	makeindex $(basename $@)

.latex.pdf:
	@echo ===== LaTeX: first pass... =====
	$(LATEX) $(LATEX_FLAGS) $^
	@echo ===== BibTeX pass... =====
	bibtex $(basename $^)
	@echo ===== LaTeX: second pass... =====
	$(LATEX) $(LATEX_FLAGS) $^
	@echo ===== mkindex pass... =====
	mkindex $(basename $^)
	# @echo ===== LaTeX: third pass... =====
	# $(LATEX) $(LATEX_FLAGS) $^
	@echo ===== LaTeX: final pass... =====
	-$(LATEX) $(LATEX_FLAGS) $^
#dvipdf $(basename $^).dvi $@
#pandoc -o $@ $^

# book: xxx.pdf xxx.latex

# input = manuscript/a-brief-background.md
# xxx.pdf: $(input)
# 	pandoc -o xxx.pdf $(input)

# yyy.latex: $(input)
# 	pandoc -o yyy.latex $(input)

# yyy.pdf: yyy.latex

clean:
	-rm -rfv $(outdir)
