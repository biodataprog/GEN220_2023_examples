#!/usr/bin/bash -l
#SBATCH -p short -c 64 --mem 64gb --out blastp_diamond.log

module load diamond

diamond makedb --threads 8 --db uniprot_sprot --in uniprot_sprot.fasta 
diamond blastp --query Saccharomyces_cerevisiae.peps.fa --db uniprot_sprot --threads 8 --outfmt  6 --out Sacch_vs_uniprot.diamond.tsv
