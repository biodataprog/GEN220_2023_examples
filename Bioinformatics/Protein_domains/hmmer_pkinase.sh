#!/usr/bin/bash -l
#SBATCH -c 8 --mem 24gb --out hmmer.log

module load hmmer
module load db-pfam

hmmfetch $PFAM_DB/Pfam-A.hmm Pkinase > Pkinase.hmm
hmmsearch --cut_ga --domtbl Sacch_Kinases.hmmsearch.domtbl Pkinase.hmm Saccharomyces_cerevisiae.peps.fa > Sacch_Kinases.hmmsearch

echo 'Now we can see some of the hits'
grep -v ^# Sacch_Kinases.hmmsearch.domtbl | awk '{print $1,$4,$7}' 

# retrieve the sequences that are hits, based on their ID
esl-sfetch -f Saccharomyces_cerevisiae.peps.fa Pkinase_hits.txt > Pkinase_hits.fa

# alternatively you can do it this way:
# module load samtools
# samtools faidx -r Pkinase_hits.txt Saccharomyces_cerevisiae.peps.fa > Pkinase_hits.fa
