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
#```
conda env create -f ERC.yml
conda env create -f faSplit.yml
```

## Run the Pipeline
Enter the directory

```
cd Ectopic_recombination
```

Pull the dnaPipeTE singularity image

```
singularity pull --name /Data/Misc/dnapipete.img docker://clemgoub/dnapipete:latest
```

Run the Nextflow script
```
nextflow run workflows/main.nf -c configs/nextflow.config -profile slurm 
```

## PipeLine Overview
<img width="2210" alt="Untitled" src="https://github.com/user-attachments/assets/4f2afef5-6222-444f-a2a5-7eefa8e75bd7">

## Species Table
| Species | SRA Accession | Genome Accession |
|---------|---------------|------------------|
| D.abditus | SRX19952928 | GCA_030264455.1 |
| D.adatsihi | SRX20502416 | GCA_032275005.1 |
| D.aeneus | SRX19953415 | GCA_030264635.1 |
| D.amphileucus | SRX20502537 | GCA_032360725.1 |
| D.anicetus | SRX21425396 | GCA_033119125.1 |
| D.apalachicolae | SRX19952657 | GCA_030264955.1 |
| D.aureatus | SRX20502577 | GCA_032274985.1 |
| D.auriculatus | SRX19953419 | GCA_030264895.1 |
| D.bairdii | SRX21425397 | GCA_034783875.1 |
| D.balsameus | SRX20502826 | GCA_032353675.1 |
| D.campi | SRX21425398 | GCA_033118305.1 |
| D.carolinensis | SRX19952691 | GCA_031753635.1 |
| D.catahoula | SRX21425399 | GCA_034783935.1 |
| D.cheaha | SRX20502857 | GCA_032353815.1 |
| D.conanti | SRX19953420 | GCA_030264475.1 |
| D.folkertsi | SRX19952891 | GCA_030265015.1 |
| D.fuscus | SRX19953421 | GCA_030265095.1 |
| D.gvingeusgwotli | SRX20502827 | GCA_032353775.1 |
| D.imitator | SRX19953983 | GCA_030264435.1 |
| D.intermedius | SRX20502776 | GCA_032275315.1 |
| D.kanawha | SRX20502939 | GCA_032353855.1 |
| D.lycos | SRX21425400 | GCA_035049765.1 |
| D.marmoratus | SRX19954879 | GCA_031753695.1 |
| D.mavrokoilius | SRX20503049 | GCA_032354855.1 |
| D.monticola | SRX19955091 | GCA_031753675.1 |
| D.ochrophaeus | SRX19958874 | GCA_030264935.1 |
| D.ocoee | SRX19952863 | GCA_030264995.1 |
| D.orestes | SRX19952890 | GCA_030264915.1 |
| D.organi | SRX19952929 | GCA_030180145.1 |
| D.pascagoula | SRX19953381 | GCA_030264975.1 |
| D.perlapsus | SRX20503048 | GCA_032275285.1 |
| D.planiceps | SRX20497025 | GCA_032353935.1 |
| D.santeetlah | SRX19955089 | GCA_031753655.1 |
| D.tilleyi | SRX21394251 | GCA_034782015.1 |
| D.valentinei | SRX19953382 | GCA_030264875.1 |
| D.valtos | SRX20503015 | GCA_032357565.1 |
| D.welteri | SRX19958882 | GCA_030264495.1 |
| D.wrighti | SRX19958881 | GCA_030265035.1 |

## Directory Strucuture
project_root/
│
├── workflows/
│   ├── main.nf
│   ├── download_genomes.nf
│   ├── script2.nf
│   ├── script3.nf
│   └── ...
│
├── configs/
│   └── nextflow.config
│
├── bin/
│   └── (any custom scripts or binaries)
│
└── data/
    └── Lookup_table.txt

## Software
-dnaPipeTE
-Dante
-genometools
-bowtie2
-samtools
-sratoolkit
-ncbi-cli-dataset
-fastp
-faSplit
-bedtools
