#!/usr/bin/bash -l
#SBATCH -N 1 -n 1 -c 16 --mem 64gb --out pfam.%a_%A.log -a 1-3
CPU=16
module load hmmer/3.3.2-mpi
module load db-pfam

EXT=fasta
IN=${SLURM_ARRAY_TASK_ID}

if [ -z "$IN" ]; then
 IN=$1
 if [ -z "$IN" ]; then
   IN=1
   echo "defaulting to IN value is 1 - specify with --array or cmdline"
 fi
fi

TOTAL=$(ls *.${EXT} | wc -l)
if [ $IN -gt $TOTAL ]; then
 echo "Only $TOTAL files in folder $PROTEINS, skipping $IN"
 exit
fi
INFILE=$(ls *.${EXT} | sed -n ${IN}p)
OUT=$(basename $INFILE .fasta).Pfam
hmmscan --cut_ga --cpu $CPU --domtbl ${OUT}.domtbl -o ${OUT}.hmmscan $PFAM_DB/Pfam-A.hmm $INFILE
