#!/usr/bin/bash -l
#SBATCH -p short -c 24 -N 1 -n 1 --mem=100g --time=1:00:00 

CPU=24
module load signalp/6

signalp6 -org euk --output_dir ./Scer_signalp_cpu --fastafile Saccharomyces_cerevisiae.peps.fa --torch_num_threads=24

