#!/usr/bin/bash -l
#SBATCH -c 24 --mem 48gb --out interpro.log
CPU=24

module load db-pfam
module load iprscan

interproscan.sh --goterms --pathways -f tsv -i Pkinase_hits.fa --cpu $CPU > Pkinase_hits.interpro.log

