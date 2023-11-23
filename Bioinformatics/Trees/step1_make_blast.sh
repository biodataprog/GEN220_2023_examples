#!/usr/bin/bash
#SBATCH --nodes 1 --ntasks 2 --mem 2G

module load ncbi-blast
# run indexing if database is not indexed
if [ ! -f uniprot_sprot.fasta.psq ]; then 
	makeblastdb -in uniprot_sprot.fasta -dbtype prot -parse_seqids
fi

QUERY=MET12.fa
BASE=$(basename $QUERY .fa)
OUTPUT=${BASE}_vs_sprot.BLASTP

blastp -query $QUERY -db uniprot_sprot.fasta -evalue 1e-20 -out $OUTPUT -outfmt 6
