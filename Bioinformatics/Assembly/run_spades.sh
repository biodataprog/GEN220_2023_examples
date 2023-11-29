#!/usr/bin/bash -l
#SBATCH --mem 48gb -N 1 -n 1 -c 24 --out spades_run.log
ln -s /bigdata/gen220/shared/data-examples/asm/E_coli/Ecoli_K12_Simreads_R2.fq.gz
ln -s /bigdata/gen220/shared/data-examples/asm/E_coli/Ecoli_K12_Simreads_R1.fq.gz
module load spades
CPU=24
MEM=48
spades.py -1 Ecoli_K12_Simreads_R1.fq.gz -2 Ecoli_K12_Simreads_R2.fq.gz \
	-o new_spades_test -t $CPU --mem $MEM --isolate
