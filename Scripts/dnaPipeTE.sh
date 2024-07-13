#!/bin/bash

#SBATCH --job-name=dnaPipeTE
#SBATCH --partition=week-long-highmem
#SBATCH --cpus-per-task=16
#SBATCH -N 1 #nodes
#SBATCH -o dnaPipeTE_%j.o
#SBATCH -e dnaPipeTE_%j.e

cd "/nfs/home/jlamb/Projects/dnaPipeTE_rnd_2"

JOB_ID=$SLURM_JOB_ID
TMP_DIR="$(pwd)/temp_$JOB_ID"
mkdir -p "$TMP_DIR" && export TMPDIR="$TMP_DIR"

#should only have to pass in $1 which is the SRX########

module load singularity/4.1.2
module load python3

# Use singularity exec instead of shell to run the subsequent commands in the container
singularity exec --bind /nfs/home/jlamb/Projects/dnaPipeTE_rnd_3/$1:/mnt ~/bin/dnaPipeTE/dnapipte.img /bin/bash <<EOF

# Set locale environment variables to avoid locale warnings
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

cd /opt/dnaPipeTE

python3 dnaPipeTE.py \
-input /mnt/${1}_N1.fastq \
-output /mnt/dnaPipeTE_15gb_10gc_RMt15_smpl_2 \
-cpu 16 \
-genome_size 15000000000 \
-genome_coverage 0.1 \
-RM_lib /nfs/home/jlamb/TE_libs/dedupe_telib.fasta \
-RM_t 0.15 \
-sample_number 2 \

EOF
rm -rf "$TMP_DIR"

#################################################################################
#usage: dnaPipeTE.py [-h] [-input [INPUT_FILE [INPUT_FILE ...]]]                #
#                    [-output OUTPUT_FOLDER] [-cpu CPU]                         #
#                    [-sample_size SAMPLE_SIZE] [-sample_number SAMPLE_NUMBER]  #
#                    [-genome_size GENOME_SIZE]                                 #
#                    [-genome_coverage GENOME_COVERAGE]                         #
#                    [-RM_lib REPEATMASKER_LIBRARY] [-species RM_SPECIES]       #
#                    [-RM_t RM_THRESHOLD] [-Trin_glue TRINITY_GLUE]             #
#                    [-contig_length CONTIG_LENGTH] [-keep_Trinity_output]      #
#                                                                               #
#optional arguments:                                                            #
#  -h, --help            show this help message and exit                        #
#  -input [INPUT_FILE [INPUT_FILE ...]]                                         #
#                        input fastq files (two files for paired data)          #
#  -output OUTPUT_FOLDER                                                        #
#                        output folder                                          #
#  -cpu CPU              maximum number of cpu to use                           #
#  -sample_size SAMPLE_SIZE                                                     #
#                        number of reads to sample                              #
#  -sample_number SAMPLE_NUMBER                                                 #
#                        number of sample to run                                #
#  -genome_size GENOME_SIZE                                                     #
#                        size of the genome                                     #
#  -genome_coverage GENOME_COVERAGE                                             #
#                        coverage of the genome                                 #
#  -RM_lib REPEATMASKER_LIBRARY                                                 #
#                        path to Repeatmasker library (if not set, the path     #
#                        from the config file is used. The default library is   #
#                        used by default)                                       #
#  -species RM_SPECIES   default RepeatMasker library to use. Must be a valid   #
#                        NCBI for species or clade ex: homo, drosophila, "ciona #
#                        savignyi". Default All is used                         #
#  -RM_t RM_THRESHOLD    minimal percentage of query hit on repeat to keep      #
#                        anotation                                              #
#  -Trin_glue TRINITY_GLUE                                                      #
#                        number of reads to join Inchworm (k-mer) contigs       #
#  -contig_length CONTIG_LENGTH                                                 #
#                       minimum size of contig to report, default = 200 pb      #
#  -keep_Trinity_output  keep Trinity output at the end of the run              #
#################################################################################
