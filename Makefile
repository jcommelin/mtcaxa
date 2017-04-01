%: %.pdf
	
%.pdf: %.tex tmp/%.bib
	latexmk -pdf -outdir=tmp $< && cp tmp/$(@F) $@

tmp/%.bib: %.tex
	cat $< | sed -e 's/\\cite/\n\\cite/g' | sed -e '/\\cite/!d;s/\\cite{\([^}]*\)}.*/\1/' | sort | uniq |\
		while read -r line; do sed -e '/^$$/,$$d' /home/jmc/data/bib/$$line.bib; done > $@

.PRECIOUS: %.pdf
