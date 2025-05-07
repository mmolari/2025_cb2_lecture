results/h3n2.aln.fa: data/h3n2.fa
	conda run -n mafft mafft --auto --thread 4 $^ > $@

results/tree.nwk: results/h3n2_coding.aln.fa
	mkdir -p results/iqtree && \
	cd results/iqtree && \
	ln -s ../h3n2_coding.aln.fa . && \
	conda run -n iqtree iqtree -s h3n2_coding.aln.fa -m GTR -T AUTO
	cp results/iqtree/h3n2_coding.aln.fa.treefile $@

notes/%.pdf: %.ipynb
	conda run -n teaching jupyter nbconvert --to pdf --no-input --output-dir notes $<

# concatenate pdf files
lecture_notes.pdf: notes/n01_alignment.pdf notes/n02_tree.pdf notes/n03_rooting_trees.pdf
	pdfunite $^ $@

all: lecture_notes.pdf

