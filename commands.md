These are the commands used in the pipeline

*need to figure out if singularity can be added to conda env

Activate the ERC conda environment
conda env create -f ERC.yml
conda activate ERC

1.) Download genomes
datasets download genome accession $1 --filename ${2}.zip

2.) Download Raw Reads
prefetch -O ./Data/Rawreads -f {accension}
fastq-dump --split-files {accension}

3.) Gunzip the TE library
gunzip Data/TE_lib/Desmognathus_curated_TE_lib.fasta.gz

3.) Trim the files and filter the mito reads

BASENAME=$(basename $1 | cut -f 1 -d '.')
fastp --in1 $1 --in2 $2 --out1=${BASENAME}_trimmed_1.fq.gz --out2=${BASENAME}_trimmed_2.fq.gz -t 32 --detect_adapter_for_pe

4.) Run dnaPipeTE
module load singularity

singularity exec --bind /nfs/home/jlamb/Projects/dnaPipeTE_rnd_3/$1:/mnt ~/bin/dnaPipeTE/dnapipte.img /bin/bash <<EOF

# Set locale environment variables to avoid locale warnings
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

cd /opt/dnaPipeTE

python3 dnaPipeTE.py \
-input /mnt/${1}_N1.fastq \
-output /mnt/dnaPipeTE_15gb_10gc_RMt15_smpl_2 \
-cpu 32 \
-genome_size 15000000000 \
-genome_coverage 0.1 \
-RM_lib Data/TE_lib/Desmognathus_curated_TE_lib.fasta \
-RM_t 0.15 \
-sample_number 2 \

EOF

5.) Run the LTR Pipeline

# Create a gff3 file for the genome
dante -q {path to dnaPipeTE output} -D Metazoa_v3.1 -o "genome_name".gff3 -c 32

#Create a database with the genome file
gt suffixerator -db "$file" -indexname "$filename" -tis -suf -lcp -des -ssp -sds -dna

#Run LTRharvest
gt ltrharvest -index "$filename" -gff3 "${filename}.gff3" -out "${filename}.out" -outinner "${filename}.outinner

#Sort the GFF3 file
gt gff3 -sort ${filename}.gff3 > ${filename}_sorted.gff3

#Run LTRdigest
gt ltrdigest -outfileprefix "$filename" "${filename}_sorted.gff3" "$filename"

6.) Prep files and directories for coverage analysis

#Create a directory for each genome


#Split the multi fasta-file into individual files 


7.) Index and calculate coverage for every LTR






