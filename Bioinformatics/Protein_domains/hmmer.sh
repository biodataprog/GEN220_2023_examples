#!/usr/bin/bash -l
#SBATCH -c 8 --mem 24gb --out hmmer.log

module load hmmer
module load db-pfam

hmmscan --cut_ga --domtbl Sacch.Pfam.hmmscan.domtbl --cpu 8 $PFAM_DB/Pfam-A.hmm Saccharomyces_cerevisiae.peps.fa > Sacch.Pfam.hmmscan
