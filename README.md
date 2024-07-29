# Ectopic_Recombination_Calculator
This pipeline is designed to run on a HPC cluster using slurm. 

## Authors 
Jacob Lamb

Email: Jacob.Lamb@colostate.edu
## Installation
Clone the github repo
```
git clone https://github.com/Jakeelamb/Ectopic_recombination
```
Install the conda environemt
```
conda create env -f ERC.yml
```
Download the Raw-reads, Genomes, & Reference Mito Genome
```
sbatch Download_Data.sh
```
Run the Nextflow script
```
nextflow run ERC.nf Ectopic_rembination_calc.config -profile conda --input_reads Data/Raw_reads/
```

## PipeLine Overview
<img width="2210" alt="Untitled" src="https://github.com/user-attachments/assets/5f2afef5-6222-444f-a2a5-7eefa8e75bd7">

## Software
-dnaPipeTE
-Dante
-genometools
-bowtie2
-samtools
-sratoolkit
-ncbi-cli-dataset
