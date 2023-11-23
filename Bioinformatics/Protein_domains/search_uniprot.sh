#!/usr/bin/bash -l
#SBATCH -N 1 -n 1 -c 8 --mem 8gb --out fasta_search.log

CPU=8
QUERY=Saccharomyces_cerevisiae.peps.fa
DB=uniprot_sprot.fasta
RESULT=Sacch_vs_uniprot.tsv

module load fasta
if [ ! -f uniprot_sprot.fasta ]; then
	wget https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
	pigz -d uniprot_sprot.fasta.gz
fi

# 0.001
fasta36 -E 1e-3 -T $CPU -m 8c $QUERY $DB > $RESULT

