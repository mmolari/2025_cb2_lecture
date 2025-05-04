results/h3n2.aln.fa: data/h3n2.fa
	conda run -n mafft mafft --auto --thread 4 $^ > $@

results/tree.nwk: results/h3n2_coding.aln.fa
	mkdir -p results/iqtree && \
	cd results/iqtree && \
	ln -s ../h3n2_coding.aln.fa . && \
	conda run -n iqtree iqtree -s h3n2_coding.aln.fa -m GTR -T 8
	cp results/iqtree/h3n2_coding.aln.fa.treefile $@