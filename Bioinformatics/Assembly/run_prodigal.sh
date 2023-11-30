#!/usr/bin/bash -l
#SBATCH -p short --out prodigal.log
module load prodigal

prodigal -i Ecoli_K-12.reassembly.fasta -a Ecoli_K-12.reassembly.prodigal.aa \
	-f gff -o Ecoli_K-12.reassembly.prodigal.gff 

prodigal -i Ecoli_K-12.fasta -a Ecoli_K-12.prodigal.aa \
	-f gff -o Ecoli_K-12.prodigal.gff
