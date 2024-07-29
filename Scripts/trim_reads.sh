#!/bin/bash
#SBATCH --partition=day-long-cpu
#SBATCH --job-name=Fastp
#SBATCH --cpus-per-task=32
#SBATCH -N 1 #nodes
#SBATCH -o fastp_%j.o  # Standard output to log file
#SBATCH -e fastp_%j.err  # Standard error to error log file

cd /nfs/home/jlamb/Projects/SRA
source ~/.bashrc
conda activate /nfs/home/jlamb/bin/miniconda3/envs/map_trim

# Extract the base name from the input sequence
BASENAME=$(basename $1 | cut -f 1 -d '.')

# Run fastp with the trimlog and ILLUMINACLIP
fastp --in1 $1 --in2 $2 --out1=${BASENAME}_trimmed_1.fq.gz --out2=${BASENAME}_trimmed_2.fq.gz -t 32 --detect_adapter_for_pe
exit

