#!/bin/bash
#SBATCH --partition=day-long-cpu
#SBATCH --job-name=FastQ_dump
#SBATCH -N 1 #nodes
#SBATCH --cpus-per-task=1
#SBATCH --output=SRA__%j.o
#SBATCH --error=SRA__%j.e


#Submit job
command="/nfs/home/jlamb/bin/sratoolkit.3.1.0-ubuntu64/bin/fasterq-dump-orig.3.1.0 --split-files $1"
echo "Processing $1..."
$command
