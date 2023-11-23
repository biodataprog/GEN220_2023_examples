#!/usr/bin/bash
#SBATCH --nodes 1 --ntasks 2 --mem 2G

module load ncbi-blast
module load muscle
module load trimal
module load fasttree

QUERY=MET12.fa
BASE=$(basename $QUERY .fa)
BLASTOUTPUT=${BASE}_vs_sprot.BLASTP

cut -f2 $BLASTOUTPUT | uniq > MET12.hits.txt
 
blastdbcmd -entry_batch MET12.hits.txt -db uniprot_sprot.fasta > $BASE.hit_seqs.fasta
perl -i -p -e 's/>(\S+)\s+(.+)OS=(\S+)\s+(\S+)/>$1_$3_$4 $2/' MET12.hit_seqs.fasta
muscle -align $BASE.hit_seqs.fasta -output $BASE.hit_seqs.fasaln

trimal -in $BASE.hit_seqs.fasaln -out $BASE.hit_seqs.trim -automated1
trimal -in $BASE.hit_seqs.fasaln -out $BASE.hit_seqs.trim_aln -automated1 -clustal

FastTree -gamma < $BASE.hit_seqs.trim > $BASE.hit_seqs.tre

