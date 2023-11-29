#!/usr/bin/bash -l
#SBATCH -p short -c 16 --mem 16gb --out prokka.log
module load prokka

prokka --outdir Ecoli_K-12.reassembly_prokka Ecoli_K-12.reassembly.fasta
prokka --outdir Ecoli_K-12.prokka Ecoli_K-12.fasta
