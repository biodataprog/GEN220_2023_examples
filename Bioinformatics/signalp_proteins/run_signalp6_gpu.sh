#!/usr/bin/bash -l
#SBATCH -p gpu --gres=gpu:a100:1 --mem=100g --time=1:00:00 -c 16 -N 1 -n 1

module load signalp/6-gpu

signalp6 -org euk --output_dir ./Scer_signalp --fastafile Saccharomyces_cerevisiae.peps.fa --torch_num_threads=16

