#This is a script that will download all of the raw data using sra-toolkit and ncbi-cli dataset


#Download Mito genome

#Download Genomes
Accensions = [
GCA_030180145.1
GCA_030264435.1
GCA_030264455.1
GCA_030264475.1
GCA_030264495.1
GCA_030264635.1
GCA_030264875.1
GCA_030264895.1
GCA_030264915.1
GCA_030264935.1
GCA_030264955.1
GCA_030264975.1
GCA_030264995.1
GCA_030265015.1
GCA_030265035.1
GCA_030265095.1
GCA_032275005.1
GCA_032360725.1
GCA_002915635.1
GCA_033119125.1
GCA_032274985.1
GCA_034783875.1
GCA_032353675.1
GCA_033118305.1
GCA_031753635.1
GCA_034783935.1
GCA_032353815.1
GCA_032353775.1
GCA_032275315.1
GCA_032353855.1
GCA_035049765.1
GCA_031753695.1
GCA_032354855.1
GCA_031753675.1
GCA_032275285.1
GCA_032353935.1
GCA_031753655.1
GCA_034782015.1
GCA_032357565.1
]

command: datasets download genome accession $1 --filename ${2}.zip
echo "Downloading $2 genome with accession $1 ..."

#Download RawReads
**will need to add command to submit slurm jobs 1 at a time to prevent maxing memory

Accensions = [
SRX19952891
SRX19958881
SRX19953421
SRX20502416
SRX20502537
SRX21425396
SRX20502577
SRX21425397
SRX20502826
SRX21425398
SRX19952691
SRX21425399
SRX20502857
SRX20502827
SRX20502776
SRX20502939
SRX21425400
SRX19954879
SRX20503049
SRX19955091
SRX20503048
SRX20497025
SRX19955089
SRX21394251
SRX20503015
SRX19952929
SRX19953983
SRX19952928
SRX19953420
SRX19958882
SRX19953415
SRX19953382
SRX19953419
SRX19952890
SRX19958874
SRX19952657
SRX19953381
SRX19952863
]

#First prefetch the accensions:
prefetch -O ./Data/Rawreads -f {accension}
fastq-dump --split-files {accension}

