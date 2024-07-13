#!/bin/bash
#SBATCH --partition=short-cpu
#SBATCH --job-name=genome_grab
#SBATCH --cpus-per-task=1
#SBATCH -N 1 #nodes
#SBATCH -o Genome_grab_%j.o
cd /nfs/home/jlamb/Projects/RepeatMasker/Data
~/bin/datasets download genome accession $1 --filename ${2}.zip
echo "Downloading $2 genome with accession $1 ..."
